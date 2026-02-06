//
//  UserProfileView.swift
//  lily
//
//  Created by Cameron Jules on 06/02/2026.
//

import SwiftUI

struct UserProfileView: View {
    @Bindable var authViewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 20) {
            // User info
            VStack(spacing: 8) {
                if let user = authViewModel.currentUser {
                    Text(user.email)
                        .textStyle(.body1Bold)

                    if let username = user.username {
                        Text("@\(username)")
                            .textStyle(.body2)
                    }
                }
            }

            // Logout button
            Button {
                Task {
                    await authViewModel.logout()
                }
            } label: {
                Text("Logout")
            }
            .buttonStyle(Button3DStyle(color: Color("RedPrimary"), width: nil))
            .disabled(authViewModel.isLoading)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    UserProfileView(authViewModel: AuthViewModel())
}
