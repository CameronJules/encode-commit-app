//
//  ProjectListView.swift
//  lily
//
//  Created by Cameron Jules on 22/01/2026.
//

import SwiftUI
import SwiftData

struct ProjectListView: View {
    @Bindable var viewModel: ProjectViewModel
    @Query(sort: \Project.sortOrder) private var projects: [Project]
    var onBack: () -> Void

    var body: some View {
        ZStack(alignment: .top) {
            // Full-screen background
            Image("ProjectDayBg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // Card-based scroll view
            ScrollView {
                LazyVStack(spacing: 48) {
                    // Project cards
                    ForEach(projects) { project in
                        ProjectCardView(
                            characterName: project.character?.name ?? "",
                            frogAssetName: project.character?.imageName,
                            projectName: project.name
                        ) {
                            viewModel.selectProject(project)
                            onBack()
                        }
                    }

                    // Add Project card
                    AddProjectCardView {
                        viewModel.openAddProjectSheet()
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 150)
                .padding(.bottom, 16)
            }

            // Custom header with back button - positioned at same height as main page
            HStack {
                Button {
                    onBack()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                        .frame(width: 32, height: 32)
                        .background(Circle().fill(Color.white))
                }
                .buttonStyle(.plain)

                Spacer()

                Text("Projects")
                    .font(.custom("Fredoka-SemiBold", size: 18))
                    .foregroundColor(.white)

                Spacer()

                // Invisible spacer to balance the header
                Color.clear
                    .frame(width: 32, height: 32)
            }
            .padding(.horizontal, 20)
            .padding(.top, 60)
        }
        .sheet(isPresented: $viewModel.isAddProjectSheetPresented) {
            AddProjectSheet(viewModel: viewModel)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Project.self, Todo.self, Subtask.self, Character.self, configurations: config)

    let char1 = Character(name: "Lily", imageName: "BlueFrog")
    let char2 = Character(name: "Max", imageName: "GreenFrog")
    let project1 = Project(name: "Work", character: char1, sortOrder: 0)
    let project2 = Project(name: "Personal", character: char2, sortOrder: 1)

    container.mainContext.insert(project1)
    container.mainContext.insert(project2)

    return ProjectListView(viewModel: ProjectViewModel()) {
        print("Back tapped")
    }
    .modelContainer(container)
}
