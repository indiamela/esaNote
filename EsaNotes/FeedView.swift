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
            // カテゴリ
            // フォルダ
        }
        .navigationBarTitle(Text("Feed"), displayMode: .inline)
        .navigationBarItems(
            leading: Image(systemName: "person.fill")
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
