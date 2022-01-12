//
//  CategoryContent.swift
//  EsaNotes
//
//  Created by Taishi Kusunose on 2022/01/11.
//

import SwiftUI

struct PostStatusContent: View {
    var body: some View {
        VStack {
            HStack {
                postStatusButton(for: .all)
                postStatusButton(for: .stars)
            }
            HStack {
                postStatusButton(for: .wip)
                postStatusButton(for: .shipped)
            }
        }
    }
}

extension PostStatusContent {
    func postStatusButton(for category: PostStatus) -> some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 100)
                .foregroundColor(MyColor.esaGray)
                .overlay{
                    VStack {
                        HStack {
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundColor(category.color)
                                .overlay{
                                    category.image
                                        .foregroundColor(MyColor.esaGray)
                                }
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            Text(category.rawValue)
                            Spacer()
                        }
                    }
                    .padding()
                }
        }
    }
}

struct CategoryContent_Previews: PreviewProvider {
    static var previews: some View {
        PostStatusContent()
            .previewLayout(.sizeThatFits)
    }
}
