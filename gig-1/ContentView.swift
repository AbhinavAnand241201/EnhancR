//
//  ContentView.swift
//  gig-1
//
//  Created by ABHINAV ANAND  on 11/05/25.
//

import SwiftUI
import CoreData

// MARK: - ViewModel
class OnboardingViewModel: ObservableObject {
    enum Sex: String, CaseIterable {
        case Male, Female
    }
    enum FitnessGoal: String, CaseIterable, Identifiable {
        case buildStrength = "Build Strength"
        case loseFat = "Lose Fat"
        case getToned = "Get Toned"
        case gainMuscle = "Gain Muscle"
        case stayHealthy = "Stay Healthy and Fit"
        case increaseCardio = "Increase Cardio Endurance"
        case everydayStrength = "Everyday Strength and Mobility"
        
        var id: String { self.rawValue }
    }
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var selectedSex: Sex? = nil
    @Published var selectedGoal: FitnessGoal? = nil
    @Published var step: Int = 1
    
    var isContinueEnabled: Bool {
        !firstName.isEmpty && !lastName.isEmpty && selectedSex != nil
    }
    var isNextStepEnabled: Bool {
        selectedGoal != nil
    }
}

// MARK: - Step 1 View
struct OnboardingStep1View: View {
    @ObservedObject var viewModel: OnboardingViewModel
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(step: 1, totalSteps: 8)
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("FIRST THINGS FIRST:\nLET'S GET TO KNOW YOU")
                        .font(.system(size: 32, weight: .black))
                        .foregroundColor(.black)
                        .padding(.bottom, 8)
                    VStack(alignment: .leading, spacing: 16) {
                        Group {
                            Text("First Name")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            TextField("", text: $viewModel.firstName)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).stroke(Color(.systemGray3)))
                        }
                        Group {
                            Text("Last Name")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            TextField("", text: $viewModel.lastName)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).stroke(Color(.systemGray3)))
                        }
                        Group {
                            Text("Your Sex")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            VStack(spacing: 12) {
                                ForEach(OnboardingViewModel.Sex.allCases, id: \.self) { sex in
                                    HStack {
                                        Button(action: { viewModel.selectedSex = sex }) {
                                            ZStack {
                                                Circle()
                                                    .stroke(Color(.systemGray3), lineWidth: 2)
                                                    .frame(width: 24, height: 24)
                                                if viewModel.selectedSex == sex {
                                                    Circle()
                                                        .fill(Color.black)
                                                        .frame(width: 12, height: 12)
                                                }
                                            }
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        Text(sex.rawValue)
                                            .font(.body)
                                            .foregroundColor(.black)
                                        Spacer()
                                    }
                                    .padding(8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color(.systemGray3))
                                            .background(
                                                viewModel.selectedSex == sex ? Color(.systemGray5) : Color.clear
                                            )
                                            .cornerRadius(12)
                                    )
                                }
                            }
                        }
                    }
                    HStack(alignment: .center, spacing: 4) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.black)
                        Button(action: { /* Show info */ }) {
                            Text("Why do we need this?")
                                .font(.subheadline)
                                .underline()
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.top, 8)
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
            }
            Spacer()
            Button(action: {
                if viewModel.isContinueEnabled {
                    viewModel.step = 2
                }
            }) {
                Text("CONTINUE")
                    .font(.headline)
                    .foregroundColor(viewModel.isContinueEnabled ? Color.yellow : Color(.systemGray3))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isContinueEnabled ? Color.black : Color(.systemGray3))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
            .disabled(!viewModel.isContinueEnabled)
        }
        .background(Color(.systemGray6).ignoresSafeArea())
    }
}

// MARK: - Step 2 View
struct OnboardingStep2View: View {
    @ObservedObject var viewModel: OnboardingViewModel
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(step: 2, totalSteps: 8)
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("WHAT'S YOUR TOP\nFITNESS GOAL, \(viewModel.firstName)?")
                        .font(.system(size: 32, weight: .black))
                        .foregroundColor(.black)
                        .padding(.bottom, 8)
                    VStack(spacing: 12) {
                        ForEach(OnboardingViewModel.FitnessGoal.allCases) { goal in
                            HStack {
                                Button(action: { viewModel.selectedGoal = goal }) {
                                    ZStack {
                                        Circle()
                                            .stroke(Color(.systemGray3), lineWidth: 2)
                                            .frame(width: 24, height: 24)
                                        if viewModel.selectedGoal == goal {
                                            Circle()
                                                .fill(Color.black)
                                                .frame(width: 12, height: 12)
                                        }
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                Text(goal.rawValue)
                                    .font(.body)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(.systemGray3))
                                    .background(
                                        viewModel.selectedGoal == goal ? Color(.systemGray5) : Color.clear
                                    )
                                    .cornerRadius(12)
                            )
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
            }
            Spacer()
            Button(action: { /* Next step action */ }) {
                Text("TAKE THE NEXT STEP")
                    .font(.headline)
                    .foregroundColor(viewModel.isNextStepEnabled ? Color.yellow : Color(.systemGray3))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isNextStepEnabled ? Color.black : Color(.systemGray3))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
            .disabled(!viewModel.isNextStepEnabled)
        }
        .background(Color(.systemGray6).ignoresSafeArea())
    }
}

// MARK: - Top Bar View
struct TopBarView: View {
    let step: Int
    let totalSteps: Int
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { /* Back action */ }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .padding(.leading, 8)
                }
                Spacer()
                Text("Step \(step) of \(totalSteps)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.trailing, 8)
            }
            .padding(.top, 16)
            .padding(.bottom, 8)
            // Progress bar
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color(.systemGray5))
                    .frame(height: 3)
                Rectangle()
                    .fill(Color.black)
                    .frame(width: UIScreen.main.bounds.width * CGFloat(step) / CGFloat(totalSteps), height: 3)
            }
            .padding(.bottom, 16)
        }
    }
}

// MARK: - Main ContentView
struct ContentView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    var body: some View {
        Group {
            switch viewModel.step {
            case 1:
                OnboardingStep1View(viewModel: viewModel)
            case 2:
                OnboardingStep2View(viewModel: viewModel)
            case 3:
                OnboardingStep3View(viewModel: viewModel)
            case 4:
                OnboardingStep4View(viewModel: viewModel)
            default:
                OnboardingStep1View(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
