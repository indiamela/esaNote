//
//  CategoryContent.swift
//  EsaNotes
//
//  Created by Taishi Kusunose on 2022/01/11.
//

import SwiftUI

struct CategoryContent: View {
    var body: some View {
        VStack {
            HStack {
                categoryButton(for: .all)
                categoryButton(for: .stars)
            }
            HStack {
                categoryButton(for: .wip)
                categoryButton(for: .shipped)
            }
        }
    }
}

extension CategoryContent {
    func categoryButton(for category: Category) -> some View {
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
        CategoryContent()
            .previewLayout(.sizeThatFits)
    }
}
