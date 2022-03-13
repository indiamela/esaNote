//
//  ContentView.swift
//  EsaNotes
//
//

import SwiftUI
import Combine

@MainActor
struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    var body: some View {
        let state = viewModel.state
        NavigationView{
            TabView {
                FeedView()
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                ProfileView(
                    userName: state.userName,
                    screenName: state.screenName,
                    iconURL: state.iconURL
                )
                    .tabItem {
                        Image(systemName: "person.fill")
                    }
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                PostView()
                    .tabItem {
                        Image(systemName: "square.and.pencil")
                    }
            }
            .navigationBarTitle(Text("Feed"), displayMode: .inline)
            .navigationBarItems(leading:leadingTabbarItem, trailing: trailingTabbarItem)
        }
        .font(.headline)
        .fullScreenCover(isPresented: viewModel.shouldLogIn){
            LogInView()
        }
        .onChange(of: state.isLoggedIn) { isLoggedIn in
            guard isLoggedIn else { return }
            Task {
                await viewModel.fetchUserProfile()
            }
        }
    }
}

extension ContentView {
    var leadingTabbarItem: some View {
        let state = viewModel.state
        return MyImage.asyncImage(url: state.iconURL)
            .frame(width: 25, height: 25)
            .clipShape(Circle())
    }

    var trailingTabbarItem: some View {
        Menu {
            Button("LogOut", action: {viewModel.logOut()})
        } label: {
            Image(systemName: "ellipsis.circle")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
