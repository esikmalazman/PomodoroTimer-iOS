//
//  StartingViewController.swift
//  PomodoroTimer
//
//  Created by Ikmal Azman on 08/02/2021.
//

import UIKit

class TaskViewController: UIViewController
{

    var timerBrain =  TimerBrain()
    @IBOutlet weak var workTextField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    
//    var workLabel : String?
    
    
    override func viewDidLoad()
    {
        // make button round
        nextBtn.layer.cornerRadius = 25.0
        workTextField.delegate = self
    }
    
    @IBAction func nextBtnPressed(_ sender: UIButton)
    {
        //notify view controller, it set as delegate
        
        print("I pressed")
        
        //set work label text
//        workLabel = workTextField.text
        
        //assign to timer brain function
        if let workLabel = workTextField.text
        {
            timerBrain.getWorkLabel(workLabel)
        }
        
        // hide keyboard when button pressed
        // transition to another screen
        
        //if textfield null , it will not move to other screen
        if workTextField.text != ""
        {
            performSegue(withIdentifier: "goToTimer", sender: self)
        }
        else
        {
            workTextField.placeholder = "Task To Do?"
        }
        
    }
    
    //make prepartion before transit to another screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //safety check for identifier
        if segue.identifier == "goToTimer"
        {
            // set destination page to transit
            let destinationVC = segue.destination as! TimerViewController
            destinationVC.taskName = timerBrain.setLabel()
        }
    }
    

    

}

//MARK:- UITextFieldDelegate
extension TaskViewController : UITextFieldDelegate
{
    //return value to textfield if return button pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //assign task to variable after user press next
        if let workLabel = textField.text
        {
            timerBrain.getWorkLabel(workLabel)
        }
        workTextField.endEditing(true)
        //moved to other screen after next button pressed
        performSegue(withIdentifier: "goToTimer", sender: nextBtn)
        return true
    }
    //perform validation , prevent null value
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        //if textfield null, keyboard not dismiss
        if textField.text != ""
        {
            
            return true
        }
        else
        {
            textField.placeholder = "Task To Do?"
            return false
        }
    }
    
}
