//
//  UserStruct.swift
//  swifty-companion
//
//  Created by Théo Ajavon on 29/04/2024.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let email: String?
    let login: String
    let phone: String?
    let correction_point: Int
    let pool_month: String?
    let pool_year: String?
    let location: String?
    let image: User_image
    let wallet: Int
    let projects_users: [Project_user]
    let cursus_users: [Cursus_user]
    let coalitions: [Coalition]?
}

struct User_image: Codable {
    let link: String?
    let versions: User_image_version
}

struct User_image_version: Codable {
    let large: String?
    let medium: String?
    let small: String?
    let micro: String?
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

struct Coalition: Codable, Identifiable {
    let id: Int
    let name: String
    let slug: String
    let image_url: String
    let cover_url: String
    let color: String
    let score: Int
}
