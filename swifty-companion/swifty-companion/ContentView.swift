//
//  ContentView.swift
//  swifty-companion
//
//  Created by Théo Ajavon on 22/04/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var intraAPI = IntraAPI.shared
    var body: some View {
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
