//
//  ContentView.swift
//  EsaNotes
//
//

import SwiftUI

struct ContentView: View {
    @State private var isLogOut = false
    var body: some View {
        TabView {
            FeedView()
                .badge(10)
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
        .fullScreenCover(isPresented: $isLogOut) {
            OnboadingView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
