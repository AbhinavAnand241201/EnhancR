import Foundation
import Combine

enum MindsetOption: String, CaseIterable, Identifiable, Equatable {
    case improveFocus = "Improve focus and motivation"
    case sleepBetter = "Sleep better"
    case increaseRelaxation = "Increase relaxation"
    case reduceStress = "Reduce stress and anxiety"
    case none = "None of the above"

    var id: String { rawValue }
}

class SignUpStep8ViewModel: ObservableObject {
    @Published var selectedOptions: Set<MindsetOption> = []
    @Published var isLoading: Bool = false

    var isContinueEnabled: Bool {
        !selectedOptions.isEmpty && !isLoading
    }

    func toggleOption(_ option: MindsetOption) {
        if option == .none {
            if selectedOptions.contains(.none) {
                selectedOptions.remove(.none)
            } else {
                selectedOptions = [.none]
            }
        } else {
            if selectedOptions.contains(option) {
                selectedOptions.remove(option)
            } else {
                selectedOptions.insert(option)
                selectedOptions.remove(.none)
            }
        }
    }

    func isSelected(_ option: MindsetOption) -> Bool {
        selectedOptions.contains(option)
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