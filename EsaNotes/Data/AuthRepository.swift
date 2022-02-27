//
//  AuthRepository.swift
//  EsaNotes
//
//  Created by taishi.kusunose on 2022/02/26.
//

import Foundation

protocol AuthRepository: AnyObject {
    func signIn() async throws
}

final class AuthRepositoryImpl: AuthRepository {
    private let authService: AuthService = .init()
    func signIn() async throws {
        try await authService.signIn()
    }
}
