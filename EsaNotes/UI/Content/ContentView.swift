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
                        Image(systemName: "home.fill")
                    }
                    .navigationBarTitle(Text("Feed"), displayMode: .inline)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading) {
                            MyImage.asyncImage(url: state.iconURL)
                                .frame(width: 25, height: 25)
                                .clipShape(Circle())
                        }
                    }
//                CalendarView()
//                    .tabItem {
//                        Image(systemName: "calendar")
//                    }
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
        }
        .font(.headline)
        .fullScreenCover(isPresented: viewModel.shouldLogIn, onDismiss: {
            Task {
                await viewModel.fetchUserProfile()
            }
        }){
            LogInView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
