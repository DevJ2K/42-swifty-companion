//
//  ProjectView.swift
//  swifty-companion
//
//  Created by Théo Ajavon on 01/05/2024.
//

import SwiftUI

struct ProjectView: View {
    var project: Project_user
    
    var body: some View {
        List {
//            Section(header: Text("Info")) {
            Section {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(project.project.name)
                }
                HStack {
                    Text("Retry")
                    Spacer()
                    Text("\(project.occurrence)")
                }
            }
            Section {
                HStack {
                    Text("Validated")
                    Spacer()
                    if (project.marked) {
                        Text("✅")
                    } else {
                        Text("❌")
                    }
                }
//                HStack {
//                    Text("Retry")
//                    Spacer()
//                    Text("\(project.occurrence)")
//                }
            }
        }
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ProjectView(project: Project_user(id: 3647453, occurrence: 0, final_mark: 100, status: "finished", validated: true, project: Project(id: 2360, name: "Mobile - 5 - Manage data and display", slug: "mobile-5-manage-data-and-display"), marked_at: "2024-04-20T16:24:42.913Z", marked: true, retriable_at: "2024-04-20T16:24:43.318Z", created_at: "2024-04-20T12:50:19.512Z", updated_at: "2024-04-22T13:15:48.627Z"))
}
