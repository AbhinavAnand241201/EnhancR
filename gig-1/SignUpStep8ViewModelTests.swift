import XCTest
@testable import YourAppModuleName

class SignUpStep8ViewModelTests: XCTestCase {
    var viewModel: SignUpStep8ViewModel!

    override func setUp() {
        super.setUp()
        viewModel = SignUpStep8ViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertTrue(viewModel.selectedOptions.isEmpty)
        XCTAssertFalse(viewModel.isContinueEnabled)
    }

    func testMultipleSelection() {
        viewModel.toggleOption(.improveFocus)
        XCTAssertTrue(viewModel.isSelected(.improveFocus))
        viewModel.toggleOption(.sleepBetter)
        XCTAssertTrue(viewModel.isSelected(.sleepBetter))
        XCTAssertTrue(viewModel.isSelected(.improveFocus))
        XCTAssertFalse(viewModel.isSelected(.none))
    }

    func testNoneOfTheAboveExclusivity() {
        viewModel.toggleOption(.none)
        XCTAssertTrue(viewModel.isSelected(.none))
        XCTAssertEqual(viewModel.selectedOptions, [.none])
        // Selecting another option deselects 'None of the above'
        viewModel.toggleOption(.sleepBetter)
        XCTAssertTrue(viewModel.isSelected(.sleepBetter))
        XCTAssertFalse(viewModel.isSelected(.none))
        // Selecting 'None of the above' again deselects others
        viewModel.toggleOption(.none)
        XCTAssertTrue(viewModel.isSelected(.none))
        XCTAssertFalse(viewModel.isSelected(.sleepBetter))
    }

    func testContinueButtonEnabled() {
        XCTAssertFalse(viewModel.isContinueEnabled)
        viewModel.toggleOption(.reduceStress)
        XCTAssertTrue(viewModel.isContinueEnabled)
        viewModel.isLoading = true
        XCTAssertFalse(viewModel.isContinueEnabled)
    }

    func testSubmitSetsLoadingAndCallsCompletion() {
        viewModel.toggleOption(.increaseRelaxation)
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