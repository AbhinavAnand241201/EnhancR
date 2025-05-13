import SwiftUI

struct SignUpStep8View: View {
    @StateObject private var viewModel = SignUpStep8ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack(spacing: 20) {
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
                        Text("Step 8 of 8")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .accessibilityLabel("Step 8 of 8")
                    }
                    // Progress bar
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color(hex: "#D3D3D3"))
                                .frame(height: 4)
                            Capsule()
                                .fill(Color.black)
                                .frame(width: geo.size.width, height: 4)
                        }
                    }
                    .frame(height: 4)
                    .padding(.top, 10)
                    // Title
                    Text("WHAT MINDSET ACTIVITIES CAN WE SUPPORT YOU WITH?")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                        .accessibilityAddTraits(.isHeader)
                    // Subtitle
                    Text("Centr Members are more likely to hit their goals with mindset activities. You can choose multiple.")
                        .font(.system(size: 16))
                        .foregroundColor(Color(hex: "#666666"))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.black.opacity(0.8))
                        )
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                    // Mindset Options
                    VStack(spacing: 10) {
                        ForEach(MindsetOption.allCases) { option in
                            MindsetOptionRow(
                                option: option,
                                isSelected: viewModel.isSelected(option),
                                onTap: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        viewModel.toggleOption(option)
                                    }
                                }
                            )
                        }
                    }
                    .padding(.top, 10)
                    // Continue Button
                    Button(action: {
                        viewModel.submit { _ in /* Handle navigation to next step */ }
                    }) {
                        ZStack {
                            if viewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color(hex: "#FFFF00")))
                            } else {
                                Text("CONTINUE")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color(hex: "#FFFF00"))
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(viewModel.isContinueEnabled ? Color.black : Color(hex: "#A9A9A9"))
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

struct MindsetOptionRow: View {
    let option: MindsetOption
    let isSelected: Bool
    let onTap: () -> Void
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.black, lineWidth: 1)
                        .frame(width: 20, height: 20)
                    if isSelected {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.black)
                            .frame(width: 20, height: 20)
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.white)
                    }
                }
                .accessibilityElement()
                .accessibilityLabel(Text(option.rawValue + (isSelected ? ", checked" : "")))
                Text(option.rawValue)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                Spacer()
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(isSelected ? Color(hex: "#E6E6E6") : Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: "#D3D3D3"), lineWidth: 1)
            )
            .cornerRadius(8)
        }
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(isSelected ? "Checked" : "Tap to select")
    }
}

// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Preview
struct SignUpStep8View_Previews: PreviewProvider {
    static var previews: some View {
        SignUpStep8View()
    }
} 