//
//  StartingViewController.swift
//  PomodoroTimer
//
//  Created by Ikmal Azman on 08/02/2021.
//

import UIKit

class StartingViewController: UIViewController {

    
    @IBOutlet weak var workTextField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    
    var workLabel : String?
    
    
    override func viewDidLoad() {
        // make button round
        nextBtn.layer.cornerRadius = 25.0
    }
    
    @IBAction func nextBtnPressed(_ sender: UIButton)
    {
        print("I pressed")
        
        //set work label text
        workLabel = workTextField.text
        // hide keyboard when button pressed
        workTextField.endEditing(true)
        // transition to another screen
        performSegue(withIdentifier: "goToTimer", sender: self)
    }
    
    //make prepartion before transit to another screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //safety check for identifier
        if segue.identifier == "goToTimer"
        {
            // set destination page to transit
            let destinationVC = segue.destination as! TimerViewController
            destinationVC.taskName = workLabel
        }
    }
    
    

}
