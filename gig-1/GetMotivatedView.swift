import SwiftUI

struct GetMotivatedView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 0) {
                // Status bar
                HStack {
                    Text("9:41")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                    Spacer()
                    HStack(spacing: 6) {
                        Image(systemName: "cellularbars")
                        Image(systemName: "wifi")
                        Image(systemName: "battery.100")
                    }
                    .foregroundColor(.black)
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                // Header
                Spacer().frame(height: 52)
                Text("GET MOTIVATED,\nSTAY UPDATED &\nBE FIRST TO KNOW")
                    .font(.system(size: 34, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                Spacer().frame(height: 40)
                // Placeholder image area
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(hex: "#E5E5EA"))
                        .frame(width: 300, height: 200)
                    // Notification Banner
                    VStack {
                        Spacer()
                        NotificationBannerView()
                            .offset(y: 50)
                    }
                }
                .frame(height: 220)
                Spacer().frame(height: 60)
                // Get Motivated Button
                Button(action: { print("Get Motivated tapped") }) {
                    Text("GET MOTIVATED")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(hex: "#FFC107"))
                        .frame(width: 340, height: 50)
                        .background(Color.black)
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                }
                .padding(.top, 0)
                Spacer().frame(height: 20)
                // Skip Button
                Button(action: { print("Skip tapped") }) {
                    Text("SKIP")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.black)
                }
                Spacer()
                // Footer
                HStack {
                    HStack(spacing: 5) {
                        Image(systemName: "bolt.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color(hex: "#FFC107"))
                        Text("Centr")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.black)
                    }
                    Spacer()
                    HStack(spacing: 5) {
                        Text("curated by")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.black)
                        Image(systemName: "m.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                        Text("MOBBIN")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
            }
        }
    }
}

struct NotificationBannerView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "bolt.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(Color(hex: "#FFC107"))
                .padding(.top, 8)
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("Your Plan is READY 💪🍎🧘")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                    Text("now")
                        .font(.system(size: 16, weight: .medium))
                        .italic()
                        .foregroundColor(Color(hex: "#A1A1A1"))
                }
                Text("Check out your workouts, meal plan and mindset activities for next week!")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.white)
                    .lineSpacing(3)
            }
            Spacer()
        }
        .padding(15)
        .frame(width: 340, height: 100)
        .background(Color(hex: "#2C2C2E"))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

struct GetMotivatedView_Previews: PreviewProvider {
    static var previews: some View {
        GetMotivatedView()
    }
} 