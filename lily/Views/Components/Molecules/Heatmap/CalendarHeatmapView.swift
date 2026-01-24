//
//  CalendarHeatmapView.swift
//  lily
//
//  Created by Cameron Jules on 24/01/2026.
//

import SwiftUI
import SwiftData

struct CalendarHeatmapView: View {
    let project: Project

    @State private var viewModel = HeatmapViewModel()

    private let dayLabels = ["M", "T", "W", "T", "F", "S", "S"]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header row with day labels
            HStack(spacing: 10) {
                Text("")
                    .frame(width: 28)

                ForEach(dayLabels, id: \.self) { label in
                    Text(label)
                        .font(.caption2)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                        .frame(width: 32)
                }
            }

            // Scrollable month content
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(viewModel.months) { month in
                        HeatmapMonthSectionView(
                            month: month,
                            viewModel: viewModel
                        )
                    }
                }
                .padding(.bottom, 16)
            }
            .defaultScrollAnchor(.bottom)
            .scrollIndicators(.hidden)
        }
        .fixedSize(horizontal: true, vertical: false)
        .frame(maxWidth: .infinity, alignment: .center)
        .onAppear {
            viewModel.loadData(for: project)
        }
        .onChange(of: project.todos.count) {
            viewModel.loadData(for: project)
        }
    }
}

// MARK: - Preview

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Project.self, Todo.self, configurations: config)

    let project = Project(name: "Sample Project")
    container.mainContext.insert(project)

    // Create sample completed todos spread across the year
    let calendar = Calendar.current
    let today = Date()

    // Generate sample completions for demonstration
    let sampleCompletions: [(daysAgo: Int, count: Int)] = [
        (0, 3), (1, 2), (2, 5), (3, 1), (5, 4),
        (7, 2), (8, 6), (10, 1), (14, 3), (21, 2),
        (28, 4), (35, 1), (42, 5), (50, 2), (60, 3),
        (75, 1), (90, 4), (120, 2), (150, 3), (180, 1),
        (200, 5), (250, 2), (300, 4), (350, 1)
    ]

    for (daysAgo, count) in sampleCompletions {
        guard let date = calendar.date(byAdding: .day, value: -daysAgo, to: today) else { continue }
        for i in 0..<count {
            let todo = Todo(
                name: "Task \(daysAgo)-\(i)",
                status: .complete,
                completedAt: date,
                project: project
            )
            container.mainContext.insert(todo)
        }
    }

    return CalendarHeatmapView(project: project)
        .padding()
        .modelContainer(container)
}
