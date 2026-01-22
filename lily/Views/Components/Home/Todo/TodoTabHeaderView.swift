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

    var body: some View {
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
}

#Preview {
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
