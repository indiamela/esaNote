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
        Button {
            viewModel.signIn()
        } label: {
            Text("Log in")
        }
        .onChange(of: viewModel.isSuccess) { success in
            if success {
                dismiss()
            }
        }
    }
}

struct OathView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
