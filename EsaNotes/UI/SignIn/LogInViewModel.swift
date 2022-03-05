//
//  LoginViewModel.swift
//  EsaNotes
//
//

import Foundation

@MainActor
final class LogInViewModel: ObservableObject {
    @Published private(set) var state: LoginUiState

    private var authRepository: AuthRepository

    init(
        state: LoginUiState = .init(),
        authRepository: AuthRepository = AuthRepositoryImpl()
    ) {
        self.state = state
        self.authRepository = authRepository
    }

    func onLogInButtonDidTap() async {
        do {
            state.isLoading = true
            try await authRepository.logIn()
            SharedData.shared.isLoggedIn = true
            state.isLoading = false
            state.showHomeView = true
        } catch {
            print(error)
            state.isLoading = false
        }
    }
}
