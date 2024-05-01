//
//  intra.swift
//  swifty-companion
//
//  Created by Théo Ajavon on 22/04/2024.
//

import Foundation

// OAuth2Manager.swift
//import OAuthSwift

struct EnvKey {
    let uid: String
    let secret: String
}

func getCurrentCursus(all_cursus: [Cursus_user]) -> Cursus_user? {
    for cursus in all_cursus {
        if (cursus.grade != nil) {
            return cursus
        }
    }
    return nil
}

func fetchUserList(token: Token, login: String) async -> [UserListItem] {
    guard let url = URL(string: "https://api.intra.42.fr/v2/users?range%5Blogin%5D=\(login.lowercased()),\(login.lowercased())z") else { return [] }
    var request = URLRequest(url: url)
    request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        let dataDecode = try JSONDecoder().decode([UserListItem].self, from: data)
    } catch {
        print("Error while fetching users : \(error)")
    }
    return []
}

func makeRequestsWithToken(token: Token) async {
    guard let url = URL(string: "https://api.intra.42.fr/v2/users?range%5Blogin%5D=ale,alez") else { return }
    var request = URLRequest(url: url)
    request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        print(data)
        let dataDecode = try decoder.decode([UserListItem].self, from: data)
        print(dataDecode)
    } catch {
        print("Failed in URLSession : \(error)")
    }
}

func getEnvKey() -> EnvKey? {
    var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
    var plistData: [String: AnyObject] = [:]
    guard let plistPath: String = Bundle.main.path(forResource: "env", ofType: "plist") else {
        print("File not found !")
        return nil
    }
    let plistXML = FileManager.default.contents(atPath: plistPath)!
    do {
        plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
        
        guard let uid = plistData["UID"] else { return nil }
        guard let secret = plistData["SECRET"] else { return nil }
        
        let envKey = EnvKey(uid: uid as! String, secret: secret as! String)
        return envKey

    } catch {
        print("Error reading plist: \(error), format: \(propertyListFormat)")
        return nil
    }
}

class IntraAPI: ObservableObject {
    @Published var token: Token?
    @Published var isFetchingToken = false
    
    static let shared = IntraAPI()
    
    func getToken() async {
        guard let envKey = getEnvKey() else {
            print("404: Env key not found.")
            return
        }

        guard let url = URL(string: "https://api.intra.42.fr/oauth/token") else {
            print("Unavailable URL.")
            return
        }
        let body = "grant_type=client_credentials&client_id=\(envKey.uid)&client_secret=\(envKey.secret)"

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body.data(using: String.Encoding.utf8)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let tmp = try decoder.decode(Token.self, from: data)
            DispatchQueue.main.async {
                IntraAPI.shared.token = tmp
                print(IntraAPI.shared.token ?? "Unexist token.")
            }
//            await makeRequestsWithToken(token: token!)
        } catch {
            print("Failed while fetching token : \(error)")
        }
    }
    
    func checkTokenExpirationTime() async {
        if (token == nil) {
            print("The token is not defined.")
            Task {
                await getToken()
            }
        } else {
            guard let url = URL(string: "https://api.intra.42.fr/oauth/token/info") else { return }
            var request = URLRequest(url: url)
            request.setValue("Bearer \(token!.access_token)", forHTTPHeaderField: "Authorization")
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let infoToken = try JSONDecoder().decode(TokenInfo.self, from: data)

                if (infoToken.expires_in_seconds <= 120) { // Only 2 minutes left
                    print("The token will soon expired... Time left : \(infoToken.expires_in_seconds)")
                    await getToken()
                } else {
                    print("Everything looks good ! Time left : \(infoToken.expires_in_seconds)")
                }
            } catch {
                print("Failed during fetch of token info : \(error)")
                await getToken()
            }
        }
    }
}
