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
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            TextField("Search an user...", text: $searchText)
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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Login to intra") {
                Task {
//                    await intraAPI.getToken()
                    await intraAPI.checkTokenExpirationTime()
                }
            }
        }
        .onAppear {
            Task {
//                await intraAPI.getToken()
                await intraAPI.checkTokenExpirationTime()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
