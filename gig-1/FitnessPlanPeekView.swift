import SwiftUI

struct FitnessPlanPeekView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Status bar spacing
            Spacer().frame(height: 16)
            // Top bar
            HStack {
                Text("9:41")
                    .font(.system(size: 18, weight: .medium, design: .default))
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
            // Back arrow
            HStack {
                Button(action: { /* Back action */ }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
            // Title
            Text("ALEX, HERE'S A PEEK AT YOUR PERSONAL FITNESS PLAN:")
                .font(.system(size: 32, weight: .black))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 8)
            // Subtitle
            HStack(alignment: .top, spacing: 0) {
                Text("Get Stronger:")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                Text(" tailored training for total-body strength and staying power.")
                    .font(.system(size: 18))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.top, 4)
            // Main Card
            VStack(spacing: 16) {
                // Move Card
                ZStack(alignment: .topLeading) {
                    Image("set-4")
                        .resizable()
                        .aspectRatio(1.8, contentMode: .fill)
                        .frame(maxWidth: .infinity, minHeight: 180, maxHeight: 200)
                        .clipped()
                        .cornerRadius(16)
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Move")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color.blue)
                                .cornerRadius(8)
                            Spacer()
                        }
                        Spacer()
                        HStack(alignment: .center) {
                            Text("Centr Power in Gym: Intermediate")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .shadow(radius: 2)
                            Spacer()
                            Image(systemName: "lock.fill")
                                .foregroundColor(.white)
                                .padding(.trailing, 8)
                        }
                        HStack(spacing: 8) {
                            TagView(text: "13 weeks")
                            TagView(text: "Gym equipment")
                            TagView(text: "Build muscle")
                            TagView(text: "Self-guided")
                        }
                    }
                    .padding(16)
                }
                // Meals & Mind Cards
                HStack(spacing: 16) {
                    // Meals
                    ZStack(alignment: .topLeading) {
                        Image("set-6")
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 0.42, height: 100)
                            .clipped()
                            .cornerRadius(12)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Meals")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color(hex: "#7A7A3A"))
                                .cornerRadius(8)
                            Spacer()
                            HStack {
                                Text("Recipes and more")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .shadow(radius: 2)
                                Spacer()
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(12)
                    }
                    // Mind
                    ZStack(alignment: .topLeading) {
                        Image("set-5")
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 0.42, height: 100)
                            .clipped()
                            .cornerRadius(12)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Mind")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color.purple)
                                .cornerRadius(8)
                            Spacer()
                            HStack {
                                Text("Meditations and more")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .shadow(radius: 2)
                                Spacer()
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(12)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            // Unlock Button
            Button(action: { /* Unlock action */ }) {
                Text("UNLOCK YOUR PLAN NOW")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(hex: "#FFFF00"))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
            .padding(.bottom, 8)
            Spacer()
            // Footer
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "bolt.fill")
                        .foregroundColor(Color(hex: "#FFFF00"))
                    Text("Centr")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                }
                Spacer()
                Text("curated by")
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                Image(systemName: "m.circle.fill")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundColor(.black)
                Text("Mobbin")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 8)
        }
        .background(Color(hex: "#F8F8F8").ignoresSafeArea())
    }
}

struct TagView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.system(size: 13, weight: .medium))
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background(Color.white.opacity(0.2))
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.white.opacity(0.7), lineWidth: 1)
            )
    }
}

struct FitnessPlanPeekView_Previews: PreviewProvider {
    static var previews: some View {
        FitnessPlanPeekView()
    }
} 