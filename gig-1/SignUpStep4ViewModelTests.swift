import XCTest
@testable import YourAppModuleName

class SignUpStep4ViewModelTests: XCTestCase {
    var viewModel: SignUpStep4ViewModel!

    override func setUp() {
        super.setUp()
        viewModel = SignUpStep4ViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testEmailValidation() {
        viewModel.email = "invalid-email"
        XCTAssertEqual(viewModel.emailError, "Invalid email format")
        viewModel.email = "test@example.com"
        XCTAssertNil(viewModel.emailError)
    }

    func testPasswordValidation() {
        viewModel.password = "short"
        XCTAssertEqual(viewModel.passwordError, "Password must meet criteria")
        viewModel.password = "Password1"
        XCTAssertNil(viewModel.passwordError)
    }

    func testCheckboxToggling() {
        XCTAssertFalse(viewModel.isTrainingTipsChecked)
        viewModel.isTrainingTipsChecked = true
        XCTAssertTrue(viewModel.isTrainingTipsChecked)
        XCTAssertFalse(viewModel.isTermsChecked)
        viewModel.isTermsChecked = true
        XCTAssertTrue(viewModel.isTermsChecked)
    }

    func testContinueButtonEnabled() {
        // All invalid
        XCTAssertFalse(viewModel.isContinueEnabled)
        // Valid email, invalid password, terms unchecked
        viewModel.email = "test@example.com"
        XCTAssertFalse(viewModel.isContinueEnabled)
        // Valid password, terms unchecked
        viewModel.password = "Password1"
        XCTAssertFalse(viewModel.isContinueEnabled)
        // Terms checked
        viewModel.isTermsChecked = true
        XCTAssertTrue(viewModel.isContinueEnabled)
        // Loading disables button
        viewModel.isLoading = true
        XCTAssertFalse(viewModel.isContinueEnabled)
    }

    func testSubmitSetsLoadingAndCallsCompletion() {
        viewModel.email = "test@example.com"
        viewModel.password = "Password1"
        viewModel.isTermsChecked = true
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