//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Ikmal Azman on 07/02/2021.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController
{
    
    
    // 25 minutes = 1500 seconds
    var secondsPassed = 0
    var taskTimer = 0
    var currentTimer : Int?
    var taskName : String?
    
    //audio player provides audio playback
    var player : AVAudioPlayer?

  
    
    
    var sessionSelected : String?
    let sessiontTimes = ["Work":1500,"Break":300]
    
    var isPaused = true
    
    // declare timer class
    var timer = Timer()
    
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerProgressBar: UIProgressView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var completeBtn: UIButton!
    @IBOutlet weak var workBtn: UIButton!
    @IBOutlet weak var breakBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //set text for taskname
        taskLabel.text = taskName
     
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8392156863, blue: 0.4196078431, alpha: 1)
        
        //make button edge round
        startBtn.layer.cornerRadius = 25.0
        completeBtn.layer.cornerRadius = 25.0
    }
    
    
    @IBAction func sessionChanged(_ sender: UIButton)
    {
        
        // stop timer
        timer.invalidate()
        
        workBtn.isSelected = false
        breakBtn.isSelected = false
        //highligght button that got selected
        sender.isSelected = true
        
        sessionSelected  = sender.currentTitle
        
        //set timer label
        timerLabel.text = String(sessiontTimes[sessionSelected!]! / 60)
        
        if sessionSelected == "Work"
        {
            view.backgroundColor = #colorLiteral(red: 1, green: 0.8392156863, blue: 0.4196078431, alpha: 1)
        }
        else
        {
            view.backgroundColor = #colorLiteral(red: 0.4392156863, green: 0.6862745098, blue: 0.5215686275, alpha: 1)
        }

        
       
    }
    
    @IBAction func startButton(_ sender: UIButton) {
    
        
        timerProgressBar.progress = 0
        print(startBtn.currentTitle!)
        taskTimer = 0
        
       
        
        if isPaused
        {
            taskTimer = sessiontTimes[sessionSelected ?? "Work"]!
            //start/resume timer
            startBtn.setTitle("Stop", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
            isPaused = false
            print(isPaused)
            
        }
        else
        {
            //pause timer
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: false)
            startBtn.setTitle("Start", for: .normal)
            isPaused = true
            print(isPaused)
            print(taskTimer)
           
            
        }
        
       

        
    }
    
    @IBAction func completePressed(_ sender: UIButton)
    {
        timerProgressBar.progress = 0
        taskLabel.text = ""
        timer.invalidate()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func timerUpdate()
    {
        
        if  secondsPassed < taskTimer
        {
            secondsPassed += 1
            print(secondsPassed)
            
            //convert to minutes, second
            let seconds  = (taskTimer - secondsPassed) % 60
            let minutes = ((taskTimer - secondsPassed)/60) % 60
            // format text to 00:00
            
            timerLabel.text = String(format: "%02d:%02d", minutes,seconds)
            print(Float(currentTimer ?? 0) / Float(taskTimer))
            var percentageProgress = Float(secondsPassed) / Float(taskTimer)
            timerProgressBar.progress = percentageProgress
            print(percentageProgress)
            
            
        }
        else
        {
            timer.invalidate()
            playSound()
        }
        print("current timer \(Float(currentTimer ?? 0) / Float(taskTimer))")
        
        
    }
    

    func updateUI()
    {
        workBtn.isSelected = false
        breakBtn.isSelected = false
    }
    func playSound()
    {
        //Bundle , resource stored in bundle directory on disk
        //main , allow resouces to be access in the same directory
        //url , file path
        let url = Bundle.main.url(forResource: "CountdownTimer", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        //play sound
        player?.play()
    }
    
}

