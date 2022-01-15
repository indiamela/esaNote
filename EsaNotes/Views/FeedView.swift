//
//  FeedView.swift
//  EsaNotes
//
//  Created by Taishi Kusunose on 2022/01/04.
//

import SwiftUI

struct FeedView: View {
    let viewModel = FeedViewModel()
    var body: some View {
        VStack {
            // カテゴリ
            PostStatusContent()
                .padding()
            // フォルダ
            List {
                Section(header: Text("Folder")) {
                    ForEach (viewModel.posts) { content in
                        NavigationLink {

                        } label: {
                            Text(content.category ?? "No category")
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
        .navigationBarTitle(Text("Feed"), displayMode: .inline)
        .navigationBarItems(
            leading:
                AsyncImage(url: URL(string: SharedData.shared.icon ?? "")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                    } else {
                        ProgressView()
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
