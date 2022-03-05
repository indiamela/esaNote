//
//  OathView.swift
//  EsaNotes
//
//  Created by Taishi Kusunose on 2022/01/04.
//

import SwiftUI

@MainActor
struct LogInView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = LogInViewModel()
    var body: some View {
        let state = viewModel.state
        VStack{
            Image("esaNote")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
            Button(action: {
                Task {
                    await viewModel.onLogInButtonDidTap()
                }
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
                .padding(20)
            })
                .accentColor(Color.black)
        }
        .onChange(of: state.showHomeView) { success in
            if success {
                dismiss()
            }
        }
    }
}

struct OathView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
