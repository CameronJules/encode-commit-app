//
//  SignupFormView.swift
//  lily
//
//  Created by Cameron Jules on 06/02/2026.
//

import SwiftUI

struct SignupFormView: View {
    @Bindable var authViewModel: AuthViewModel

    // MARK: - Local State

    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showSuccess: Bool = false

    // MARK: - Computed

    private var isFormValid: Bool {
        !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        password.count >= 8 &&
        password == confirmPassword
    }

    private var validationMessage: String? {
        if !password.isEmpty && password.count < 8 {
            return "Password must be at least 8 characters"
        }
        if !confirmPassword.isEmpty && password != confirmPassword {
            return "Passwords do not match"
        }
        return nil
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

            // Username field
            VStack(alignment: .leading, spacing: 8) {
                Text("Username")
                    .font(.custom("Fredoka-Medium", size: 14))
                    .foregroundColor(Color("PlaceholderText"))

                TextField("Choose a username (optional)", text: $username)
                    .textFieldStyle(LilyTextFieldStyle())
                    .textContentType(.username)
                    .textInputAutocapitalization(.never)
            }

            // Password field
            VStack(alignment: .leading, spacing: 8) {
                Text("Password")
                    .font(.custom("Fredoka-Medium", size: 14))
                    .foregroundColor(Color("PlaceholderText"))

                SecureField("At least 8 characters", text: $password)
                    .textFieldStyle(LilyTextFieldStyle())
                    .textContentType(.newPassword)
            }

            // Confirm password field
            VStack(alignment: .leading, spacing: 8) {
                Text("Confirm Password")
                    .font(.custom("Fredoka-Medium", size: 14))
                    .foregroundColor(Color("PlaceholderText"))

                SecureField("Re-enter your password", text: $confirmPassword)
                    .textFieldStyle(LilyTextFieldStyle())
                    .textContentType(.newPassword)
            }

            // Validation / error messages
            if let validation = validationMessage {
                Text(validation)
                    .font(.custom("Fredoka-Regular", size: 14))
                    .foregroundColor(Color("RedPrimary"))
            }

            if let errorMessage = authViewModel.errorMessage {
                Text(errorMessage)
                    .font(.custom("Fredoka-Regular", size: 14))
                    .foregroundColor(Color("RedPrimary"))
            }

            if showSuccess {
                Text("Account created! You can now log in.")
                    .font(.custom("Fredoka-Medium", size: 14))
                    .foregroundColor(Color("GreenPrimary"))
            }

            // Sign Up button
            Button {
                Task {
                    let trimmedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
                    await authViewModel.signup(
                        email: email,
                        username: trimmedUsername.isEmpty ? nil : trimmedUsername,
                        password: password
                    )
                    if authViewModel.errorMessage == nil {
                        showSuccess = true
                    }
                }
            } label: {
                Text("Sign Up")
            }
            .buttonStyle(Button3DStyle(color: isFormValid && !authViewModel.isLoading ? Color("GreenPrimary") : Color.gray, width: nil))
            .disabled(!isFormValid || authViewModel.isLoading)
            .frame(maxWidth: .infinity)
            .padding(.top, 8)
        }
    }
}

#Preview {
    SignupFormView(authViewModel: AuthViewModel())
        .padding()
}
