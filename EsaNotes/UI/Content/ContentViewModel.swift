//
//  ContentViewModel.swift
//  EsaNotes
//
//  Created by taishi.kusunose on 2022/03/05.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    @Published private(set) var state: ContentUiState
    var showSigninView: Binding<Bool> {
        Binding(get: { self.state.shouldLogin },
                set: { self.state.shouldLogin = $0})
    }

    init(
        state: ContentUiState = .init()
    ){
        self.state = state
    }
}
