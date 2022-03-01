//
//  SignInViewModel.swift
//  EsaNotes
//
//

import Foundation
import Combine
import AuthenticationServices

@MainActor
final class SignInViewModel: ObservableObject {
    @Published private(set) var state: SigninUiState

    private var authRepository: AuthRepository

    init(
        state: SigninUiState = .init(),
        authRepository: AuthRepository = AuthRepositoryImpl()
    ) {
        self.state = state
        self.authRepository = authRepository
    }

    func onSignInButtonDidTap() async {
        do {
            state.isLoading = true
            try await authRepository.signIn()
            state.isLoading = false
            state.showHomeView = true
        } catch {
            print(error)
            state.isLoading = false
        }
    }
}
