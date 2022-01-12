//
//  Enums&Structs.swift
//  EsaNotes
//
//

import Foundation
import SwiftUI

struct MyImage {
    // esa
    static let logoWhite = Image("esa-logo_coloredbg")
    static let logoGray = Image("esa-logo_whitebg")
    static let toriWhite = Image("esa-tori_coloredbg")
    static let toriGray = Image("esa-tori_whitebg")
}

struct MyColor {
    static let esaOrange = Color("esaOrange")
    static let esaGreen = Color("esaGreen")
    static let esaGray = Color("esaGray")
}

enum PostStatus: String {
    case all = "All Documents"
    case stars = "Stared"
    case wip = "WIP"
    case shipped = "Shipped"

    var color: Color {
        switch self {
        case .all:
            return Color.gray
        case .stars:
            return Color.yellow
        case .wip:
            return Color.blue
        case .shipped:
            return Color.red
        }
    }

    var image: Image {
        switch self {
        case .all:
            return Image(systemName: "doc.text.fill")
        case .stars:
            return Image(systemName: "star.fill")
        case .wip:
            return Image(systemName: "archivebox.fill")
        case .shipped:
            return Image(systemName: "paperplane.fill")
        }
    }
}
