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

    private var canGoBack: Bool {
        selectedTab.rawValue > 0
    }

    private var canGoForward: Bool {
        selectedTab.rawValue < HomeTabType.allCases.count - 1
    }

    private var leftChevronColor: Color {
        if let state = movementState, state.highlightedChevron == .left {
            return Color("BluePrimary")
        }
        return canGoBack ? Color("InputText") : Color("PlaceholderText")
    }

    private var rightChevronColor: Color {
        if let state = movementState, state.highlightedChevron == .right {
            return Color("BluePrimary")
        }
        return canGoForward ? Color("InputText") : Color("PlaceholderText")
    }

    private let checkboxSize: CGFloat = 24
    private let checkboxCornerRadius: CGFloat = 6

    var body: some View {
        if let viewModel, viewModel.isInBulkEditMode {
            editModeHeader(viewModel: viewModel)
        } else {
            normalHeader
        }
    }

    private var normalHeader: some View {
        HStack {
            Button {
                if canGoBack {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        selectedTab = HomeTabType(rawValue: selectedTab.rawValue - 1) ?? selectedTab
                    }
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(leftChevronColor)
                    .animation(.easeInOut(duration: 0.2), value: movementState?.highlightedChevron)
            }
            .disabled(!canGoBack)

            Spacer()

            Text(selectedTab.title)
                .textStyle(.h4)

            Spacer()

            Button {
                if canGoForward {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        selectedTab = HomeTabType(rawValue: selectedTab.rawValue + 1) ?? selectedTab
                    }
                }
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(rightChevronColor)
                    .animation(.easeInOut(duration: 0.2), value: movementState?.highlightedChevron)
            }
            .disabled(!canGoForward)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
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
                viewModel.toggleSelectAllTodos(in: todos, forStatus: selectedTab.todoStatus)
            } label: {
                Image("stack.SFSymbol")
                    .font(.system(size: 30, weight: .heavy))
                    .foregroundColor(Color("BluePrimary"))
            }

            if selectedTab == .capture {
                Button {
                    viewModel.activateSelectedTodos(from: todos)
                } label: {
                    Image("rounded.square.play.SFSymbol")
                        .foregroundColor(Color("BluePrimary"))
                        .imageScale(.large)
                        .font(.system(size: 24, weight: .heavy))
                }
            } else if selectedTab == .active {
                Button {
                    viewModel.completeSelectedTodos(from: todos)
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
                viewModel.deleteSelectedTodos(from: todos)
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

//#Preview("Normal Header") {
//    struct PreviewWrapper: View {
//        @State private var selectedTab: HomeTabType = .capture
//
//        var body: some View {
//            VStack {
//                TodoTabHeaderView(selectedTab: $selectedTab)
//                    .background(Color.white)
//
//                Text("Selected: \(selectedTab.title)")
//            }
//        }
//    }
//
//    return PreviewWrapper()
//}

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
