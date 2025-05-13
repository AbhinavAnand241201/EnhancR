import SwiftUI

struct SignUpStep4View: View {
    @StateObject private var viewModel = SignUpStep4ViewModel()
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case email, password
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack(spacing: 20) {
                    // Status bar spacing
                    Spacer().frame(height: 8)
                    // Back button and progress
                    HStack {
                        Button(action: { /* Handle back navigation */ }) {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.black)
                                .accessibilityLabel("Back Button")
                        }
                        Spacer()
                        Text("Step 4 of 8")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .accessibilityLabel("Step 4 of 8")
                    }
                    // Progress bar
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color(hex: "#D3D3D3"))
                                .frame(height: 4)
                            Capsule()
                                .fill(Color.black)
                                .frame(width: geo.size.width * 0.5, height: 4)
                        }
                    }
                    .frame(height: 4)
                    .padding(.top, 10)
                    // Title
                    Text("YOU'RE STEPS AWAY FROM YOUR PERSONAL PLAN")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                        .accessibilityAddTraits(.isHeader)
                    // Subtitle
                    Text("With a few more details, we can match your goal to your plan.")
                        .font(.system(size: 16))
                        .foregroundColor(Color(hex: "#666666"))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                    // Email
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Email")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        TextField("", text: $viewModel.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .focused($focusedField, equals: .email)
                            .padding(.horizontal, 10)
                            .frame(height: 44)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(focusedField == .email ? Color.blue : Color(hex: "#D3D3D3"), lineWidth: 1)
                            )
                            .cornerRadius(8)
                            .accessibilityLabel("Email Text Field")
                        if let emailError = viewModel.emailError {
                            Text(emailError)
                                .font(.system(size: 12))
                                .foregroundColor(.red)
                                .accessibilityLabel(emailError)
                        }
                    }
                    .padding(.top, 20)
                    // Password
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Password")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        HStack {
                            Group {
                                if viewModel.isPasswordVisible {
                                    TextField("", text: $viewModel.password)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                        .focused($focusedField, equals: .password)
                                } else {
                                    SecureField("", text: $viewModel.password)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                        .focused($focusedField, equals: .password)
                                }
                            }
                            .padding(.horizontal, 10)
                            .frame(height: 44)
                            .accessibilityLabel("Password Text Field")
                            Button(action: { viewModel.togglePasswordVisibility() }) {
                                Image(systemName: viewModel.isPasswordVisible ? "eye.slash" : "eye")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.black)
                            }
                            .accessibilityLabel(viewModel.isPasswordVisible ? "Hide Password" : "Show Password")
                        }
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(focusedField == .password ? Color.blue : Color(hex: "#D3D3D3"), lineWidth: 1)
                        )
                        .cornerRadius(8)
                        // Password hint
                        Text("8–30 characters, 1 upper & lowercase & 1 number")
                            .font(.system(size: 12))
                            .foregroundColor(Color(hex: "#666666"))
                            .padding(.top, 5)
                        if let passwordError = viewModel.passwordError {
                            Text(passwordError)
                                .font(.system(size: 12))
                                .foregroundColor(.red)
                                .accessibilityLabel(passwordError)
                        }
                    }
                    .padding(.top, 10)
                    // Checkboxes
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(alignment: .top) {
                            CheckboxView(isChecked: $viewModel.isTrainingTipsChecked)
                                .accessibilityLabel("Get training tips and offers to your inbox checkbox")
                            Text("Get training tips and offers to your inbox")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                                .accessibilityLabel("Get training tips and offers to your inbox")
                        }
                        HStack(alignment: .top) {
                            CheckboxView(isChecked: $viewModel.isTermsChecked)
                                .accessibilityLabel("Agree to terms checkbox")
                            TermsTextView()
                        }
                    }
                    .padding(.top, 20)
                    // Continue Button
                    Button(action: {
                        viewModel.submit { _ in /* Handle navigation to next step */ }
                    }) {
                        ZStack {
                            if viewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("KEEP GOING")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(viewModel.isContinueEnabled ? Color(hex: "#007AFF") : Color(hex: "#A9A9A9"))
                        .cornerRadius(8)
                        .scaleEffect(viewModel.isLoading ? 0.95 : 1.0)
                        .animation(.easeInOut(duration: 0.1), value: viewModel.isLoading)
                    }
                    .disabled(!viewModel.isContinueEnabled)
                    .accessibilityLabel("Continue Button")
                    .padding(.top, 30)
                    Spacer()
                }
                .padding(16)
                // Footer
                HStack {
                    Image("centr_logo")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .accessibilityHidden(true)
                    Spacer()
                    Text("curated by Mobbin")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                    Image("mobbin_logo")
                        .resizable()
                        .frame(width: 50, height: 20)
                        .accessibilityHidden(true)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
            }
            .background(Color(hex: "#F8F8F8").ignoresSafeArea())
        }
    }
}

// MARK: - Checkbox View
struct CheckboxView: View {
    @Binding var isChecked: Bool
    var body: some View {
        Button(action: { isChecked.toggle() }) {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color(hex: "#D3D3D3"), lineWidth: 1)
                    .frame(width: 20, height: 20)
                if isChecked {
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.black)
                }
            }
        }
        .accessibilityAddTraits(.isButton)
        .accessibilityValue(isChecked ? "Checked" : "Unchecked")
    }
}

// MARK: - Terms Text View
struct TermsTextView: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("I have read and agree to the ")
            Button(action: { /* Navigate to Privacy Policy */ }) {
                Text("Privacy Policy")
                    .underline()
                    .foregroundColor(.black)
            }
            Text(" and ")
            Button(action: { /* Navigate to Terms & Conditions */ }) {
                Text("Terms & Conditions")
                    .underline()
                    .foregroundColor(.black)
            }
        }
        .font(.system(size: 14))
        .foregroundColor(.black)
    }
}

// MARK: - Preview
struct SignUpStep4View_Previews: PreviewProvider {
    static var previews: some View {
        SignUpStep4View()
    }
} 
