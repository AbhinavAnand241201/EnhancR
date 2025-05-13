import SwiftUI

struct SignUpStep5View: View {
    @StateObject private var viewModel = SignUpStep5ViewModel()
    
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
                        Text("Step 5 of 8")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .accessibilityLabel("Step 5 of 8")
                    }
                    // Progress bar
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color(hex: "#D3D3D3"))
                                .frame(height: 4)
                            Capsule()
                                .fill(Color.black)
                                .frame(width: geo.size.width * 0.625, height: 4)
                        }
                    }
                    .frame(height: 4)
                    .padding(.top, 10)
                    // Title
                    Text("HOW WOULD YOU PRIMARILY TRAIN?")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                        .accessibilityAddTraits(.isHeader)
                    // Subtitle
                    Text("You can change this at any time.")
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
                    // Training Options
                    VStack(spacing: 10) {
                        ForEach(TrainingOption.allCases) { option in
                            TrainingOptionRow(
                                option: option,
                                isSelected: viewModel.selectedOption == option,
                                onTap: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        viewModel.selectOption(option)
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
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("CONTINUE")
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

struct TrainingOptionRow: View {
    let option: TrainingOption
    let isSelected: Bool
    let onTap: () -> Void
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .stroke(Color.black, lineWidth: 1)
                        .frame(width: 20, height: 20)
                    if isSelected {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 12, height: 12)
                            .scaleEffect(isSelected ? 1.1 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
                    }
                }
                .accessibilityElement()
                .accessibilityLabel(Text(option.title + (isSelected ? ", selected" : "")))
                VStack(alignment: .leading, spacing: 2) {
                    Text(option.title)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    if let subtitle = option.subtitle {
                        Text(subtitle)
                            .font(.system(size: 12))
                            .foregroundColor(Color(hex: "#666666"))
                    }
                }
                Spacer()
                Image(option.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)
                    .clipped()
                    .accessibilityHidden(true)
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: "#D3D3D3"), lineWidth: 1)
            )
            .cornerRadius(8)
        }
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(isSelected ? "Selected" : "Tap to select")
    }
}

// MARK: - Preview
struct SignUpStep5View_Previews: PreviewProvider {
    static var previews: some View {
        SignUpStep5View()
    }
} 