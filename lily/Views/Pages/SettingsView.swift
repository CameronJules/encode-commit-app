//
//  SettingsView.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import SwiftUI

struct SettingsView: View {
    @Bindable var authViewModel: AuthViewModel

    // MARK: - Local State

    @State private var authMode: AuthMode = .login

    enum AuthMode: String, CaseIterable {
        case login = "Login"
        case signup = "Sign Up"
    }

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Settings")
                    .textStyle(.h3)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if authViewModel.isAuthenticated {
                    UserProfileView(authViewModel: authViewModel)
                } else {
                    Picker("Auth Mode", selection: $authMode) {
                        ForEach(AuthMode.allCases, id: \.self) { mode in
                            Text(mode.rawValue).tag(mode)
                        }
                    }
                    .pickerStyle(.segmented)

                    switch authMode {
                    case .login:
                        LoginFormView(authViewModel: authViewModel)
                    case .signup:
                        SignupFormView(authViewModel: authViewModel)
                    }
                }
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    SettingsView(authViewModel: AuthViewModel())
}
