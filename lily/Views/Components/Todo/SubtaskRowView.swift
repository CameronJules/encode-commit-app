//
//  SubtaskRowView.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import SwiftUI
import SwiftData

struct SubtaskRowView: View {
    @Bindable var subtask: Subtask
    var subtaskViewModel: SubtaskViewModel

    var body: some View {
        HStack(spacing: 12) {
            TodoCheckboxView(isChecked: $subtask.isCompleted)

            TextField("Next action", text: $subtask.name)
                .font(.custom("Fredoka-Regular", size: 16))
                .foregroundColor(Color("InputText"))

            Button {
                subtaskViewModel.removeSubtask(subtask)
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(Color("CheckboxUnchecked"))
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Subtask.self, configurations: config)

    let subtask1 = Subtask(name: "Research competitors", sortOrder: 0)
    let subtask2 = Subtask(name: "Write summary", isCompleted: true, sortOrder: 1)

    container.mainContext.insert(subtask1)
    container.mainContext.insert(subtask2)

    let viewModel = SubtaskViewModel()
    viewModel.subtasks = [subtask1, subtask2]

    return VStack {
        SubtaskRowView(subtask: subtask1, subtaskViewModel: viewModel)
        SubtaskRowView(subtask: subtask2, subtaskViewModel: viewModel)
    }
    .padding()
    .modelContainer(container)
}
