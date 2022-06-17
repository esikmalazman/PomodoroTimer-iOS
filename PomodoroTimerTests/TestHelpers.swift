//
//  TestHelpers.swift
//  PomodoroTimerTests
//
//  Created by Ikmal Azman on 17/06/2022.
//

import UIKit
import XCTest

//MARK: - TextField
/// Helper to make textField as first responder
func textFieldBecomeFirstResponder(_ textField : UITextField,
                                   file : StaticString = #file,
                                   line : UInt = #line ) {
    textField.becomeFirstResponder()
    /// Verify if the textfield has become first response, assert act as precondition
    XCTAssertTrue(textField.isFirstResponder, "pre-condition: textField is not first responder", file: file, line: line)
}

/// Helper to active delegate method  textFieldShouldEndEditing(_ textField)
func textFieldShouldEndEditing(_ textField : UITextField) -> Bool? {
   return textField.delegate?.textFieldShouldEndEditing?(textField)
}

/// Helper to active delegate method  textFieldShouldReturn(_ textField)
@discardableResult
func textFieldShouldReturn(_ textField : UITextField) -> Bool? {
    return textField.delegate?.textFieldShouldReturn?(textField)
}

//MARK: - UIKit 
/// Helper to add vc into view hierarchy
func putViewInViewHeirarchy(_ vc : UIViewController) {
    let window = UIWindow()
    window.addSubview(vc.view)
}

/// Helper to execute registered events in UIKit immediately
func executeRunLoop() {
    RunLoop.current.run(until: Date())
}
