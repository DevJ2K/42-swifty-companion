//
//  SearchCell.swift
//  swifty-companion
//
//  Created by Théo Ajavon on 29/04/2024.
//

import SwiftUI

struct SearchCell: View {
    var body: some View {
        HStack {
            Text("Cell 1")
        }
        .frame(maxWidth: .infinity)
        .frame(width: .infinity, height: 60)
        .background(.blue)
        .padding(.horizontal)
    }
}

#Preview {
    SearchCell()
}
