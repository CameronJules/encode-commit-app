//
//  HeatmapMonthSectionView.swift
//  lily
//
//  Created by Cameron Jules on 24/01/2026.
//

import SwiftUI

struct HeatmapMonthSectionView: View {
    let month: HeatmapMonth
    let viewModel: HeatmapViewModel

    private var monthName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let components = DateComponents(year: month.year, month: month.month, day: 1)
        let date = Calendar.current.date(from: components) ?? Date()
        return dateFormatter.string(from: date)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Month divider
            HStack(spacing: 8) {
                Text(monthName)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)

                Rectangle()
                    .fill(Color.secondary.opacity(0.3))
                    .frame(height: 1)
            }
            .padding(.top, 4)

            // Week rows
            ForEach(month.weeks) { week in
                HeatmapWeekRowView(
                    week: week,
                    month: month,
                    viewModel: viewModel
                )
            }
        }
    }
}
