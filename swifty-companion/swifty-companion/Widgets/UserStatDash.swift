//
//  UserStatDash.swift
//  swifty-companion
//
//  Created by Théo Ajavon on 30/04/2024.
//

import SwiftUI

struct UserStatDash: View {
    var wallets: Int
    var correction_point: Int
    var projects_completed: Int

    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            VStack(spacing: 8) {
                HStack(spacing: 4) {
                    Image(systemName: "wind")
                        .font(.system(size: 14))
                        .opacity(0.8)
                    Text("Wind")
                }
                Text("\(wallets)")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    
            }
            .frame(maxWidth: .infinity)
            Divider()
                .background(.white.opacity(0.8))
                .padding(.vertical)
            VStack(spacing: 8) {
                HStack(spacing: 4) {
                    Image(systemName: "wind")
                        .font(.system(size: 14))
                        .opacity(0.8)
                    Text("Wind")
                }
                Text("\(wallets)")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    
            }
            .frame(maxWidth: .infinity)
            Divider()
                .background(.white.opacity(0.8))
                .padding(.vertical)
            VStack(spacing: 8) {
                HStack(spacing: 4) {
                    Image(systemName: "wind")
                        .font(.system(size: 14))
                        .opacity(0.8)
                    Text("Wind")
                }
                Text("\(wallets)")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 90)
        .background(.black.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .padding()
    }
}

#Preview {
    UserStatDash(wallets: 667, correction_point: 14, projects_completed: 24)
}
