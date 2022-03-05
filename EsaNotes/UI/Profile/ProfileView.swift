//
//  ProfileView.swift
//  EsaNotes
//
//  Created by Taishi Kusunose on 2022/01/04.
//

import SwiftUI

struct ProfileView: View {
    let userName: String
    let screenName: String
    let email: String?

    var body: some View {
        VStack {
            Text(userName)
            Text(email ?? "")
            Text(screenName)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userName: "", screenName: "", email: "")
    }
}
