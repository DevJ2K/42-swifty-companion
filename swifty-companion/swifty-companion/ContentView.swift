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
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)
                    TextField("Search an user...", text: $searchText)
                        .autocorrectionDisabled()
                        .submitLabel(.search)
                        .onSubmit {
                            print("The user to search : \(searchText)")
                            if (searchText.isEmpty) {
                                return
                            }
                            Task {
                                await intraAPI.findUsersByLogin(login: searchText)
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
                    
                    ScrollView {
                        ForEach(intraAPI.userList, id: \.id) { user in
                            SearchCell(item: user)
                        }
//                        ForEach(0 ..< 4, id: \.self) { i in
//                            NavigationLink {
//                                ProfileView(user: User(id: 1, email: "tajavon@student.42.fr", login: "tajavon", phone: "hidden", correction_point: 667, pool_month: "september", pool_year: "2023", location: "made-f0Br5s3", image: User_image(link: "https://cdn.intra.42.fr/users/75d7dbdc6a8da11f1a4fc38f0a641caf/tajavon.jpg", versions: User_image_version(large: "https://cdn.intra.42.fr/users/6ba29f06e26937c2fe7c6f193d22212d/large_tajavon.jpg", medium: "https://cdn.intra.42.fr/users/9db1bddfd3b1ad6cc7828e46f6d55af6/medium_tajavon.jpg", small: "https://cdn.intra.42.fr/users/4c23a85209107ba6f6c6e0f3baeacd82/small_tajavon.jpg", micro: "https://cdn.intra.42.fr/users/efe404a25dc50e94739d9d661d704606/micro_tajavon.jpg")), wallet: 14062005, projects_users: [
//                                    Project_user(id: 3647453, occurrence: 0, final_mark: 100, status: "finished", validated: true, project: Project(id: 2360, name: "Mobile - 5 - Manage data and display", slug: "mobile-5-manage-data-and-display"), marked_at: "2024-04-20T16:24:42.913Z", marked: true, retriable_at: "2024-04-20T16:24:43.318Z", created_at: "2024-04-20T12:50:19.512Z", updated_at: "2024-04-22T13:15:48.627Z"),
//                                    Project_user(id: 3648419, occurrence: 0, final_mark: nil, status: "in_progress", validated: nil, project: Project(id: 1395, name: "swifty-companion", slug: "42cursus-swifty-companion"), marked_at: nil, marked: false, retriable_at: nil, created_at: "2024-04-22T07:20:18.216Z", updated_at: "2024-04-22T07:22:26.978Z"),
//                                    Project_user(id: 3615649, occurrence: 0, final_mark: 100, status: "finished", validated: true, project: Project(id: 2355, name: "Mobile", slug: "mobile"), marked_at: "2024-04-22T07:09:10.894Z", marked: true, retriable_at: nil, created_at: "2024-03-26T09:35:47.455Z", updated_at: "2024-04-22T07:09:10.903Z"),
//                                    Project_user(id: 3644358, occurrence: 0, final_mark: 0, status: "finished", validated: false, project: Project(id: 2359, name: "Mobile - 4 - Auth and dataBase", slug: "mobile-4-auth-and-database"), marked_at: "2024-04-18T19:08:29.024Z", marked: true, retriable_at: "2024-04-18T19:08:29.571Z", created_at: "2024-04-18T06:18:31.976Z", updated_at: "2024-04-20T16:49:33.683Z"),
//                                    Project_user(id: 3640230, occurrence: 0, final_mark: 100, status: "finished", validated: true, project: Project(id: 2358, name: "Mobile - 3 - Design", slug: "mobile-3-design"), marked_at: "2024-04-16T14:43:42.570Z", marked: true, retriable_at: "2024-04-16T14:43:42.991Z", created_at: "2024-04-15T22:13:39.279Z", updated_at: "2024-04-18T12:51:50.185Z"),
//                                    Project_user(id: 3628160, occurrence: 0, final_mark: 100, status: "finished", validated: true, project: Project(id: 2357, name: "Mobile - 2 - API and data", slug: "mobile-2-api-and-data"), marked_at: "2024-04-05T11:23:13.592Z", marked: true, retriable_at: "2024-04-05T11:23:14.088Z", created_at: "2024-04-04T19:56:01.029Z", updated_at: "2024-04-06T21:22:42.370Z"),
//                                    Project_user(id: 3620411, occurrence: 0, final_mark: 100, status: "finished", validated: true, project: Project(id: 2356, name: "Mobile - 1 - Structure and logic", slug: "mobile-1-structure-and-logic"), marked_at: "2024-03-29T13:41:38.286Z", marked: true, retriable_at: "2024-03-29T13:41:38.710Z", created_at: "2024-03-29T09:14:01.882Z", updated_at: "2024-03-31T08:24:57.753Z"),
//                                    Project_user(id: 3615655, occurrence: 0, final_mark: 100, status: "finished", validated: true, project: Project(id: 2354, name: "Mobile - 0 - Basic of the mobile application", slug: "mobile-0-basic-of-the-mobile-application"), marked_at: "2024-03-27T15:55:14.705Z", marked: true, retriable_at: "2024-03-27T15:55:15.187Z", created_at: "2024-03-26T09:36:20.025Z", updated_at: "2024-03-29T09:33:08.249Z"),
//                                    Project_user(id: 3545556, occurrence: 0, final_mark: 125, status: "finished", validated: true, project: Project(id: 1337, name: "ft_transcendence", slug: "ft_transcendence"), marked_at: "2024-03-22T18:05:16.127Z", marked: true, retriable_at: "2024-03-25T18:05:16.470Z", created_at: "2024-02-14T19:10:57.361Z", updated_at: "2024-03-22T18:05:16.494Z"),
//                                    Project_user(id: 3545558, occurrence: 1, final_mark: 100, status: "finished", validated: true, project: Project(id: 1324, name: "Exam Rank 06", slug: "exam-rank-06"), marked_at: "2024-02-22T17:24:48.968Z", marked: true, retriable_at: "2024-02-22T17:24:48.999Z", created_at: "2024-02-14T19:11:16.075Z", updated_at: "2024-02-22T17:24:49.015Z"),
//                                    Project_user(id: 3529622, occurrence: 0, final_mark: 100, status: "finished", validated: true, project: Project(id: 1336, name: "ft_irc", slug: "ft_irc"), marked_at: "2024-02-14T19:09:40.476Z", marked: true, retriable_at: "2024-02-17T19:09:40.780Z", created_at: "2024-02-07T10:43:40.363Z", updated_at: "2024-02-14T19:09:40.798Z"),
//                                    Project_user(id: 3506284, occurrence: 0, final_mark: 110, status: "finished", validated: true, project: Project(id: 1983, name: "Inception", slug: "inception"), marked_at: "2024-02-07T14:44:25.865Z", marked: true, retriable_at: "2024-02-10T14:44:26.334Z", created_at: "2024-01-29T09:16:33.336Z", updated_at: "2024-02-07T14:44:26.348Z"),
//                                    Project_user(id: 3501913, occurrence: 1, final_mark: 100, status: "finished", validated: true, project: Project(id: 2309, name: "CPP Module 09", slug: "cpp-module-09"), marked_at: "2024-01-30T15:36:37.591Z", marked: true, retriable_at: "2024-01-31T15:36:38.071Z", created_at: "2024-01-25T16:57:29.008Z", updated_at: "2024-01-30T15:36:38.090Z"),
//                                    Project_user(id: 3498188, occurrence: 0, final_mark: 100, status: "finished", validated: true, project: Project(id: 1346, name: "CPP Module 08", slug: "cpp-module-08"), marked_at: "2024-01-25T16:57:09.693Z", marked: true, retriable_at: "2024-01-26T16:57:09.723Z", created_at: "2024-01-24T12:44:46.199Z", updated_at: "2024-01-25T16:57:09.735Z")
//                                ], cursus_users: [Cursus_user(grade: nil, level: 9.57, skills: [Skill(id: 4, name: "Unix", level: 10.83)]), Cursus_user(grade: "Member", level: 11.6, skills: [Skill(id: 3, name: "Rigor", level: 7.9), Skill(id: 6, name: "Web", level: 7.4), Skill(id: 10, name: "Network & system administration", level: 7.0), Skill(id: 17, name: "Object-oriented programming", level: 6.16), Skill(id: 2, name: "Imperative programming", level: 5.07)])], coalitions: [Coalition(id: 107, name: "La Heap", slug: "la-heap", image_url: "https://cdn.intra.42.fr/coalition/image/107/heap-logo.svg", cover_url: "https://cdn.intra.42.fr/coalition/cover/107/heap-bg-option5.jpg", color: "#00B333", score: 0), Coalition(id: 47, name: "The Order", slug: "42cursus-paris-the-order", image_url: "https://cdn.intra.42.fr/coalition/image/47/order.svg", cover_url: "https://cdn.intra.42.fr/coalition/cover/47/order_background.jpg", color: "#FF6950", score: 505107)]))
//                            } label: {
//                                SearchCell(item: UserListItem(id: 1, email: "tajavon@student.42.fr", login: "tajavon", url: "https://api.intra.42.fr/v2/users/tajavon", phone: "hidden", correction_point: 1, pool_month: "september", pool_year: "2023", location: "made-f0Br5s3", image: User_image(link: "https://cdn.intra.42.fr/users/75d7dbdc6a8da11f1a4fc38f0a641caf/tajavon.jpg", versions: User_image_version(large: "https://cdn.intra.42.fr/users/6ba29f06e26937c2fe7c6f193d22212d/large_tajavon.jpg", medium: "https://cdn.intra.42.fr/users/9db1bddfd3b1ad6cc7828e46f6d55af6/medium_tajavon.jpg", small: "https://cdn.intra.42.fr/users/4c23a85209107ba6f6c6e0f3baeacd82/small_tajavon.jpg", micro: "https://cdn.intra.42.fr/users/efe404a25dc50e94739d9d661d704606/micro_tajavon.jpg")), wallet: 895))
//                            }
//                        }
                    }
                } else {
                    VStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
//                    .background(.red)
                }
//                .background(.red)
            }
            
//            VStack {
//                Image(systemName: "globe")
//                    .imageScale(.large)
//                    .foregroundStyle(.tint)
//                Text("Hello, world!")
//                Button("Login to intra") {
//                    Task {
//                        //                    await intraAPI.getToken()
//                        await intraAPI.checkTokenExpirationTime()
//                    }
//                }
//            }
//            .onAppear {
//                Task {
//                    //                await intraAPI.getToken()
//                    await intraAPI.checkTokenExpirationTime()
//                }
//            }
//            .padding()
            .navigationTitle("Users")
        }
    }
}

#Preview {
    ContentView()
}
