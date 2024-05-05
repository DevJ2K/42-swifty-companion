//
//  ContentView.swift
//  swifty-companion
//
//  Created by Théo Ajavon on 22/04/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var intraAPI = IntraAPI.shared
    @Environment(\.colorScheme) private var colorScheme
    
    func isLightMode() -> Bool {
        return (colorScheme == .light)
    }
    @State var searchText = ""
    @State private var lastSearch = ""
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)
                    TextField("Search an user...", text: $searchText)
                        .autocorrectionDisabled()
                        .submitLabel(.search)
                        .onChange(of: searchText) { newValue in
                            if (newValue.count >= 20) {
                                let _ = searchText.popLast()
                            }
                        }
                        .onSubmit {
                            print("The user to search : \(searchText)")
                            if (searchText.isEmpty) {
                                return
                            }
                            Task {
                                await intraAPI.findUsersByLogin(login: searchText)
                                lastSearch = searchText
                            }
                        }
                }
                .font(.headline)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(isLightMode() ? .white : .black)
                        .shadow(
                            color: isLightMode() ? .black.opacity(0.2) : .white.opacity(0.2),
                            radius: 10, x: 0, y: 0)
                )
                .padding()
                if (intraAPI.isFetchingUserList == false) {
                    if (intraAPI.userList.isEmpty == false || lastSearch.isEmpty) {
                        ScrollView {
                            ForEach(intraAPI.userList, id: \.id) { user in
                                NavigationLink {
                                    ProfileView(login: user.login)
                                } label: {
                                    SearchCell(item: user)
                                }
                            }
                        }
                    } else {
                        VStack {
                            Rectangle()
                                .opacity(0)
                                .frame(height: 50)
                            Image(systemName: "magnifyingglass")
                                .opacity(0.7)
//                                .bold()
                                .font(.system(size: 48))
                            Text("No Results for \"\(lastSearch)\" ")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text("Check the spelling or try a new search.")
                                .opacity(0.4)
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                } else {
                    VStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
            .navigationTitle("Users")
        }
    }
}

#Preview {
    ContentView()
}
