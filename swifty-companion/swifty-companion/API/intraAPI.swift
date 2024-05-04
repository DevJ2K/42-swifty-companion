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
    if (all_cursus.isEmpty) {
        return nil
    } else {
        return all_cursus.first
    }
}

func fetchUserList(token: Token, login: String) async -> [UserListItem] {
    guard let url = URL(string: "https://api.intra.42.fr/v2/campus/1/users?range[login]=\(login.lowercased().trimmingCharacters(in: .whitespaces)),\(login.lowercased().trimmingCharacters(in: .whitespaces))z&filter[staff?]=false") else { return [] }
    var request = URLRequest(url: url)
    request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        let dataDecode = try JSONDecoder().decode([UserListItem].self, from: data)
        return dataDecode
    } catch {
        print("Error while fetching users : \(error)")
    }
    return []
}

func fetchUserCoalitions(token: Token, login: String) async -> [Coalition]? {
    guard let url = URL(string: "https://api.intra.42.fr/v2/users/\(login.lowercased().trimmingCharacters(in: .whitespaces))/coalitions") else { return nil }
    var request = URLRequest(url: url)
    request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        let dataDecode = try JSONDecoder().decode([Coalition].self, from: data)
        return dataDecode
    } catch {
        print("Error while fetching user : \(error)")
    }
    return nil
}

func fetchUser(token: Token, login: String) async -> User? {
    guard let url = URL(string: "https://api.intra.42.fr/v2/users/\(login.lowercased().trimmingCharacters(in: .whitespaces))") else { return nil }
    var request = URLRequest(url: url)
    request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        let dataDecode = try JSONDecoder().decode(User.self, from: data)
        return dataDecode
    } catch {
        print("Error while fetching user : \(error)")
    }
    return nil
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
    private var token: Token?

    @Published var isFetchingToken = false
    @Published var isFetchingUserList = false
    @Published var isFetchingUser = false
    @Published var userList: [UserListItem] = []
    
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
            token = try decoder.decode(Token.self, from: data)
            print(token ?? "Unexist token.")
        } catch {
            print("Failed while fetching token : \(error)")
        }
    }
    
    func checkTokenExpirationTime() async {
        if (token == nil) {
            print("The token is not defined.")
            await getToken()
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
    
    func findUsersByLogin(login: String) async {
        // Update isFetching... loader in DispatchQueue to update the view.
        DispatchQueue.main.async {
            self.isFetchingUserList = true
        }
        await checkTokenExpirationTime()
        guard let token = token else {
            print("Failed to renew the token")
            DispatchQueue.main.async {
                self.isFetchingUserList = false
            }
            return
        }
        print("The token was successfully retrieved !")
//        return
        print("Fetching users list startswith : \(login)")
        let userListResult = await fetchUserList(token: token, login: login)
        DispatchQueue.main.async {
            self.userList = userListResult
            self.isFetchingUserList = false
        }
        print("End of fetching users.")
    }
    
    func fetchUserByLogin(login: String) async -> User? {
//        DispatchQueue.main.async {
//            self.isFetchingUser = true
//        }
        await checkTokenExpirationTime()
        guard let token = token else {
            print("Failed to renew the token")
//            DispatchQueue.main.async {
//                self.isFetchingUserList = false
//            }
            return nil
        }
        var user = await fetchUser(token: token, login: login)
        if (user == nil) {
            return nil
        }
        user?.coalitions = await fetchUserCoalitions(token: token, login: login)
//        print("Fetching user : \(user)")
//        DispatchQueue.main.async {
//            self.isFetchingUser = false
//        }
        return user
    }
}

import SwiftUI
#Preview {
    ContentView()
//    ProfileView(login: "tajavon")
}
