//
//  Post.swift
//  EsaNotes
//
//  Created by taishi.kusunose on 2022/03/20.
//

import Foundation

// MARK: - Welcome
struct Posts: Codable {
    let posts: [Post]
    let prevPage, nextPage: Int?
    let totalCount, page, perPage, maxPerPage: Int

    enum CodingKeys: String, CodingKey {
        case posts
        case prevPage = "prev_page"
        case nextPage = "next_page"
        case totalCount = "total_count"
        case page
        case perPage = "per_page"
        case maxPerPage = "max_per_page"
    }
}

// MARK: - Post
struct Post: Codable {
    let number: Int
    let name, fullName: String
    let wip: Bool
    let bodyMd, bodyHTML: String
    let createdAt: Date
    let message: String
    let url: String
    let updatedAt: Date
    let tags: [String]
    let category: String
    let revisionNumber: Int
    let createdBy, updatedBy: Editor

    enum CodingKeys: String, CodingKey {
        case number, name
        case fullName = "full_name"
        case wip
        case bodyMd = "body_md"
        case bodyHTML = "body_html"
        case createdAt = "created_at"
        case message, url
        case updatedAt = "updated_at"
        case tags, category
        case revisionNumber = "revision_number"
        case createdBy = "created_by"
        case updatedBy = "updated_by"
    }
}

// MARK: - AtedBy
struct Editor: Codable {
    let myself: Bool
    let name, screenName: String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case myself, name
        case screenName = "screen_name"
        case icon
    }
}
