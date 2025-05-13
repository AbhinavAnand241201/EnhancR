import Foundation
import Combine

enum TrainingOption: CaseIterable, Equatable, Identifiable {
    case fullGym
    case basicEquipment
    case cableMachine
    case dumbbells
    case bodyweight

    var id: String { title }
    var title: String {
        switch self {
        case .fullGym: return "Full gym"
        case .basicEquipment: return "Basic equipment"
        case .cableMachine: return "Cable machine only"
        case .dumbbells: return "Dumbbells only"
        case .bodyweight: return "Bodyweight only"
        }
    }
    var subtitle: String? {
        switch self {
        case .basicEquipment: return "Such as bench, barbells and dumbbells"
        default: return nil
        }
    }
    var imageName: String {
        switch self {
        case .fullGym: return "full_gym"
        case .basicEquipment: return "basic_equipment"
        case .cableMachine: return "cable_machine"
        case .dumbbells: return "dumbbells"
        case .bodyweight: return "bodyweight"
        }
    }
}

class SignUpStep5ViewModel: ObservableObject {
    @Published var selectedOption: TrainingOption? = nil
    @Published var isLoading: Bool = false

    var isContinueEnabled: Bool {
        selectedOption != nil && !isLoading
    }

    func selectOption(_ option: TrainingOption) {
        selectedOption = option
    }

    func submit(completion: @escaping (Result<Void, Error>) -> Void) {
        guard isContinueEnabled else { return }
        isLoading = true
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isLoading = false
            completion(.success(()))
        }
    }
} 