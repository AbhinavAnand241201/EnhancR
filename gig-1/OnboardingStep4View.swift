import SwiftUI

struct OnboardingStep4View: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var subscribeOffers: Bool = false
    @State private var agreedToTerms: Bool = false
    
    var isFormValid: Bool {
        agreedToTerms && isValidEmail(email) && isValidPassword(password)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(step: 4, totalSteps: 8)
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("YOU'RE STEPS AWAY FROM YOUR PERSONAL PLAN")
                        .font(.system(size: 32, weight: .black))
                        .foregroundColor(.black)
                        .padding(.bottom, 0)
                    Text("With a few more details, we can match your goal to your plan.")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .padding(.bottom, 8)
                    VStack(alignment: .leading, spacing: 16) {
                        Group {
                            Text("Email")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            TextField("", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).stroke(Color(.systemGray3)))
                        }
                        Group {
                            Text("Password")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            HStack {
                                if showPassword {
                                    TextField("", text: $password)
                                        .autocapitalization(.none)
                                } else {
                                    SecureField("", text: $password)
                                        .autocapitalization(.none)
                                }
                                Button(action: { showPassword.toggle() }) {
                                    Image(systemName: showPassword ? "eye.slash" : "eye")
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color(.systemGray3)))
                            Text("8-30 characters, 1 upper & lowercase & 1 number")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(alignment: .center) {
                            Button(action: { subscribeOffers.toggle() }) {
                                Image(systemName: subscribeOffers ? "checkmark.square.fill" : "square")
                                    .foregroundColor(subscribeOffers ? .black : .gray)
                            }
                            Text("Get training tips and offers to your inbox")
                                .font(.body)
                        }
                        HStack(alignment: .center) {
                            Button(action: { agreedToTerms.toggle() }) {
                                Image(systemName: agreedToTerms ? "checkmark.square.fill" : "square")
                                    .foregroundColor(agreedToTerms ? .black : .gray)
                            }
                            Text("I have read and agree to the ")
                                .font(.body)
                            + Text("Privacy Policy")
                                .font(.body)
                                .underline()
                                .foregroundColor(.black)
                            + Text(" and ")
                                .font(.body)
                            + Text("Terms & Conditions")
                                .font(.body)
                                .underline()
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
            }
            Spacer()
            Button(action: { /* Next step action */ }) {
                Text("KEEP GOING")
                    .font(.headline)
                    .foregroundColor(isFormValid ? Color.yellow : Color(.systemGray3))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFormValid ? Color.black : Color(.systemGray3))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
            .disabled(!isFormValid)
        }
        .background(Color(.systemGray6).ignoresSafeArea())
    }
    
    func isValidEmail(_ email: String) -> Bool {
        // Simple regex for email validation
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        // 8-30 chars, at least 1 upper, 1 lower, 1 number
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{8,30}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
} 