//
//  ProfileView.swift
//  swifty-companion
//
//  Created by Théo Ajavon on 29/04/2024.
//

import SwiftUI

struct ProfileView: View {
    var user: User
    @State private var tabSelection = 0
    
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

    var body: some View {
        ZStack {
            if (user.coalitions != nil) {
//                Color.black
//                    .scaledToFill()
//                    .ignoresSafeArea(.all)
                AsyncImage(url: URL(string: user.coalitions![user.coalitions!.count - 1].cover_url)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea(.all)
                        .opacity(0.7)
                } placeholder: {
                    ProgressView()
                        .frame(width: 70, height: 70)
                }
            } else {
                Image("default_bg")
                    .resizable()
                    .ignoresSafeArea()
            }
            
            VStack {
                HStack {
                    AsyncImage(url: URL(string: user.image.link)) { image in
                        image
                            .resizable()
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    VStack {
                        VStack(alignment: .leading) {
                            Text(user.login)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .font(.title3)
                            Text(user.email)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .opacity(0.8)
                            Text(user.location ?? "Unavailable")
                                .padding(.horizontal)
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(getLocationColor(location: user.location ?? "Unavailable"))
                                )
                        }
                    }
                }
                UserStatDash(wallets: user.wallet, correction_point: user.correction_point, projects_completed: user.projects_users.count)
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.gray)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.white, lineWidth: 1)
                        )
                        .frame(height: 32)
                        .padding(.horizontal)
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.orange)
                        .frame(width: UIScreen.main.bounds.width * 0.5, height: 32)
                        .padding(.horizontal)
                    
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.black.opacity(0))
                            .frame(height: 32)
                            .padding(.horizontal)
                        Text("Level 11 - 60%")
                            .foregroundStyle(.white)
                    }
                }
                Picker("", selection: $tabSelection) {
                    Text("Projects").tag(0)
                        .font(.title)
                    Text("Skills").tag(1)
                        .font(.title)
                }
//                .background(.gray.opacity(0.8))
                .frame(width: 270, height: 50)
                .pickerStyle(SegmentedPickerStyle())
                
                ScrollView {
                    
                }
                .background(.white.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(height: 300)
                .padding(.horizontal)
                
                
                
                //                .pickerStyle(.segmented)
            }
//            .fixedSize()
            .frame(width: UIScreen.main.bounds.width)
            
//            .background(.red)
//            .padding()
        }
        .background(.black)
    }
}

#Preview {
    ProfileView(user: User(id: 1, email: "tajavon@student.42.fr", login: "tajavon", phone: "hidden", correction_point: 667, pool_month: "september", pool_year: "2023", location: "made-f0Br5s3", image: User_image(link: "https://cdn.intra.42.fr/users/75d7dbdc6a8da11f1a4fc38f0a641caf/tajavon.jpg", versions: User_image_version(large: "https://cdn.intra.42.fr/users/6ba29f06e26937c2fe7c6f193d22212d/large_tajavon.jpg", medium: "https://cdn.intra.42.fr/users/9db1bddfd3b1ad6cc7828e46f6d55af6/medium_tajavon.jpg", small: "https://cdn.intra.42.fr/users/4c23a85209107ba6f6c6e0f3baeacd82/small_tajavon.jpg", micro: "https://cdn.intra.42.fr/users/efe404a25dc50e94739d9d661d704606/micro_tajavon.jpg")), wallet: 1406, projects_users: [Project_user(id: 3647453, occurrence: 0, final_mark: 100, status: "finished", validated: true, project: Project(id: 2360, name: "Mobile - 5 - Manage data and display", slug: "mobile-5-manage-data-and-display"), marked_at: "2024-04-20T16:24:42.913Z", marked: true, retriable_at: "2024-04-20T16:24:43.318Z", created_at: "2024-04-20T12:50:19.512Z", updated_at: "2024-04-22T13:15:48.627Z")], cursus_users: [Cursus_user(grade: nil, level: 9.57, skills: [Skill(id: 4, name: "Unix", level: 10.83)]), Cursus_user(grade: "Member", level: 11.6, skills: [Skill(id: 3, name: "Rigor", level: 7.9), Skill(id: 6, name: "Web", level: 7.03), Skill(id: 10, name: "Network & system administration", level: 7.0), Skill(id: 17, name: "Object-oriented programming", level: 6.16), Skill(id: 2, name: "Imperative programming", level: 5.07)])], coalitions: [Coalition(id: 107, name: "La Heap", slug: "la-heap", image_url: "https://cdn.intra.42.fr/coalition/image/107/heap-logo.svg", cover_url: "https://cdn.intra.42.fr/coalition/cover/107/heap-bg-option5.jpg", color: "#00B333", score: 0), Coalition(id: 47, name: "The Order", slug: "42cursus-paris-the-order", image_url: "https://cdn.intra.42.fr/coalition/image/47/order.svg", cover_url: "https://cdn.intra.42.fr/coalition/cover/47/order_background.jpg", color: "#FF6950", score: 505107)]))
}
