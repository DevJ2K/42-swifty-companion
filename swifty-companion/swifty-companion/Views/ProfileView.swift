//
//  ProfileView.swift
//  swifty-companion
//
//  Created by Théo Ajavon on 29/04/2024.
//

import SwiftUI
import Foundation

struct ProfileView: View {
    var user: User
    @State private var tabSelection = "Skills"
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
    
    func dateAgo(dateString: String) -> String {
//        let dateFormatter = ISO8601DateFormatter()
//        let dateFormatter = DateFormatter()
//        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        guard let pastDate = dateFormatter.date(from: dateString) else {
            print("Invalid date format")
            return ("Unavailable")
        }
//        print("=> \(pastDate)")
        
        let currentDate = Date()

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: pastDate, to: currentDate)

        // Print time difference
        if let years = components.year, years > 0 {
            return ("\(years) year\(years != 1 ? "s" : "") ago")
        }
        if let months = components.month, months > 0 {
            return("\(months) month\(months != 1 ? "s" : "") ago")
        } else if let days = components.day, days > 0 {
            return("\(days) day\(days != 1 ? "s" : "") ago")
        } else if let hours = components.hour, hours > 0 {
            return("\(hours) hour\(hours != 1 ? "s" : "") ago")
        } else if let minutes = components.minute, minutes > 0 {
            return("\(minutes) minute\(minutes != 1 ? "s" : "") ago")
        } else if let seconds = components.second {
            return("\(seconds) second\(seconds != 1 ? "s" : "") ago")
        } else {
            return("Just now")
        }
    }
    
    var body: some View {
        NavigationView {
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
            
                ScrollView {
                    // User Header
                    HStack(alignment: .bottom) {
                        AsyncImage(url: URL(string: user.image.link)) { image in
                            image
                                .resizable()
                                .clipShape(Circle())
                                .shadow(color: .white.opacity(0.3), radius: 3, x: 1, y: 1)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        VStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(user.login)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .font(.title2)
                                    .shadow(color: .white.opacity(0.2), radius: 4, x: 1, y: 1)
                                Text(user.email)
                                    .fontWeight(.light)
                                    .foregroundStyle(.white)
                                    .opacity(0.8)
                                Text(user.location ?? "Unavailable")
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 2)
                                    .foregroundStyle(.white)
                                    .fontWeight(.semibold)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(getLocationColor(location: user.location ?? "Unavailable"))
                                            .shadow(color: .black.opacity(0.5), radius: 4, x: 1, y: 1)
                                    )
                                    .padding(.vertical, 4)
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Level Bar
                    if let currentCursus = getCurrentCursus(all_cursus: user.cursus_users) {
                        UserLevelBar(level: currentCursus.level)
                            .padding(.vertical, 6)
                    } else {
                        UserLevelBar(level: -1)
                            .padding(.vertical, 6)
                    }
                    
                    // User Stat Dash
                    UserStatDash(wallets: user.wallet, correction_point: user.correction_point, projects_completed: user.projects_users.count)
                        .padding()
                    
                    
                    // Custom Picker
                    HStack {
                        Text("Projects")
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                            .frame(maxWidth: .infinity)
                            .background(
                                ZStack {
                                    if (tabSelection == "Projects") {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(.white)
                                    }
                                }
                            )
                            .foregroundStyle(tabSelection == "Projects" ? .black : .white)
                            .onTapGesture {
                                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                                    tabSelection = "Projects"
                                }
                            }
                        Text("Skills")
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                            .background(
                                ZStack {
                                    if (tabSelection == "Skills") {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(.white)
                                    }
                                }
                            )
                            .foregroundStyle(tabSelection == "Skills" ? .black : .white)
                            .onTapGesture {
                                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                                    tabSelection = "Skills"
                                }
                            }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(.gray.opacity(0.4)))
                    .padding(.horizontal)
                    
                    ScrollView {
                        if (tabSelection == "Projects") {
                            ForEach(user.projects_users.sorted(by: {$0.marked_at ?? ":" > $1.marked_at ?? ":"}), id: \.id) { project in
                                if (project.status == "finished") {
                                    HStack {
                                        Text("\(project.project.name) - ")
                                        + Text("\(dateAgo(dateString: project.marked_at!))").bold()
                                        
                                        Spacer()
                                        Text("\(project.final_mark ?? 0)")
                                            .fontWeight(.bold)
                                            .foregroundStyle((project.validated != nil && project.validated!) ? .green : .red)
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical, 4)
                                    Divider()
                                        .background(.red)
                                        .padding(.horizontal)
                                } else if (project.status == "in_progress") {
                                    HStack {
                                        Text("\(project.project.name)")
                                        Spacer()
                                        Image(systemName: "clock")
                                            .fontWeight(.bold)
                                            .foregroundStyle(.orange)
                                    }
                                    .padding(.horizontal)
                                    Divider()
                                        .background(.red)
                                        .padding(.horizontal)
                                }
                            }
                        }
                        if (tabSelection == "Skills") {
                            // Se baser sur le grade
                            if let currentCursus = getCurrentCursus(all_cursus: user.cursus_users) {
                                ForEach(currentCursus.skills, id: \.id) { skill in
                                    VStack {
                                        Text(skill.name)
                                            .foregroundStyle(.white)
                                        SkillLevelBar(level: skill.level)
                                    }
                                    .frame(maxWidth: .infinity)
                                    
                                    Rectangle()
                                        .fill(.white.opacity(0.3))
                                        .frame(width: 200, height: 1)
                                        .padding(.bottom)
                                    
                                    
                                }
                            } else {
                                Text("No cursus is active.")
                            }
                        }
                    }
                    .padding(.vertical)
                    .background(.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .frame(height: 300)
                    .padding(.horizontal)
                }
                .frame(width: UIScreen.main.bounds.width)
            }
//            .navigationTitle(user.login)
//            .toolbar(.hidden, for: .tabBar)
            .background(.black)
        }
    }
}

struct UserLevelBar: View {
    var level: Double
    @State private var levelBarPourcentage = 0.0
    @State private var loadingDuration = 2.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.black.opacity(0.6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white, lineWidth: 1)
                    )
                    .frame(width: geometry.size.width, height: 22)
                RoundedRectangle(cornerRadius: 8)
                    .fill(.orange)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white, lineWidth: 1)
                    )
                    .frame(width: geometry.size.width * levelBarPourcentage, height: 22)
                
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.black.opacity(0))
                        .frame(width: geometry.size.width, height: 22)
                    Text("Level \(getFloorValue(nb: level)) - \(getPourcentageOfDecimal(nb: level))%")
                        .fontWeight(.semibold)
                        .font(.callout)
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.5), radius: 4, x: 1, y: 1)
                }
            }
            .onAppear {
                var goToBarPourcentage = getDecimalValue(nb: level)
                if (goToBarPourcentage <= 0.001) {
                    return
                }
                if (goToBarPourcentage < 0.03) {
                    goToBarPourcentage = 0.03
                    loadingDuration = 0.2
                }
                DispatchQueue.main.async {
                    withAnimation(.easeInOut(duration: loadingDuration * goToBarPourcentage)) {
                        levelBarPourcentage = goToBarPourcentage
                    }
                }
            }
        }
        .padding(.horizontal)
//        .frame(width: UIScreen.main.bounds.width, height: 22)
        .frame(width: UIScreen.main.bounds.width, height: 22)
    }
}

struct SkillLevelBar: View {
    var level: Double
    @State private var levelBarPourcentage = 0.0
    @State private var loadingDuration = 2.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.black.opacity(0.6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white.opacity(0.5), lineWidth: 1)
                    )
                    .frame(width: geometry.size.width, height: 16)
                RoundedRectangle(cornerRadius: 8)
                    .fill(.orange)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white.opacity(0.5), lineWidth: 1)
                    )
                    .frame(width: geometry.size.width * levelBarPourcentage, height: 16)
                
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.black.opacity(0))
                        .frame(width: geometry.size.width, height: 16)
                    Text("Level \(getFloorValue(nb: level)) - \(getPourcentageOfDecimal(nb: level))%")
                        .fontWeight(.semibold)
                        .font(.caption)
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.5), radius: 4, x: 1, y: 1)
                }
            }
            .onAppear {
                var goToBarPourcentage = getDecimalValue(nb: level)
                if (goToBarPourcentage <= 0.001) {
                    return
                }
                if (goToBarPourcentage < 0.03) {
                    goToBarPourcentage = 0.03
                    loadingDuration = 0.2
                }
                DispatchQueue.main.async {
                    withAnimation(.easeInOut(duration: loadingDuration * goToBarPourcentage)) {
                        levelBarPourcentage = goToBarPourcentage
                    }
                }
            }
        }
        .padding(.horizontal)
        .frame(width: UIScreen.main.bounds.width * 0.85, height: 16)
    }
}


#Preview {
    ContentView()
//    ProfileView(user: User(id: 1, email: "tajavon@student.42.fr", login: "tajavon", phone: "hidden", correction_point: 667, pool_month: "september", pool_year: "2023", location: "made-f0Br5s3", image: User_image(link: "https://cdn.intra.42.fr/users/75d7dbdc6a8da11f1a4fc38f0a641caf/tajavon.jpg", versions: User_image_version(large: "https://cdn.intra.42.fr/users/6ba29f06e26937c2fe7c6f193d22212d/large_tajavon.jpg", medium: "https://cdn.intra.42.fr/users/9db1bddfd3b1ad6cc7828e46f6d55af6/medium_tajavon.jpg", small: "https://cdn.intra.42.fr/users/4c23a85209107ba6f6c6e0f3baeacd82/small_tajavon.jpg", micro: "https://cdn.intra.42.fr/users/efe404a25dc50e94739d9d661d704606/micro_tajavon.jpg")), wallet: 14062005, projects_users: [
//        Project_user(id: 3647453, occurrence: 0, final_mark: 100, status: "finished", validated: true, project: Project(id: 2360, name: "Mobile - 5 - Manage data and display", slug: "mobile-5-manage-data-and-display"), marked_at: "2024-04-20T16:24:42.913Z", marked: true, retriable_at: "2024-04-20T16:24:43.318Z", created_at: "2024-04-20T12:50:19.512Z", updated_at: "2024-04-22T13:15:48.627Z"),
//        Project_user(id: 3648419, occurrence: 0, final_mark: nil, status: "in_progress", validated: nil, project: Project(id: 1395, name: "swifty-companion", slug: "42cursus-swifty-companion"), marked_at: nil, marked: false, retriable_at: nil, created_at: "2024-04-22T07:20:18.216Z", updated_at: "2024-04-22T07:22:26.978Z"),
//        Project_user(id: 3615649, occurrence: 0, final_mark: 100, status: "finished", validated: true, project: Project(id: 2355, name: "Mobile", slug: "mobile"), marked_at: "2024-04-22T07:09:10.894Z", marked: true, retriable_at: nil, created_at: "2024-03-26T09:35:47.455Z", updated_at: "2024-04-22T07:09:10.903Z"),
//        Project_user(id: 3644358, occurrence: 0, final_mark: 0, status: "finished", validated: false, project: Project(id: 2359, name: "Mobile - 4 - Auth and dataBase", slug: "mobile-4-auth-and-database"), marked_at: "2024-04-18T19:08:29.024Z", marked: true, retriable_at: "2024-04-18T19:08:29.571Z", created_at: "2024-04-18T06:18:31.976Z", updated_at: "2024-04-20T16:49:33.683Z"),
//        Project_user(id: 3640230, occurrence: 0, final_mark: 100, status: "finished", validated: true, project: Project(id: 2358, name: "Mobile - 3 - Design", slug: "mobile-3-design"), marked_at: "2024-04-16T14:43:42.570Z", marked: true, retriable_at: "2024-04-16T14:43:42.991Z", created_at: "2024-04-15T22:13:39.279Z", updated_at: "2024-04-18T12:51:50.185Z"),
//        Project_user(id: 3628160, occurrence: 0, final_mark: 100, status: "finished", validated: true, project: Project(id: 2357, name: "Mobile - 2 - API and data", slug: "mobile-2-api-and-data"), marked_at: "2024-04-05T11:23:13.592Z", marked: true, retriable_at: "2024-04-05T11:23:14.088Z", created_at: "2024-04-04T19:56:01.029Z", updated_at: "2024-04-06T21:22:42.370Z"),
//        Project_user(id: 3620411, occurrence: 0, final_mark: 100, status: "finished", validated: true, project: Project(id: 2356, name: "Mobile - 1 - Structure and logic", slug: "mobile-1-structure-and-logic"), marked_at: "2024-03-29T13:41:38.286Z", marked: true, retriable_at: "2024-03-29T13:41:38.710Z", created_at: "2024-03-29T09:14:01.882Z", updated_at: "2024-03-31T08:24:57.753Z"),
//        Project_user(id: 3615655, occurrence: 0, final_mark: 100, status: "finished", validated: true, project: Project(id: 2354, name: "Mobile - 0 - Basic of the mobile application", slug: "mobile-0-basic-of-the-mobile-application"), marked_at: "2024-03-27T15:55:14.705Z", marked: true, retriable_at: "2024-03-27T15:55:15.187Z", created_at: "2024-03-26T09:36:20.025Z", updated_at: "2024-03-29T09:33:08.249Z"),
//        Project_user(id: 3545556, occurrence: 0, final_mark: 125, status: "finished", validated: true, project: Project(id: 1337, name: "ft_transcendence", slug: "ft_transcendence"), marked_at: "2024-03-22T18:05:16.127Z", marked: true, retriable_at: "2024-03-25T18:05:16.470Z", created_at: "2024-02-14T19:10:57.361Z", updated_at: "2024-03-22T18:05:16.494Z"),
//        Project_user(id: 3545558, occurrence: 1, final_mark: 100, status: "finished", validated: true, project: Project(id: 1324, name: "Exam Rank 06", slug: "exam-rank-06"), marked_at: "2024-02-22T17:24:48.968Z", marked: true, retriable_at: "2024-02-22T17:24:48.999Z", created_at: "2024-02-14T19:11:16.075Z", updated_at: "2024-02-22T17:24:49.015Z"),
//        Project_user(id: 3529622, occurrence: 0, final_mark: 100, status: "finished", validated: true, project: Project(id: 1336, name: "ft_irc", slug: "ft_irc"), marked_at: "2024-02-14T19:09:40.476Z", marked: true, retriable_at: "2024-02-17T19:09:40.780Z", created_at: "2024-02-07T10:43:40.363Z", updated_at: "2024-02-14T19:09:40.798Z"),
//        Project_user(id: 3506284, occurrence: 0, final_mark: 110, status: "finished", validated: true, project: Project(id: 1983, name: "Inception", slug: "inception"), marked_at: "2024-02-07T14:44:25.865Z", marked: true, retriable_at: "2024-02-10T14:44:26.334Z", created_at: "2024-01-29T09:16:33.336Z", updated_at: "2024-02-07T14:44:26.348Z"),
//        Project_user(id: 3501913, occurrence: 1, final_mark: 100, status: "finished", validated: true, project: Project(id: 2309, name: "CPP Module 09", slug: "cpp-module-09"), marked_at: "2024-01-30T15:36:37.591Z", marked: true, retriable_at: "2024-01-31T15:36:38.071Z", created_at: "2024-01-25T16:57:29.008Z", updated_at: "2024-01-30T15:36:38.090Z"),
//        Project_user(id: 3498188, occurrence: 0, final_mark: 100, status: "finished", validated: true, project: Project(id: 1346, name: "CPP Module 08", slug: "cpp-module-08"), marked_at: "2024-01-25T16:57:09.693Z", marked: true, retriable_at: "2024-01-26T16:57:09.723Z", created_at: "2024-01-24T12:44:46.199Z", updated_at: "2024-01-25T16:57:09.735Z")
//    ], cursus_users: [Cursus_user(grade: nil, level: 9.57, skills: [Skill(id: 4, name: "Unix", level: 10.83)]), Cursus_user(grade: "Member", level: 11.6, skills: [Skill(id: 3, name: "Rigor", level: 7.9), Skill(id: 9, name: "Strong", level: 7.01), Skill(id: 6, name: "Web", level: 7.03), Skill(id: 10, name: "Network & system administration", level: 7.0), Skill(id: 17, name: "Object-oriented programming", level: 6.16), Skill(id: 2, name: "Imperative programming", level: 5.07)])], coalitions: [Coalition(id: 107, name: "La Heap", slug: "la-heap", image_url: "https://cdn.intra.42.fr/coalition/image/107/heap-logo.svg", cover_url: "https://cdn.intra.42.fr/coalition/cover/107/heap-bg-option5.jpg", color: "#00B333", score: 0), Coalition(id: 47, name: "The Order", slug: "42cursus-paris-the-order", image_url: "https://cdn.intra.42.fr/coalition/image/47/order.svg", cover_url: "https://cdn.intra.42.fr/coalition/cover/47/order_background.jpg", color: "#FF6950", score: 505107)]))
}
