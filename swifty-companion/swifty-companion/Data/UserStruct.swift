//
//  UserStruct.swift
//  swifty-companion
//
//  Created by Théo Ajavon on 29/04/2024.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let email: String
    let login: String
    let phone: String?
    let correction_point: Int
    let pool_month: String
    let pool_year: String
    let location: String?
    let wallet: Int
    let projects_users: [Project_user]
    let cursus_users: [Cursus_user]
}

struct Project_user: Codable, Identifiable {
    let id: Int
    let occurrence: Int
    let final_mark: Int?
    let status: String
    let validated: Bool?
    let project: Project
    let marked_at: String?
    let marked: Bool
    let retriable_at: String?
    let created_at: String?
    let updated_at: String?
}

struct Project: Codable, Identifiable {
    let id: Int
    let name: String
    let slug: String
}

struct Cursus_user: Codable {
    let grade: String?
    let level: Double
    let skills: [Skill]
}

struct Skill: Codable {
    let id: Int
    let name: String
    let level: Double
}
