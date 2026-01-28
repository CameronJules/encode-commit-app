//
//  FrogSelectionGridView.swift
//  lily
//
//  Created by Cameron Jules on 27/01/2026.
//

import SwiftUI

struct FrogSelectionGridView: View {
    @Bindable var viewModel: CharacterViewModel
    var size: FrogDisplaySize = .large

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 48) {
            ForEach(viewModel.availableFrogs) { frog in
                let isSelected = viewModel.selectedFrog == frog
                Button {
                    viewModel.selectFrog(frog)
                } label: {
                    Image(frog.assetName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: size.dimension, height: size.dimension)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(isSelected ? Color("GreenPrimary").opacity(0.15) : Color(white: 0.95))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(isSelected ? Color("GreenPrimary") : Color.clear, lineWidth: 2)
                        )
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    FrogSelectionGridView(viewModel: CharacterViewModel())
        .padding()
}
