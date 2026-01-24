//
//  HeatmapWeekRowView.swift
//  lily
//
//  Created by Cameron Jules on 24/01/2026.
//

import SwiftUI

struct HeatmapWeekRowView: View {
    let week: HeatmapWeek
    let month: HeatmapMonth
    let viewModel: HeatmapViewModel

    var body: some View {
        HStack(spacing: 10) {
            Text("W\(String(format: "%02d", week.weekNumber))")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .frame(width: 28, alignment: .leading)

            ForEach(week.days) { day in
                HeatmapDayCellView(
                    day: day,
                    color: viewModel.color(for: day, in: month)
                )
            }
        }
    }
}
