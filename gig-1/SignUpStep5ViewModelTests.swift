import XCTest
@testable import YourAppModuleName

class SignUpStep5ViewModelTests: XCTestCase {
    var viewModel: SignUpStep5ViewModel!

    override func setUp() {
        super.setUp()
        viewModel = SignUpStep5ViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertNil(viewModel.selectedOption)
        XCTAssertFalse(viewModel.isContinueEnabled)
    }

    func testSelectionLogic() {
        viewModel.selectOption(.fullGym)
        XCTAssertEqual(viewModel.selectedOption, .fullGym)
        viewModel.selectOption(.dumbbells)
        XCTAssertEqual(viewModel.selectedOption, .dumbbells)
        // Only one option can be selected at a time
        viewModel.selectOption(.bodyweight)
        XCTAssertEqual(viewModel.selectedOption, .bodyweight)
    }

    func testContinueButtonEnabled() {
        XCTAssertFalse(viewModel.isContinueEnabled)
        viewModel.selectOption(.cableMachine)
        XCTAssertTrue(viewModel.isContinueEnabled)
        viewModel.isLoading = true
        XCTAssertFalse(viewModel.isContinueEnabled)
    }

    func testSubmitSetsLoadingAndCallsCompletion() {
        viewModel.selectOption(.basicEquipment)
        let expectation = self.expectation(description: "Submit completion called")
        viewModel.submit { result in
            switch result {
            case .success():
                XCTAssertFalse(self.viewModel.isLoading)
                expectation.fulfill()
            case .failure(_):
                XCTFail("Should not fail")
            }
        }
        XCTAssertTrue(viewModel.isLoading)
        waitForExpectations(timeout: 2.0)
    }
} 