//
//  HeatmapViewModel.swift
//  lily
//
//  Created by Cameron Jules on 24/01/2026.
//

import Foundation
import SwiftUI
import SwiftData

// MARK: - Data Structures

struct HeatmapDay: Identifiable {
    let id: UUID
    let date: Date
    let completionCount: Int
    let belongsToMonth: Bool

    var isInFuture: Bool {
        date > Date()
    }
}

struct HeatmapWeek: Identifiable {
    let id: UUID
    let weekNumber: Int
    let days: [HeatmapDay]
}

struct HeatmapMonth: Identifiable {
    let id: UUID
    let month: Int
    let year: Int
    let weeks: [HeatmapWeek]
    let maxCompletions: Int
}

// MARK: - ViewModel

@Observable
final class HeatmapViewModel {
    private(set) var months: [HeatmapMonth] = []
    private let calendar = Calendar.current

    func loadData(for project: Project) {
        let completionCounts = buildCompletionCounts(from: project)
        months = generateMonths(completionCounts: completionCounts, project: project)
    }

    // MARK: - Build Completion Counts

    private func buildCompletionCounts(from project: Project) -> [DateComponents: Int] {
        var counts: [DateComponents: Int] = [:]

        let completedTodos = project.todos.filter { $0.status == .complete && $0.completedAt != nil }

        for todo in completedTodos {
            guard let completedAt = todo.completedAt else { continue }
            let components = calendar.dateComponents([.year, .month, .day], from: completedAt)
            counts[components, default: 0] += 1
        }

        return counts
    }

    // MARK: - Generate Month/Week Structure

    private func generateMonths(completionCounts: [DateComponents: Int], project: Project) -> [HeatmapMonth] {
        let today = Date()

        // Determine start date: beginning of current year or earliest completion
        let startOfYear = calendar.date(from: calendar.dateComponents([.year], from: today))!
        let earliestCompletion = project.todos
            .compactMap { $0.completedAt }
            .min()

        let startDate: Date
        if let earliest = earliestCompletion, earliest < startOfYear {
            startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: earliest))!
        } else {
            startDate = startOfYear
        }

        var result: [HeatmapMonth] = []
        var currentDate = startDate

        while currentDate <= today {
            let monthData = generateMonth(for: currentDate, completionCounts: completionCounts, today: today)
            result.append(monthData)

            guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: currentDate) else { break }
            currentDate = nextMonth
        }

        return result
    }

    private func generateMonth(for date: Date, completionCounts: [DateComponents: Int], today: Date) -> HeatmapMonth {
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)

        // Get all days in this month
        let range = calendar.range(of: .day, in: .month, for: date)!
        let firstDayOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: 1))!
        let lastDayOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: range.count))!

        // Find the Monday of the week containing the first day
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        let daysToSubtract = (firstWeekday + 5) % 7 // Convert to Monday-based (Monday = 0)
        let startOfFirstWeek = calendar.date(byAdding: .day, value: -daysToSubtract, to: firstDayOfMonth)!

        // Find the Sunday of the week containing the last day
        let lastWeekday = calendar.component(.weekday, from: lastDayOfMonth)
        let daysToAdd = (8 - lastWeekday) % 7 // Days until Sunday
        let endOfLastWeek = calendar.date(byAdding: .day, value: daysToAdd, to: lastDayOfMonth)!

        // Generate weeks
        var weeks: [HeatmapWeek] = []
        var weekStart = startOfFirstWeek

        while weekStart <= endOfLastWeek {
            let weekNumber = calendar.component(.weekOfYear, from: weekStart)
            var days: [HeatmapDay] = []

            for dayOffset in 0..<7 {
                guard let dayDate = calendar.date(byAdding: .day, value: dayOffset, to: weekStart) else { continue }
                let dayMonth = calendar.component(.month, from: dayDate)
                let belongsToMonth = dayMonth == month

                let components = calendar.dateComponents([.year, .month, .day], from: dayDate)
                let count = completionCounts[components] ?? 0

                days.append(HeatmapDay(
                    id: UUID(),
                    date: dayDate,
                    completionCount: count,
                    belongsToMonth: belongsToMonth
                ))
            }

            weeks.append(HeatmapWeek(id: UUID(), weekNumber: weekNumber, days: days))

            guard let nextWeek = calendar.date(byAdding: .day, value: 7, to: weekStart) else { break }
            weekStart = nextWeek
        }

        // Calculate max completions for this month (only for days that belong to month)
        let maxCompletions = weeks
            .flatMap { $0.days }
            .filter { $0.belongsToMonth && !$0.isInFuture }
            .map { $0.completionCount }
            .max() ?? 0

        return HeatmapMonth(
            id: UUID(),
            month: month,
            year: year,
            weeks: weeks,
            maxCompletions: maxCompletions
        )
    }

    // MARK: - Color Calculation

    func color(for day: HeatmapDay, in month: HeatmapMonth) -> Color {
        guard day.belongsToMonth else { return .white }
        guard !day.isInFuture else { return .white }
        guard day.completionCount > 0 else { return Color(hex: "#F7F7F7") }

        let ratio = Double(day.completionCount) / Double(max(month.maxCompletions, 1))
        let lightness = 1.0 - (0.74 * ratio) // 100% -> 26%
        return Color.hsl(h: 96, s: 0.61, l: lightness)
    }
}
