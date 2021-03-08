//
//  TimerBrain.swift
//  PomodoroTimer
//
//  Created by Ikmal Azman on 22/02/2021.
//

import Foundation
struct TimerBrain
{
    var workLabel : String?
    
    
    mutating func getWorkLabel(_ task : String )
    {
        workLabel = task
    }
    
    func setLabel ()->String
    {
        return workLabel ?? "ERROR"
    }
    
    
}
