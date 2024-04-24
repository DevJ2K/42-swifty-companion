//
//  intra.swift
//  swifty-companion
//
//  Created by Théo Ajavon on 22/04/2024.
//

import Foundation

// OAuth2Manager.swift
//import OAuthSwift

struct Token: Decodable {
    let access_token: String
    let token_type: String
    let expires_in: Int
    let scope: String
    let created_at: Int
}

struct UsersList: Codable
{
    var results: [UserListItem]
}

struct UserListItem: Codable {
    var id: Int
    var login: String
    var url: String
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

func getEnvVariables() -> [String: AnyObject]? {
    var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
    var plistData: [String: AnyObject] = [:] //Our data
    guard let plistPath: String = Bundle.main.path(forResource: "env", ofType: "plist") else {
        print("File not found !")
        return nil
    } //the path of the data
    let plistXML = FileManager.default.contents(atPath: plistPath)!
    do {//convert the data to a dictionary and handle errors.
        plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
        return plistData

    } catch {
        print("Error reading plist: \(error), format: \(propertyListFormat)")
        return nil
    }
}


func handleIntraAuth() async {
    // Create OAuth2 client
    let envVariable = getEnvVariables()
    guard let clientKey = envVariable?["UID"] else {
        print("404: Client key not found !")
        return
    }
    guard let clientSecret = envVariable?["SECRET"] else {
        print("404: Secret key not found !")
        return
    }

    guard let url = URL(string: "https://api.intra.42.fr/oauth/token") else {
        print("Unavailable URL.")
        return
    }
    let body = "grant_type=client_credentials&client_id=\(clientKey)&client_secret=\(clientSecret)"

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = body.data(using: String.Encoding.utf8)
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let token = try decoder.decode(Token.self, from: data)
        print(token)
        await makeRequestsWithToken(token: token)
    } catch {
        print("Failed in URLSession : \(error)")
    }
}


class IntraAPI: ObservableObject {
    @Published var token: Token?
    
    func getToken() async {
        // Create OAuth2 client
        let envVariable = getEnvVariables()
        guard let clientKey = envVariable?["UID"] else {
            print("404: Client key not found !")
            return
        }
        guard let clientSecret = envVariable?["SECRET"] else {
            print("404: Secret key not found !")
            return
        }

        guard let url = URL(string: "https://api.intra.42.fr/oauth/token") else {
            print("Unavailable URL.")
            return
        }
        let body = "grant_type=client_credentials&client_id=\(clientKey)&client_secret=\(clientSecret)"

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body.data(using: String.Encoding.utf8)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            token = try decoder.decode(Token.self, from: data)
            print(token ?? "Unexist token.")
            await makeRequestsWithToken(token: token!)
        } catch {
            print("Failed in URLSession : \(error)")
        }
    }
}