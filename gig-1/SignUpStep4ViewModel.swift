import Foundation
import Combine

class SignUpStep4ViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var email: String = "" {
        didSet { validateEmailFormat() }
    }
    @Published var password: String = "" {
        didSet { validatePassword() }
    }
    @Published var isTrainingTipsChecked: Bool = false
    @Published var isTermsChecked: Bool = false
    @Published var isPasswordVisible: Bool = false
    @Published var emailError: String? = nil
    @Published var passwordError: String? = nil
    @Published var isLoading: Bool = false
    @Published var isEmailUnique: Bool = true // Assume true until checked
    @Published var isCheckingEmailUniqueness: Bool = false

    // MARK: - Email Error State
    var shouldShowEmailErrorUnderline: Bool {
        return emailError != nil
    }

    // MARK: - Validation
    private func validateEmailFormat() {
        if email.isEmpty {
            emailError = nil
        } else if !Self.isValidEmail(email) {
            emailError = "Invalid email format"
        } else {
            emailError = nil
        }
    }

    private func validatePassword() {
        if password.isEmpty {
            passwordError = nil
        } else if !Self.isValidPassword(password) {
            passwordError = "Password must meet criteria"
        } else {
            passwordError = nil
        }
    }

    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    static func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{8,30}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }

    var isContinueEnabled: Bool {
        return Self.isValidEmail(email) && isEmailUnique && Self.isValidPassword(password) && isTermsChecked && !isLoading && !isCheckingEmailUniqueness
    }

    // MARK: - Actions
    func togglePasswordVisibility() {
        isPasswordVisible.toggle()
    }

    // Simulate an async uniqueness check (e.g., API call)
    func checkEmailUniqueness(completion: (() -> Void)? = nil) {
        guard Self.isValidEmail(email) else { return }
        isCheckingEmailUniqueness = true
        // Simulate API delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // For demo: treat "alexsmith.mobbin@gmail.com" as already in use
            if self.email.lowercased() == "alexsmith.mobbin@gmail.com" {
                self.isEmailUnique = false
                self.emailError = "Email already in use"
            } else {
                self.isEmailUnique = true
                // Only show format error if present
                self.emailError = Self.isValidEmail(self.email) ? nil : self.emailError
            }
            self.isCheckingEmailUniqueness = false
            completion?()
        }
    }

    func submit(completion: @escaping (Result<Void, Error>) -> Void) {
        guard isContinueEnabled else { return }
        isLoading = true
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isLoading = false
            completion(.success(()))
        }
    }
} 