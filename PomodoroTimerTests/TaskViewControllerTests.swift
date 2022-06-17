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
        executeRunLoop()
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
        textFieldBecomeFirstResponder(sut.workTextField)
        sut.workTextField.becomeFirstResponder()
        
        textFieldShouldReturn(sut.workTextField)
        
        XCTAssertTrue(sut.workTextField.isFirstResponder)
    }
    
    func test_textFieldShouldReturn_withTask_shouldDismissedKeyboard() {
        putViewInViewHeirarchy(sut)
        textFieldBecomeFirstResponder(sut.workTextField)
        
        ///  Populate task in textfield
        sut.workTextField.text = "Task 1"
        textFieldShouldReturn(sut.workTextField)
        
        XCTAssertFalse(sut.workTextField.isFirstResponder)
    }
    
    func test_textFieldShouldEndEditing_withNoTask_shouldNotEndEditing() {
        putViewInViewHeirarchy(sut)
        textFieldBecomeFirstResponder(sut.workTextField)
        
        let allowEndEditing = textFieldShouldEndEditing(sut.workTextField)
        
        XCTAssertEqual(allowEndEditing, false)
    }
    
    func test_textFieldShouldEndEditing_withTask_shouldEndEditing() {
        putViewInViewHeirarchy(sut)
        textFieldBecomeFirstResponder(sut.workTextField)
        
        sut.workTextField.text = "Task 1"
        let allowEndEditing = textFieldShouldEndEditing(sut.workTextField)
        
        XCTAssertEqual(allowEndEditing, true)
    }
    
}
