//
//  UsersStruct.swift
//  swifty-companion
//
//  Created by Théo Ajavon on 29/04/2024.
//

import Foundation


struct UsersList: Codable
{
    var results: [UserListItem]
}

struct UserListItem: Identifiable, Codable {
    let id: Int
    let email: String
    let login: String
    let url: String
    let phone: String?
    let correction_point: Int
    let pool_month: String
    let pool_year: String
    let location: String?
    let wallet: Int
}
