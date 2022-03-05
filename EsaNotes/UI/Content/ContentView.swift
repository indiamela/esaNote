//
//  ContentView.swift
//  EsaNotes
//
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    var body: some View {
        let state = viewModel.state
        TabView {
            NavigationView {
                FeedView()
            }
            .tabItem {
                Image(systemName: "list.dash.header.rectangle")
            }
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                }
            ProfileView()
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
        .font(.headline)
        .task {
            if state.isLoggedIn {

            }
        }
        .fullScreenCover(isPresented: viewModel.shouldLogIn) {
            LogInView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
