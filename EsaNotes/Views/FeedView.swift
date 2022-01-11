//
//  FeedView.swift
//  EsaNotes
//
//  Created by Taishi Kusunose on 2022/01/04.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        VStack {
            Text(SharedData.shared.userName ?? "noName")
            Text(SharedData.shared.email ?? "")
            Text(SharedData.shared.icon ?? "")
            Text(SharedData.shared.screenName ?? "")

            // カテゴリ
            // フォルダ
            Button {
                NetworkRequest.signOut()
            } label: {
                Text("sign out")
            }

        }
        .navigationBarTitle(Text("Feed"), displayMode: .inline)
        .navigationBarItems(
            leading:
                AsyncImage(url: URL(string: SharedData.shared.icon ?? "")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                    } else {
                        Image(systemName: "person.fill")
                    }
                }
        )
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FeedView()
        }
    }
}
