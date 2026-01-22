//
//  TodoDetailSheet.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import SwiftUI
import SwiftData

struct TodoDetailSheet: View {
    @Bindable var viewModel: TodoViewModel
    @Environment(\.modelContext) private var modelContext

    private var isNameValid: Bool {
        !viewModel.editingName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Name field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Name")
                            .font(.custom("Fredoka-Medium", size: 14))
                            .foregroundColor(Color("PlaceholderText"))

                        TextField("Task name", text: $viewModel.editingName)
                            .textFieldStyle(LilyTextFieldStyle())
                    }

                    // Description field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description")
                            .font(.custom("Fredoka-Medium", size: 14))
                            .foregroundColor(Color("PlaceholderText"))

                        TextField("Add a description...", text: $viewModel.editingDescription, axis: .vertical)
                            .lineLimit(3...6)
                            .textFieldStyle(LilyTextFieldStyle(minHeight: 100))
                    }

                    // Next actions section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Next actions")
                            .font(.custom("Fredoka-Medium", size: 14))
                            .foregroundColor(Color("PlaceholderText"))

                        ForEach(viewModel.subtaskViewModel.subtasks) { subtask in
                            SubtaskRowView(subtask: subtask, subtaskViewModel: viewModel.subtaskViewModel)
                        }

                        Button {
                            viewModel.subtaskViewModel.addSubtask()
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 20))
                                Text("Add next action")
                                    .font(.custom("Fredoka-Medium", size: 16))
                            }
                            .foregroundColor(Color("BluePrimary"))
                        }
                        .buttonStyle(.plain)
                    }

                    Spacer(minLength: 20)

                    // Done button
                    Button {
                        viewModel.saveChanges()
                    } label: {
                        Text("Done")
                    }
                    .buttonStyle(Button3DStyle(color: isNameValid ? Color("GreenPrimary") : Color.gray, width: nil))
                    .frame(maxWidth: .infinity)
                    .disabled(!isNameValid)
                }
                .padding(20)
            }
            .navigationTitle("Edit Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        viewModel.closeDetailSheet()
                    }
                    .font(.custom("Fredoka-Regular", size: 16))
                }
            }
        }
        .presentationDetents([.fraction(0.8)])
        .presentationDragIndicator(.visible)
        .presentationBackground(.white)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Todo.self, Subtask.self, configurations: config)

    let todo = Todo(name: "Complete project proposal", descriptionText: "Draft the initial proposal")
    let subtask1 = Subtask(name: "Research competitors", sortOrder: 0)
    let subtask2 = Subtask(name: "Write executive summary", sortOrder: 1)
    todo.subtasks = [subtask1, subtask2]

    container.mainContext.insert(todo)

    let viewModel = TodoViewModel()
    viewModel.openDetailSheet(for: todo)

    return TodoDetailSheet(viewModel: viewModel)
        .modelContainer(container)
}
