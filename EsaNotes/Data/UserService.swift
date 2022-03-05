//
//  UserService.swift
//  EsaNotes
//
//  Created by taishi.kusunose on 2022/03/05.
//

import Foundation

struct UserService {
    static func fetchUser() async throws -> User {
        let path = "/v1/user"
        let netWorkRequest = NetworkRequest()
        return try await netWorkRequest.start(path: path, method: .get)
    }
}
