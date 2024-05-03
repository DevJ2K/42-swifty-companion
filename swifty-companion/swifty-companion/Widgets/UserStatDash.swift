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
            VStack(spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: "australsign")
                        .foregroundStyle(.white)
                        .font(.system(size: 14))
                        .opacity(0.8)
                    Text("Wallet")
                        .foregroundStyle(.white)
                        .font(.system(size: 13, weight: .light))
                }
                Text("\(wallets)")
                    .foregroundStyle(.white)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .shadow(color: .black.opacity(0.4), radius: 4, x: 1, y: 1)
                    
            }
            .frame(maxWidth: .infinity)
            Divider()
                .background(.white.opacity(0.8))
                .padding(.vertical)
            VStack(spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: "person.2")
                        .foregroundStyle(.white)
                        .font(.system(size: 13))
                        .opacity(0.8)
                    Text("Evaluations")
                        .foregroundStyle(.white)
                        .font(.system(size: 13, weight: .light))
                }
                Text("\(correction_point)")
                    .foregroundStyle(.white)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .shadow(color: .black.opacity(0.4), radius: 4, x: 1, y: 1)
                    
            }
            .frame(maxWidth: .infinity)
            Divider()
                .background(.white.opacity(0.8))
                .padding(.vertical)
            VStack(spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: "pencil.and.list.clipboard")
                        .foregroundStyle(.white)
                        .font(.system(size: 14))
                        .opacity(0.8)
                    Text("Projects")
                        .foregroundStyle(.white)
                        .font(.system(size: 13, weight: .light))
                }
                Text("\(projects_completed)")
                    .foregroundStyle(.white)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .shadow(color: .black.opacity(0.4), radius: 4, x: 1, y: 1)
                    
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 80)
        .background(.gray.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
//    UserStatDash(wallets: 667, correction_point: 14, projects_completed: 24)
    ProfileView(login: "tajavon")
//    ProfileView(user: User(id: 1, email: "tajavon@student.42.fr", login: "tajavon", phone: "hidden", correction_point: 667, pool_month: "september", pool_year: "2023", location: "made-f0Br5s3", image: User_image(link: "https://cdn.intra.42.fr/users/75d7dbdc6a8da11f1a4fc38f0a641caf/tajavon.jpg", versions: User_image_version(large: "https://cdn.intra.42.fr/users/6ba29f06e26937c2fe7c6f193d22212d/large_tajavon.jpg", medium: "https://cdn.intra.42.fr/users/9db1bddfd3b1ad6cc7828e46f6d55af6/medium_tajavon.jpg", small: "https://cdn.intra.42.fr/users/4c23a85209107ba6f6c6e0f3baeacd82/small_tajavon.jpg", micro: "https://cdn.intra.42.fr/users/efe404a25dc50e94739d9d661d704606/micro_tajavon.jpg")), wallet: 1406, projects_users: [Project_user(id: 3647453, occurrence: 0, final_mark: 100, status: "finished", validated: true, project: Project(id: 2360, name: "Mobile - 5 - Manage data and display", slug: "mobile-5-manage-data-and-display"), marked_at: "2024-04-20T16:24:42.913Z", marked: true, retriable_at: "2024-04-20T16:24:43.318Z", created_at: "2024-04-20T12:50:19.512Z", updated_at: "2024-04-22T13:15:48.627Z")], cursus_users: [Cursus_user(grade: nil, level: 9.57, skills: [Skill(id: 4, name: "Unix", level: 10.83)]), Cursus_user(grade: "Member", level: 11.6, skills: [Skill(id: 3, name: "Rigor", level: 7.9), Skill(id: 6, name: "Web", level: 7.03), Skill(id: 10, name: "Network & system administration", level: 7.0), Skill(id: 17, name: "Object-oriented programming", level: 6.16), Skill(id: 2, name: "Imperative programming", level: 5.07)])], coalitions: [Coalition(id: 107, name: "La Heap", slug: "la-heap", image_url: "https://cdn.intra.42.fr/coalition/image/107/heap-logo.svg", cover_url: "https://cdn.intra.42.fr/coalition/cover/107/heap-bg-option5.jpg", color: "#00B333", score: 0), Coalition(id: 47, name: "The Order", slug: "42cursus-paris-the-order", image_url: "https://cdn.intra.42.fr/coalition/image/47/order.svg", cover_url: "https://cdn.intra.42.fr/coalition/cover/47/order_background.jpg", color: "#FF6950", score: 505107)]))
}
