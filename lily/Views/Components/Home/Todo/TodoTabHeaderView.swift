//
//  TodoTabHeaderView.swift
//  lily
//
//  Created by Cameron Jules on 22/01/2026.
//

import SwiftUI

struct TodoTabHeaderView: View {
    @Binding var selectedTab: HomeTabType
    var movementState: TodoMovementState? = nil
    var viewModel: TodoViewModel? = nil
    var todos: [Todo] = []
    var selectedProject: Project? = nil

    private var projectFilteredTodos: [Todo] {
        todos.filter { todo in
            selectedProject == nil || todo.project?.id == selectedProject?.id
        }
    }

    private let checkboxSize: CGFloat = 24
    private let checkboxCornerRadius: CGFloat = 6

    private func mapChevronDirection(_ direction: TodoMovementDirection?) -> ChevronDirection? {
        guard let direction else { return nil }
        switch direction {
        case .left: return .left
        case .right: return .right
        case .none: return nil
        }
    }

    var body: some View {
        if let viewModel, viewModel.isInBulkEditMode {
            editModeHeader(viewModel: viewModel)
        } else {
            normalHeader
        }
    }

    private var normalHeader: some View {
        TabHeaderView(
            selectedTab: $selectedTab,
            title: selectedTab.title,
            highlightedChevron: mapChevronDirection(movementState?.highlightedChevron)
        )
    }

    private func editModeHeader(viewModel: TodoViewModel) -> some View {
        HStack(spacing: 32) {
            Button {
                viewModel.exitBulkEditMode()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("InputText"))
            }

            Text("\(viewModel.selectedTodoIds.count)")
                .textStyle(.h4Active)

            Spacer()

            Button {
                viewModel.toggleSelectAllTodos(in: projectFilteredTodos, forStatus: selectedTab.todoStatus)
            } label: {
                Image("stack.SFSymbol")
                    .font(.system(size: 30, weight: .heavy))
                    .foregroundColor(Color("BluePrimary"))
            }

            if selectedTab == .capture {
                Button {
                    viewModel.activateSelectedTodos(from: projectFilteredTodos)
                } label: {
                    Image("rounded.square.play.SFSymbol")
                        .foregroundColor(Color("BluePrimary"))
                        .imageScale(.large)
                        .font(.system(size: 24, weight: .heavy))
                }
            } else if selectedTab == .active {
                Button {
                    viewModel.completeSelectedTodos(from: projectFilteredTodos)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: checkboxCornerRadius)
                            .fill(Color("BluePrimary"))
                            .frame(width: checkboxSize, height: checkboxSize)

                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }

            Button {
                viewModel.deleteSelectedTodos(from: projectFilteredTodos)
            } label: {
                Image("bin.SFSymbol")
                    .font(.system(size: 30, weight: .heavy))
                    .foregroundColor(Color("RedPrimary"))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

#Preview("Normal Header") {
    struct PreviewWrapper: View {
        @State private var selectedTab: HomeTabType = .capture

        var body: some View {
            VStack {
                TodoTabHeaderView(selectedTab: $selectedTab)
                    .background(Color.white)

                Text("Selected: \(selectedTab.title)")
            }
        }
    }

    return PreviewWrapper()
}

#Preview("Edit Mode Header") {
    struct PreviewWrapper: View {
        @State private var selectedTab: HomeTabType = .capture
        let viewModel = TodoViewModel()

        var body: some View {
            VStack {
                TodoTabHeaderView(
                    selectedTab: $selectedTab,
                    viewModel: viewModel,
                    todos: []
                )
                .background(Color.white)
            }
            .onAppear {
                viewModel.enterBulkEditMode()
                viewModel.selectedTodoIds.insert(UUID())
                viewModel.selectedTodoIds.insert(UUID())
            }
        }
    }

    return PreviewWrapper()
}
