//
//  AuthRepository.swift
//  EsaNotes
//
//  Created by taishi.kusunose on 2022/02/26.
//

import Foundation

protocol AuthRepository: AnyObject {
    func logIn() async throws
}

final class AuthRepositoryImpl: AuthRepository {
    private let authService: AuthService = .init()
    func logIn() async throws {
        try await authService.lognIn()
    }
}
