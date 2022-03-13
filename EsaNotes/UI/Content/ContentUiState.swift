//
//  ContentUiState.swift
//  EsaNotes
//
//  Created by taishi.kusunose on 2022/03/05.
//

import Foundation
import SwiftUI

struct ContentUiState: Equatable {
    var user: User?
    var isLoading: Bool = true
    var isLoggedIn: Bool = false
    var userName: String {
        return user?.name ?? ""
    }
    var screenName: String {
        user?.screenName ?? ""
    }
    var iconURL: URL? {
        return URL(string: user?.icon ?? "")
    }
    var email: String? {
        return user?.email ?? ""
    }
}
