//
//  AuthorizeToken.swift
//  EsaNotes
//
//

import Foundation

// MARK: - AuthorizeToken
struct AuthorizeToken: Codable {
    let accessToken, tokenType, scope: String
    let createdAt: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope
        case createdAt = "created_at"
    }
}
