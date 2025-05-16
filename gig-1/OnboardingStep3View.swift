import SwiftUI

struct OnboardingStep3View: View {
    @ObservedObject var viewModel: OnboardingViewModel
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(step: 3, totalSteps: 8)
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("CENTR MEMBERS ACHIEVE THEIR GOALS.\n\(viewModel.firstName.uppercased()), YOU'RE NEXT.")
                        .font(.system(size: 32, weight: .black))
                        .foregroundColor(.black)
                        .padding(.bottom, 8)
                    // Before/After Testimonial Card
                    ZStack(alignment: .bottomLeading) {
                        HStack(spacing: 0) {
                            Rectangle()
                                .fill(Color(.systemGray4))
                                .frame(width: 180, height: 180)
                                .overlay(
                                    Text("Before/After\nImage")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                )
                            Spacer()
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text("ALEXANDER")
                                .font(.system(size: 24, weight: .black))
                                .foregroundColor(.white)
                            Text("A transformational testament to losing weight, gaining muscle, and boosting confidence.")
                                .font(.body)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.black)
                        .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                        .padding(.leading, 0)
                        .padding(.bottom, 0)
                    }
                    // 5-star reviews and awards
                    VStack(spacing: 12) {
                        Text("Over 40,000 5-star reviews")
                            .font(.title3).bold()
                            .multilineTextAlignment(.center)
                        HStack(spacing: 32) {
                            VStack(spacing: 4) {
                                Image(systemName: "laurel.leading")
                                Text("App of the Day\nApp Store")
                                    .font(.caption)
                                    .multilineTextAlignment(.center)
                            }
                            VStack(spacing: 4) {
                                Image(systemName: "laurel.trailing")
                                Text("Best Personal Growth\nGoogle Play")
                                    .font(.caption)
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                    // Review Card
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 2) {
                            ForEach(0..<5) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.yellow)
                            }
                        }
                        Text("Excellent in every way!")
                            .font(.title3).bold()
                        Text("Centr makes it easy to commit, and I've improved my fitness, developed muscles, improved strength, flexibility, and balance. I've loved all the trainers who guide, encourage, and make workouts as enjoyable as possible. The recipes, meditations, and articles are a great bonus.")
                            .font(.body)
                        Text("Kim")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color(.systemGray4), radius: 2, x: 0, y: 1)
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
            }
            Spacer()
            Button(action: { viewModel.step = 4 }) {
                Text("HIT YOUR GOALS")
                    .font(.headline)
                    .foregroundColor(Color.yellow)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
        }
        .background(Color(.systemGray6).ignoresSafeArea())
    }
} 