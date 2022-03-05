//
//  UserRepository.swift
//  EsaNotes
//
//  Created by taishi.kusunose on 2022/03/05.
//

import Foundation

protocol UserRepository: AnyObject {
    func getUser() async throws -> User
}

final class UserRepositoryImpl: UserRepository {
    func getUser() async throws -> User {
        return try await UserService.fetchUser()
    }
}
