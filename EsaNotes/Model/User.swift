//
//  User.swift
//  EsaNotes
//
//

import Foundation

// MARK: - Welcome
struct User: Codable {
    let id: Int
    let name, screenName: String
    let createdAt, updatedAt: String
    let icon: String?
    let email: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case icon, email
    }
}

// MARK: - Team
struct Team: Codable {
    let name, privacy, teamDescription: String
    let icon: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, privacy
        case teamDescription = "description"
        case icon, url
    }
}
