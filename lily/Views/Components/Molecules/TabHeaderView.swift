//
//  TabHeaderView.swift
//  lily
//
//  Created by Cameron Jules on 24/01/2026.
//

import SwiftUI

enum ChevronDirection {
    case left
    case right
}

struct TabHeaderView<Tab: Hashable & CaseIterable & RawRepresentable>: View
where Tab.RawValue == Int {
    @Binding var selectedTab: Tab
    var title: String
    var horizontalPadding: CGFloat = 20
    var verticalPadding: CGFloat = 16
    var highlightedChevron: ChevronDirection? = nil

    private var canGoBack: Bool {
        selectedTab.rawValue > 0
    }

    private var canGoForward: Bool {
        selectedTab.rawValue < Tab.allCases.count - 1
    }

    private var leftChevronColor: Color {
        if highlightedChevron == .left {
            return Color("BluePrimary")
        }
        return canGoBack ? Color("InputText") : Color("PlaceholderText")
    }

    private var rightChevronColor: Color {
        if highlightedChevron == .right {
            return Color("BluePrimary")
        }
        return canGoForward ? Color("InputText") : Color("PlaceholderText")
    }

    var body: some View {
        HStack {
            Button {
                if canGoBack {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        if let newTab = Tab(rawValue: selectedTab.rawValue - 1) {
                            selectedTab = newTab
                        }
                    }
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(leftChevronColor)
                    .animation(.easeInOut(duration: 0.2), value: highlightedChevron)
            }
            .disabled(!canGoBack)

            Spacer()

            Text(title)
                .textStyle(.h4)

            Spacer()

            Button {
                if canGoForward {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        if let newTab = Tab(rawValue: selectedTab.rawValue + 1) {
                            selectedTab = newTab
                        }
                    }
                }
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(rightChevronColor)
                    .animation(.easeInOut(duration: 0.2), value: highlightedChevron)
            }
            .disabled(!canGoForward)
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, verticalPadding)
    }
}

#Preview {
    enum PreviewTab: Int, CaseIterable {
        case first = 0
        case second = 1
        case third = 2

        var title: String {
            switch self {
            case .first: return "First"
            case .second: return "Second"
            case .third: return "Third"
            }
        }
    }

    struct PreviewWrapper: View {
        @State private var selectedTab: PreviewTab = .first

        var body: some View {
            VStack(spacing: 20) {
                TabHeaderView(
                    selectedTab: $selectedTab,
                    title: selectedTab.title
                )
                .background(Color.white)

                TabHeaderView(
                    selectedTab: $selectedTab,
                    title: selectedTab.title,
                    highlightedChevron: .right
                )
                .background(Color.white)

                Text("Selected: \(selectedTab.title)")
            }
        }
    }

    return PreviewWrapper()
}
