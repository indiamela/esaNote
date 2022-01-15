import Foundation
import SwiftUI

// MARK: - Category
struct PostList: Codable {
    let posts: [Post]
    let prevPage, nextPage, totalCount, page: Int?
    let perPage, maxPerPage: Int?

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
struct Post: Codable, Identifiable {
    let id: Int
    let name, fullName: String
    let wip: Bool
    let bodyMd, bodyHTML: String?
    let createdAt: String
    let message: String?
    let url: String
    let updatedAt: String
    let tags: [String]
    let category: String?
    let revisionNumber: Int
    let createdBy, updatedBy: Editor?

    enum CodingKeys: String, CodingKey {
        case id = "number"
        case name
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

// MARK: - Editor
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

//struct Categories {
//    let items: [CategoryItem]?
//    struct CategoryItem: Hashable, Identifiable {
//        var id: Self { self }
//        var name: String
//        var children: [CategoryItem]? = nil
//    }
//    func updateItems(_ text: String?) {
//        guard let categories = text?.components(separatedBy:"/") else {
//            return
//        }
//    }
//}
