//
//  ContentViewModel.swift
//  EsaNotes
//
//  Created by taishi.kusunose on 2022/03/05.
//

import SwiftUI

@MainActor
final class ContentViewModel: ObservableObject {
    @Published private(set) var state: ContentUiState
    var shouldLogIn: Binding<Bool> {
        Binding(get: { !self.state.isLoggedIn },
                set: { self.state.isLoggedIn = !$0})
    }
    private let userRepository: UserRepository

    init(
        state: ContentUiState = .init(),
        userRepository: UserRepository = UserRepositoryImpl()
    ){
        self.state = state
        self.userRepository = userRepository
    }

    func fetchUserProfile() async {
        guard state.isLoggedIn else { return }
        await getUser()
    }

    func logOut() {
        clearUser()
        state.isLoggedIn = false
    }

    private func getUser() async {
        do {
            let user = try await userRepository.getUser()
            state.userName = user.name
            state.screenName = user.screenName
            state.email = user.email
            state.iconURL = URL(string: user.icon ?? "")
        } catch {
            print(error)
        }
    }

    private func clearUser() {
        state.userName = ""
        state.screenName = ""
        state.email = nil
        state.iconURL = nil
    }
}
