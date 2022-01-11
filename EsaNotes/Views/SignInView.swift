//
//  OathView.swift
//  EsaNotes
//
//  Created by Taishi Kusunose on 2022/01/04.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = SignInViewModel()
    var body: some View {
        VStack{
            Image("esaNote")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
            Button(action: {
                viewModel.signIn()
            }, label: {
                HStack{
                    MyImage.toriGray
                        .resizable()
                        .scaledToFit()
                    Text("Sign in with esa.io")
                }
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(MyColor.esaGreen)
                .cornerRadius(6)
                .font(.system(size: 25, weight: .medium, design: .default))
                .padding()
            })
                .accentColor(Color.black)
        }
    }
}

struct OathView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
