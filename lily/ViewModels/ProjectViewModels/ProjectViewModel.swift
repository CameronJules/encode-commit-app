//
//  ProjectViewModel.swift
//  lily
//
//  Created by Cameron Jules on 22/01/2026.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
final class ProjectViewModel {
    // MARK: - Dependencies
    var modelContext: ModelContext?

    // MARK: - State
    var selectedProject: Project?
    var isProjectListPresented: Bool = false
    var isAddProjectSheetPresented: Bool = false
    var newProjectName: String = ""
    var newCharacterName: String = ""

    // MARK: - Computed Properties
    var selectedProjectName: String {
        selectedProject?.name ?? "All Tasks"
    }

    // MARK: - Methods

    func selectProject(_ project: Project?) {
        selectedProject = project
        isProjectListPresented = false
    }

    func createProject() {
        guard let modelContext else { return }
        let trimmedName = newProjectName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }

        let descriptor = FetchDescriptor<Project>(sortBy: [SortDescriptor(\.sortOrder, order: .reverse)])
        let projects = (try? modelContext.fetch(descriptor)) ?? []
        let nextSortOrder = (projects.first?.sortOrder ?? -1) + 1

        let trimmedCharacterName = newCharacterName.trimmingCharacters(in: .whitespacesAndNewlines)
        let characterId = UUID().uuidString

        let project = Project(name: trimmedName, characterName: trimmedCharacterName, characterId: characterId, sortOrder: nextSortOrder)
        modelContext.insert(project)

        newProjectName = ""
        newCharacterName = ""
        isAddProjectSheetPresented = false
        selectedProject = project
    }

    func deleteProject(_ project: Project) {
        guard let modelContext else { return }
        if selectedProject?.id == project.id {
            selectedProject = nil
        }
        modelContext.delete(project)
    }

    func openProjectList() {
        isProjectListPresented = true
    }

    func openAddProjectSheet() {
        newProjectName = ""
        newCharacterName = ""
        isAddProjectSheetPresented = true
    }

    func closeAddProjectSheet() {
        isAddProjectSheetPresented = false
        newProjectName = ""
        newCharacterName = ""
    }
}
