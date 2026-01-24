//
//  AddProjectSheet.swift
//  lily
//
//  Created by Cameron Jules on 22/01/2026.
//

import SwiftUI

struct AddProjectSheet: View {
    @Bindable var viewModel: ProjectViewModel

    private var isNameValid: Bool {
        !viewModel.newProjectName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Character Name")
                        .font(.custom("Fredoka-Medium", size: 14))
                        .foregroundColor(Color("PlaceholderText"))

                    TextField("Enter character name", text: $viewModel.newCharacterName)
                        .textFieldStyle(LilyTextFieldStyle())
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Project Name")
                        .font(.custom("Fredoka-Medium", size: 14))
                        .foregroundColor(Color("PlaceholderText"))

                    TextField("Enter project name", text: $viewModel.newProjectName)
                        .textFieldStyle(LilyTextFieldStyle())
                }

                Spacer()

                Button {
                    viewModel.createProject()
                } label: {
                    Text("Done")
                }
                .buttonStyle(Button3DStyle(color: isNameValid ? Color("GreenPrimary") : Color.gray, width: nil))
                .frame(maxWidth: .infinity)
                .disabled(!isNameValid)
            }
            .padding(20)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("New Project")
                        .textStyle(.h4)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.closeAddProjectSheet()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .presentationDetents([.fraction(0.5)])
        .presentationDragIndicator(.visible)
        .presentationBackground(.white)
    }
}

#Preview {
    AddProjectSheet(viewModel: ProjectViewModel())
}
