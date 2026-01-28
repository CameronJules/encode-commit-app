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
    var characterViewModel = CharacterViewModel()

    // MARK: - Computed Properties
    var selectedProjectName: String {
        selectedProject?.name ?? "All Tasks"
    }

    // MARK: - Filtering

    /// Returns todos for the selected project, or all todos if no project selected
    func todos(from allTodos: [Todo]) -> [Todo] {
        guard let selectedProject = selectedProject else { return allTodos }
        return allTodos.filter { $0.project?.id == selectedProject.id }
    }

    /// Returns todos for a specific project, or all todos if nil
    func todos(for project: Project?, from allTodos: [Todo]) -> [Todo] {
        guard let project = project else { return allTodos }
        return allTodos.filter { $0.project?.id == project.id }
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

        let character = characterViewModel.makeCharacter()

        let project = Project(name: trimmedName, character: character, sortOrder: nextSortOrder)
        modelContext.insert(project)

        newProjectName = ""
        characterViewModel.clear()
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
        characterViewModel.clear()
        isAddProjectSheetPresented = true
    }

    func closeAddProjectSheet() {
        isAddProjectSheetPresented = false
        newProjectName = ""
        characterViewModel.clear()
    }
}
