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
    static func asyncImage(url: URL?) -> some View{
        return AsyncImage(url: url) { phase in
             switch phase {
             case .success(let image):
                 image
                     .resizable()
                     .aspectRatio(contentMode: .fit)
             case .empty:
                 ProgressView()
             default:
                 EmptyView()
             }
         }
     }
}

struct MyColor {
    static let esaOrange = Color("esaOrange")
    static let esaGreen = Color("esaGreen")
    static let esaGray = Color("esaGray")
}
