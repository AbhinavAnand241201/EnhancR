import SwiftUI

struct ProfileStat: Identifiable, Hashable {
    let id = UUID()
    let icon: String
    let label: String
    let value: String
}

class ProfileViewModel: ObservableObject {
    @Published var name: String = "Alex Johnson"
    @Published var email: String = "alex.johnson@email.com"
    @Published var profileImage: String? = nil // Use asset name or nil for default
    @Published var stats: [ProfileStat] = [
        ProfileStat(icon: "flame.fill", label: "Workouts", value: "24"),
        ProfileStat(icon: "note.text", label: "Logs", value: "12"),
        ProfileStat(icon: "camera.fill", label: "Selfies", value: "8")
    ]
}

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    var body: some View {
        ZStack {
            Color(hex: "#F5F5F5").ignoresSafeArea()
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Image & Edit Button
                    ZStack(alignment: .topTrailing) {
                        if let imageName = viewModel.profileImage {
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 110, height: 110)
                                .clipShape(Circle())
                                .shadow(radius: 8)
                                .padding(.top, 32)
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 110, height: 110)
                                .foregroundColor(Color(hex: "#C7C7CC"))
                                .shadow(radius: 8)
                                .padding(.top, 32)
                        }
                        Button(action: { /* Edit action */ }) {
                            Image(systemName: "pencil.circle.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.accentColor)
                                .background(Color(.systemBackground))
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .offset(x: 10, y: 10)
                    }
                    // Username
                    Text(viewModel.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text(viewModel.email)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    // Stats Cards
                    HStack(spacing: 20) {
                        ForEach(viewModel.stats) { stat in
                            ProfileStatCard(icon: stat.icon, label: stat.label, value: stat.value)
                        }
                    }
                    .padding(.horizontal)
                    // Settings List
                    VStack(spacing: 16) {
                        ProfileSettingRow(icon: "person.fill", label: "Account")
                        ProfileSettingRow(icon: "bell.fill", label: "Notifications")
                        ProfileSettingRow(icon: "questionmark.circle.fill", label: "Help & Support")
                        ProfileSettingRow(icon: "arrow.right.square.fill", label: "Log Out", iconColor: Color.red)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                    Spacer()
                }
            }
        }
    }
}

struct ProfileStatCard: View {
    let icon: String
    let label: String
    let value: String
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 28))
                .foregroundColor(.accentColor)
            Text(value)
                .font(.title2)
                .fontWeight(.semibold)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(width: 90, height: 110)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(18)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

struct ProfileSettingRow: View {
    var icon: String
    var label: String
    var iconColor: Color = Color(hex: "#8E8E93")
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(iconColor)
            Text(label)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color(hex: "#C7C7CC"))
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
} 