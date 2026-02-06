//
//  LoginFormView.swift
//  lily
//
//  Created by Cameron Jules on 06/02/2026.
//

import SwiftUI

struct LoginFormView: View {
    @Bindable var authViewModel: AuthViewModel

    // MARK: - Local State

    @State private var email: String = ""
    @State private var password: String = ""

    // MARK: - Computed

    private var isFormValid: Bool {
        !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !password.isEmpty
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Email field
            VStack(alignment: .leading, spacing: 8) {
                Text("Email")
                    .font(.custom("Fredoka-Medium", size: 14))
                    .foregroundColor(Color("PlaceholderText"))

                TextField("Enter your email", text: $email)
                    .textFieldStyle(LilyTextFieldStyle())
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
            }

            // Password field
            VStack(alignment: .leading, spacing: 8) {
                Text("Password")
                    .font(.custom("Fredoka-Medium", size: 14))
                    .foregroundColor(Color("PlaceholderText"))

                SecureField("Enter your password", text: $password)
                    .textFieldStyle(LilyTextFieldStyle())
                    .textContentType(.password)
            }

            // Error message
            if let errorMessage = authViewModel.errorMessage {
                Text(errorMessage)
                    .font(.custom("Fredoka-Regular", size: 14))
                    .foregroundColor(Color("RedPrimary"))
            }

            // Login button
            Button {
                Task {
                    await authViewModel.login(email: email, password: password)
                }
            } label: {
                Text("Login")
            }
            .buttonStyle(Button3DStyle(color: isFormValid && !authViewModel.isLoading ? Color("BluePrimary") : Color.gray, width: nil))
            .disabled(!isFormValid || authViewModel.isLoading)
            .frame(maxWidth: .infinity)
            .padding(.top, 8)
        }
    }
}

#Preview {
    LoginFormView(authViewModel: AuthViewModel())
        .padding()
}
