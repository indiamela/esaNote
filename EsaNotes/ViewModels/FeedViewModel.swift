//
//  FeedViewModel.swift
//  EsaNotes
//
//

import Foundation
import SwiftUI

class FeedViewModel: ObservableObject {
    @Published private(set) var posts: [Post]

    init(posts: [Post] = [
        // swiftlint:disable:next line_length
        Post(id: 1, name: "AAAAA", fullName: "Taishi", wip: true, bodyMd: "", bodyHTML: "", createdAt: "", message: "", url: "", updatedAt: "", tags: [""], category: "日報", revisionNumber: 1, createdBy: nil, updatedBy: nil),
        // swiftlint:disable:next line_length
        Post(id: 2, name: "BBBBB", fullName: "Taishi", wip: true, bodyMd: "", bodyHTML: "", createdAt: "", message: "444/666", url: "", updatedAt: "", tags: [""], category: "エラー解決", revisionNumber: 1, createdBy: nil, updatedBy: nil),
        // swiftlint:disable:next line_length
        Post(id: 3, name: "CCCCC", fullName: "Taishi", wip: true, bodyMd: "", bodyHTML: "", createdAt: "", message: "ttt/ddd", url: "", updatedAt: "", tags: [""], category: "社内通知", revisionNumber: 1, createdBy: nil, updatedBy: nil),
        // swiftlint:disable:next line_length
        Post(id: 4, name: "AAAAA", fullName: "Taishi", wip: true, bodyMd: "", bodyHTML: "", createdAt: "", message: "", url: "", updatedAt: "", tags: [""], category: "あとで読む", revisionNumber: 1, createdBy: nil, updatedBy: nil),
        // swiftlint:disable:next line_length
        Post(id: 5, name: "BBBBB", fullName: "Taishi", wip: true, bodyMd: "", bodyHTML: "", createdAt: "", message: "444/666", url: "", updatedAt: "", tags: [""], category: "課題解決", revisionNumber: 1, createdBy: nil, updatedBy: nil),
        // swiftlint:disable:next line_length
        Post(id: 6, name: "CCCCC", fullName: "Taishi", wip: true, bodyMd: "", bodyHTML: "", createdAt: "", message: "ttt/ddd", url: "", updatedAt: "", tags: [""], category: "雑談", revisionNumber: 1, createdBy: nil, updatedBy: nil)
    ]
    ) {
        self.posts = posts
    }
}
