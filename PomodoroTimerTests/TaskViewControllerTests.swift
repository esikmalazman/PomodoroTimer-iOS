@testable import PomodoroTimer
import XCTest

final class TaskViewControllerTests: XCTestCase {
    
    var sut : TaskViewController!
    
    override func setUp() {
        super.setUp()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        sut = sb.instantiateViewController(identifier: "\(TaskViewController.self)")
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    /// Test verify outlets already been connected
    func test_outlets_shouldBeConnected() {
        XCTAssertNotNil(sut.workTextField, "workTextField")
        XCTAssertNotNil(sut.nextBtn, "nextBtn")
    }
    
    /// Test verify delegate of the textfield being set
    func test_workTextFieldDelegate_shouldBeConnected() {
        XCTAssertNotNil(sut.workTextField.delegate, "workTextField")
    }
    
    /// Test verify if textField is empty keyboard will not dismissed after return button were pressed
    func test_textFieldShouldReturn_withNoTask_shouldNotDismissedKeyboard() {
        putViewInViewHeirarchy(sut)
        sut.workTextField.becomeFirstResponder()
        /// Verify if the textfield has become first response, assert act as precondition
        XCTAssertTrue(sut.workTextField.isFirstResponder, "pre-condition")
        
        textFieldShouldReturn(sut.workTextField)
        
        XCTAssertTrue(sut.workTextField.isFirstResponder)
    }
    
    func test_textFieldShouldReturn_withTask_shouldDismissedKeyboard() {
        putViewInViewHeirarchy(sut)
        sut.workTextField.becomeFirstResponder()
        XCTAssertTrue(sut.workTextField.isFirstResponder, "pre-condition")
        
        ///  Populate task in textfield
        sut.workTextField.text = "Task 1"
        textFieldShouldReturn(sut.workTextField)
        
        XCTAssertFalse(sut.workTextField.isFirstResponder)
    }
    
    func test_textFieldShouldEndEditing_withNoTask_shouldNotEndEditing() {
        putViewInViewHeirarchy(sut)
        sut.workTextField.becomeFirstResponder()
        XCTAssertTrue(sut.workTextField.isFirstResponder, "pre-condition")
        
        let allowEndEditing = textFieldShouldEndEditing(sut.workTextField)
        
        XCTAssertEqual(allowEndEditing, false)
    }
    
    func test_textFieldShouldEndEditing_withTask_shouldEndEditing() {
        putViewInViewHeirarchy(sut)
        sut.workTextField.becomeFirstResponder()
        XCTAssertTrue(sut.workTextField.isFirstResponder, "pre-condition")
        
        sut.workTextField.text = "Task 1"
        let allowEndEditing = textFieldShouldEndEditing(sut.workTextField)
        
        XCTAssertEqual(allowEndEditing, true)
    }
    
}

func textFieldShouldEndEditing(_ textField : UITextField) -> Bool? {
   return textField.delegate?.textFieldShouldEndEditing?(textField)
}

@discardableResult
func textFieldShouldReturn(_ textField : UITextField) -> Bool? {
    return textField.delegate?.textFieldShouldReturn?(textField)
}

func putViewInViewHeirarchy(_ vc : UIViewController) {
    let window = UIWindow()
    window.addSubview(vc.view)
}
