import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Int = 0 // 0: My plan, 1: Activity, 2: Programs, 3: Profile
    @State private var selectedDate: Int = 4 // Tuesday, 4th March
    let days: [(name: String, num: Int)] = [
        ("Mon", 3), ("Tue", 4), ("Wed", 5), ("Thu", 6), ("Fri", 7), ("Sat", 8), ("Sun", 9)
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if selectedTab == 3 {
                ProfileView()
            } else {
                Color(hex: "#F5F5F5").ignoresSafeArea()
                VStack(spacing: 0) {
                    // Status Bar (simulated)
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
                    // Main Scrollable Content
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 0) {
                            // HOME header
                            Text("HOME")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.top, 20)
                                .padding(.horizontal, 16)
                            // Hi Alex
                            Text("Hi Alex")
                                .font(.system(size: 34, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.top, 20)
                                .padding(.horizontal, 16)
                            // Tabs and Gear
                            HStack(spacing: 10) {
                                Button(action: { selectedTab = 0 }) {
                                    Text("My plan")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(selectedTab == 0 ? Color(hex: "#E5E5EA") : Color.white)
                                        .cornerRadius(15)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color(hex: "#C7C7CC"), lineWidth: selectedTab == 0 ? 0 : 1)
                                        )
                                }
                                Button(action: { selectedTab = 1 }) {
                                    Text("Activity")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(selectedTab == 1 ? Color(hex: "#E5E5EA") : Color.white)
                                        .cornerRadius(15)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color(hex: "#C7C7CC"), lineWidth: selectedTab == 1 ? 0 : 1)
                                        )
                                }
                                Button(action: { selectedTab = 2 }) {
                                    Text("Programs")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(selectedTab == 2 ? Color(hex: "#E5E5EA") : Color.white)
                                        .cornerRadius(15)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color(hex: "#C7C7CC"), lineWidth: selectedTab == 2 ? 0 : 1)
                                        )
                                }
                                Spacer()
                                Button(action: { /* Settings */ }) {
                                    Image(systemName: "gearshape")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(.black)
                                }
                            }
                            .padding(.top, 10)
                            .padding(.horizontal, 16)
                            // Date Header
                            Text("MARCH 2025")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.black)
                                .padding(.top, 20)
                                .padding(.horizontal, 16)
                            // Calendar Scroll
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    Button(action: { /* Previous week */ }) {
                                        Image(systemName: "chevron.left")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(Color(hex: "#C7C7CC"))
                                    }
                                    ForEach(0..<days.count, id: \.self) { idx in
                                        let day = days[idx]
                                        let isSelected = day.num == selectedDate
                                        VStack(spacing: 4) {
                                            Text(day.name)
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundColor(isSelected ? .black : Color(hex: "#8E8E93"))
                                            Button(action: { selectedDate = day.num }) {
                                                Text("\(day.num)")
                                                    .font(.system(size: 16, weight: .medium))
                                                    .foregroundColor(isSelected ? .white : .black)
                                                    .frame(width: 40, height: 40)
                                                    .background(isSelected ? Color.black : Color.white)
                                                    .clipShape(Circle())
                                                    .overlay(
                                                        Circle()
                                                            .stroke(Color(hex: "#C7C7CC"), lineWidth: isSelected ? 0 : 1)
                                                    )
                                            }
                                            Circle()
                                                .frame(width: 5, height: 5)
                                                .foregroundColor(isSelected ? .black : .clear)
                                        }
                                    }
                                    Button(action: { /* Next week */ }) {
                                        Image(systemName: "chevron.right")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.black)
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                            .padding(.top, 10)
                            // MOVE Section
                            HStack(spacing: 8) {
                                Image(systemName: "figure.run")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color(hex: "#00C4B4"))
                                Text("MOVE")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                            }
                            .padding(.top, 20)
                            .padding(.horizontal, 16)
                            // Workout Card
                            ZStack(alignment: .bottomLeading) {
                                Image("set-3")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 340, height: 180)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.clear,
                                        Color(hex: "#00C4B4").opacity(0.7)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .frame(width: 340, height: 180)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                VStack(alignment: .leading, spacing: 5) {
                                    Spacer()
                                    Text("Power Shred at Home:\nIntermediate")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                    Text("0/84")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.white)
                                    Text("Next: Lower-body fire up")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.white)
                                    Text("35 MIN")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.white)
                                }
                                .padding(.leading, 15)
                                .padding(.bottom, 15)
                                .frame(width: 340, height: 180, alignment: .leading)
                                HStack {
                                    Spacer()
                                    VStack {
                                        Spacer()
                                        Button(action: { /* Play workout */ }) {
                                            ZStack {
                                                Circle()
                                                    .fill(Color.white)
                                                    .frame(width: 50, height: 50)
                                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                                                Image(systemName: "play.fill")
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                    .foregroundColor(.black)
                                            }
                                        }
                                        .padding(.trailing, 15)
                                        .padding(.bottom, 15)
                                    }
                                }
                            }
                            .frame(width: 340, height: 180)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            .padding(.top, 10)
                            .padding(.horizontal, 16)
                            // MEALS Section
                            HStack(spacing: 8) {
                                Image(systemName: "bowl.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color(hex: "#8B9467"))
                                Text("MEALS")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                            }
                            .padding(.top, 20)
                            .padding(.horizontal, 16)
                            // SHOPPING LIST Button
                            Button(action: { /* Shopping list */ }) {
                                HStack(spacing: 10) {
                                    Image(systemName: "cart.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(Color(hex: "#8E8E93"))
                                    Text("SHOPPING LIST")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                .padding(.horizontal, 15)
                                .frame(width: 340, height: 50)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            }
                            .padding(.top, 10)
                            .padding(.horizontal, 16)
                            // Footer
                            HStack {
                                HStack(spacing: 5) {
                                    Image(systemName: "bolt.fill") // Placeholder for Centr logo
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
                                    Image(systemName: "m.circle.fill") // Placeholder for Mobbin logo
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.black)
                                    Text("MOBBIN")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.black)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 20)
                            .padding(.bottom, 80) // For bottom nav
                        }
                    }
                }
                // Bottom Navigation Bar
                VStack(spacing: 0) {
                    Spacer()
                    Divider()
                    HStack {
                        Spacer()
                        VStack {
                            Button(action: { selectedTab = 0 }) {
                                Image(systemName: "house.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(selectedTab == 0 ? .black : Color(hex: "#8E8E93"))
                            }
                            Text("Home")
                                .font(.system(size: 10, weight: .regular))
                                .foregroundColor(selectedTab == 0 ? .black : Color(hex: "#8E8E93"))
                        }
                        Spacer()
                        VStack {
                            Button(action: { selectedTab = 1 }) {
                                Image(systemName: "safari.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(selectedTab == 1 ? .black : Color(hex: "#8E8E93"))
                            }
                            Text("Explore")
                                .font(.system(size: 10, weight: .regular))
                                .foregroundColor(selectedTab == 1 ? .black : Color(hex: "#8E8E93"))
                        }
                        Spacer()
                        VStack {
                            Button(action: { selectedTab = 2 }) {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(selectedTab == 2 ? .black : Color(hex: "#8E8E93"))
                            }
                            Text("Programs")
                                .font(.system(size: 10, weight: .regular))
                                .foregroundColor(selectedTab == 2 ? .black : Color(hex: "#8E8E93"))
                        }
                        Spacer()
                        VStack {
                            Button(action: { selectedTab = 3 }) {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(selectedTab == 3 ? .black : Color(hex: "#8E8E93"))
                            }
                            Text("Profile")
                                .font(.system(size: 10, weight: .regular))
                                .foregroundColor(selectedTab == 3 ? .black : Color(hex: "#8E8E93"))
                        }
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .ignoresSafeArea(.all, edges: .bottom)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
} 