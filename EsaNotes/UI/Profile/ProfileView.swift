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
    let iconURL: URL?

    var body: some View {
        VStack{
            HStack {
                MyImage.asyncImage(url: iconURL)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(userName)
                    .font(.title2)
                    Text(screenName)
                }
            }
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(userName: "Taishi Kuausnose",
                        screenName: "@Indi",
                        iconURL: URL(string: "https://img.esa.io/uploads/production/members/116423/icon/thumb_l_4289f52880cd9110af0f51948764e9e4.JPG")
            )
                .navigationBarTitle(Text("Feed"), displayMode: .inline)
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading) {
                        MyImage.asyncImage(url: URL(string: ""))
                            .frame(width: 25, height: 25)
                            .clipShape(Circle())
                    }
                }
        }
    }
}
