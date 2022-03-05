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
        TabView {
            NavigationView {
                FeedView()
                    .navigationBarTitle(Text("Feed"), displayMode: .inline)
                    .navigationBarItems(
                        leading:
                            AsyncImage(url: state.iconURL) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                case .empty:
                                    ProgressView()
                                default:
                                    EmptyView()
                                }
                            },
                        trailing:
                            Button {
                                Task {
                                    viewModel.logOut()
                                }
                            } label: {
                                Image(systemName: "person.fill")
                            }
                    )
                    .tabItem {
                        Image(systemName: "list.dash.header.rectangle")
                    }
            }

            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                }
            ProfileView(
                userName: state.userName,
                screenName: state.screenName,
                email: state.email
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
        .font(.headline)
        .fullScreenCover(isPresented: viewModel.shouldLogIn, onDismiss: {
            Task {
                await viewModel.fetchUserProfile()
            }
        }, content: {
            LogInView()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
