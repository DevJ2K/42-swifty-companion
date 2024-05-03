//
//  SearchCell.swift
//  swifty-companion
//
//  Created by Théo Ajavon on 29/04/2024.
//

import SwiftUI

struct SearchCell: View {
    @Environment(\.colorScheme) private var colorScheme
    
    func isLightMode() -> Bool {
        return (colorScheme == .light)
    }
    
    func getLocationColor(location: String) -> Color {
        if (location.starts(with: "bess")) {
            return .cyan
        } else if (location.starts(with: "paul")) {
            return .orange
        } else if (location.starts(with: "made")) {
            return .indigo
        } else if (location.starts(with: "Unavailable")) {
            return .gray
        } else {
            return .green
        }
    }
    
    var item: UserListItem
    var body: some View {
        HStack {
            if let item_img = item.image.link {
                AsyncImage(url: URL(string: item_img)) { image in
                    image
                        .resizable()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                        .frame(width: 70, height: 70)
                }
            } else {
                Image(systemName: "person")
                    .font(.title)
                    .frame(width: 70, height: 70)
                    .background(.black.opacity(0.3))
                    .clipShape(Circle())
            }
            VStack(alignment: .leading) {
                Text(item.login)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .font(.title3)
                if let pool_month = item.pool_month, let pool_year = item.pool_year {
                    Text("\(pool_month.capitalized) \(pool_year)")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .opacity(0.8)
                } else {
                    Text("Unknown")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .opacity(0.8)
                }
                Text(item.location ?? "Unavailable")
                    .padding(.horizontal)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.black.opacity(0.3))
                    )
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
//        .frame(width: .infinity, height: 60)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(getLocationColor(location: item.location ?? "Unavailable"))
                .shadow(
                    color: isLightMode() ? .black.opacity(0.25) : .white.opacity(0.2),
                    radius: 10, x: 0, y: 0)
        )
//        .shadow(color: .black, radius: 1)
        .padding(.horizontal)
    }
}

#Preview {
    
    VStack {
        SearchCell(item: UserListItem(id: 1, email: "tajavon@student.42.fr", login: "tajavon", url: "https://api.intra.42.fr/v2/users/tajavon", phone: "hidden", correction_point: 1, pool_month: "september", pool_year: "2023", location: "made-f0Br5s3", image: User_image(link: "https://cdn.intra.42.fr/users/75d7dbdc6a8da11f1a4fc38f0a641caf/tajavon.jpg", versions: User_image_version(large: "https://cdn.intra.42.fr/users/6ba29f06e26937c2fe7c6f193d22212d/large_tajavon.jpg", medium: "https://cdn.intra.42.fr/users/9db1bddfd3b1ad6cc7828e46f6d55af6/medium_tajavon.jpg", small: "https://cdn.intra.42.fr/users/4c23a85209107ba6f6c6e0f3baeacd82/small_tajavon.jpg", micro: "https://cdn.intra.42.fr/users/efe404a25dc50e94739d9d661d704606/micro_tajavon.jpg")), wallet: 895))
        SearchCell(item: UserListItem(id: 1, email: "tajavon@student.42.fr", login: "tajavon", url: "https://api.intra.42.fr/v2/users/tajavon", phone: "hidden", correction_point: 1, pool_month: "september", pool_year: "2023", location: "bess-f1r5s3", image: User_image(link: "https://cdn.intra.42.fr/users/75d7dbdc6a8da11f1a4fc38f0a641caf/tajavon.jpg", versions: User_image_version(large: "https://cdn.intra.42.fr/users/6ba29f06e26937c2fe7c6f193d22212d/large_tajavon.jpg", medium: "https://cdn.intra.42.fr/users/9db1bddfd3b1ad6cc7828e46f6d55af6/medium_tajavon.jpg", small: "https://cdn.intra.42.fr/users/4c23a85209107ba6f6c6e0f3baeacd82/small_tajavon.jpg", micro: "https://cdn.intra.42.fr/users/efe404a25dc50e94739d9d661d704606/micro_tajavon.jpg")), wallet: 895))
        SearchCell(item: UserListItem(id: 1, email: "tajavon@student.42.fr", login: "tajavon", url: "https://api.intra.42.fr/v2/users/tajavon", phone: "hidden", correction_point: 1, pool_month: "september", pool_year: nil, location: "paul-f3r5s3", image: User_image(link: "https://cdn.intra.42.fr/users/75d7dbdc6a8da11f1a4fc38f0a641caf/tajavon.jpg", versions: User_image_version(large: "https://cdn.intra.42.fr/users/6ba29f06e26937c2fe7c6f193d22212d/large_tajavon.jpg", medium: "https://cdn.intra.42.fr/users/9db1bddfd3b1ad6cc7828e46f6d55af6/medium_tajavon.jpg", small: "https://cdn.intra.42.fr/users/4c23a85209107ba6f6c6e0f3baeacd82/small_tajavon.jpg", micro: "https://cdn.intra.42.fr/users/efe404a25dc50e94739d9d661d704606/micro_tajavon.jpg")), wallet: 895))
        SearchCell(item: UserListItem(id: 1, email: "tajavon@student.42.fr", login: "tajavon", url: "https://api.intra.42.fr/v2/users/tajavon", phone: "hidden", correction_point: 1, pool_month: "september", pool_year: "2023", location: "tome-f0Br4s2", image: User_image(link: nil, versions: User_image_version(large: "https://cdn.intra.42.fr/users/6ba29f06e26937c2fe7c6f193d22212d/large_tajavon.jpg", medium: "https://cdn.intra.42.fr/users/9db1bddfd3b1ad6cc7828e46f6d55af6/medium_tajavon.jpg", small: "https://cdn.intra.42.fr/users/4c23a85209107ba6f6c6e0f3baeacd82/small_tajavon.jpg", micro: "https://cdn.intra.42.fr/users/efe404a25dc50e94739d9d661d704606/micro_tajavon.jpg")), wallet: 895))
        SearchCell(item: UserListItem(id: 1, email: "tajavon@student.42.fr", login: "tajavon", url: "https://api.intra.42.fr/v2/users/tajavon", phone: "hidden", correction_point: 1, pool_month: "september", pool_year: "2023", location: nil, image: User_image(link: "https://cdn.intra.42.fr/users/75d7dbdc6a8da11f1a4fc38f0a641caf/tajavon.jpg", versions: User_image_version(large: "https://cdn.intra.42.fr/users/6ba29f06e26937c2fe7c6f193d22212d/large_tajavon.jpg", medium: "https://cdn.intra.42.fr/users/9db1bddfd3b1ad6cc7828e46f6d55af6/medium_tajavon.jpg", small: "https://cdn.intra.42.fr/users/4c23a85209107ba6f6c6e0f3baeacd82/small_tajavon.jpg", micro: "https://cdn.intra.42.fr/users/efe404a25dc50e94739d9d661d704606/micro_tajavon.jpg")), wallet: 895))
    }
}
