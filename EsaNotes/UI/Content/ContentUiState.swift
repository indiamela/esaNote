//
//  ContentUiState.swift
//  EsaNotes
//
//  Created by taishi.kusunose on 2022/03/05.
//

import Foundation
import SwiftUI

struct ContentUiState: Equatable {
    var isLoading: Bool = true
    var isLoggedIn: Bool = false
    var userName: String = ""
    var screenName: String = ""
    var iconURL: URL? = nil
    var email: String? = nil

    mutating func clearAcount() {
        self.userName = ""
        self.screenName = ""
        self.email = nil
        self.iconURL = nil
        SharedData.shared.accessToken = nil
    }
}
