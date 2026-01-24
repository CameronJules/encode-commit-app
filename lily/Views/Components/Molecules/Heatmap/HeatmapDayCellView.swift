//
//  HeatmapDayCellView.swift
//  lily
//
//  Created by Cameron Jules on 24/01/2026.
//

import SwiftUI

struct HeatmapDayCellView: View {
    let day: HeatmapDay
    let color: Color

    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(color)
            .frame(width: 32, height: 32)
    }
}
