//
//  TokenStruct.swift
//  swifty-companion
//
//  Created by Théo Ajavon on 29/04/2024.
//

import Foundation

struct Token: Decodable {
    let access_token: String
    let token_type: String
    let expires_in: Int
    let scope: String
    let created_at: Int
}

struct TokenInfo: Decodable {
    let expires_in_seconds: Int
}
