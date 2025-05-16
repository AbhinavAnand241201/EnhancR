import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            // Background Image
            Image("gym-set")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            // Status bar
            VStack {
                HStack {
                    Text("9:41")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                    Spacer()
                    HStack(spacing: 6) {
                        Image(systemName: "cellularbars")
                        Image(systemName: "wifi")
                        Image(systemName: "battery.100")
                    }
                    .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                Spacer()
            }
            // Overlay and Content
            VStack {
                Spacer()
                VStack(spacing: 0) {
                    Text("WELCOME ALEX")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 30)
                        .padding(.horizontal, 24)
                    Text("Are you ready to live your best life?\nGet started with my team.")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                        .padding(.horizontal, 24)
                    Button(action: { print("Enter Centr tapped") }) {
                        Text("ENTER CENTR")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 340, height: 50)
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    // Footer
                    HStack {
                        HStack(spacing: 5) {
                            Image(systemName: "bolt.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(hex: "#FFC107"))
                            Text("Centr")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.white)
                        }
                        Spacer()
                        HStack(spacing: 5) {
                            Text("curated by")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.white)
                            Image(systemName: "m.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                            Text("MOBBIN")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                }
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(hex: "#2C2C2E").opacity(0.95),
                            Color(hex: "#2C2C2E").opacity(0.85)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                )
                .padding(.top, 0)
            }
        }
    }
}

// Custom Corner Radius Modifier
struct CornerRadiusShape: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
} 