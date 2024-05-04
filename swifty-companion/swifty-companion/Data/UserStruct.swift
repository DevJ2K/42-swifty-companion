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
    var coalitions: [Coalition]?
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
    let cursus_ids: [Int]
    let retriable_at: String?
    let created_at: String?
    let updated_at: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case occurrence
        case final_mark
        case status
        case validated = "validated?"

        case project
        case marked_at
        case marked
        case cursus_ids
        case retriable_at
        case created_at
        case updated_at
    }
    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        validated = try container.decode(String.self, forKey: .validated)
//    }
}

//extension Project_user: Decodable {
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        validated = try values.decode(Bool.self, forKey: .validated)
//    }
//}

struct Project: Codable, Identifiable {
    let id: Int
    let name: String
    let slug: String
}

struct Cursus_user: Codable {
    let grade: String?
    let level: Double
    let cursus_id: Int
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
