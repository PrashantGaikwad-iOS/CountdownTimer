//
//  ViewController.swift
//  CountdownTimer
//
//  Created by Saif on 05/12/19.
//  Copyright © 2019 LeftRightMind. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    //MARK: - Properties
    var seconds = 60 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    var resumeTapped = false
    
    //MARK: - View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBActions
    @IBAction func startAction(_ sender: Any) {
        startTimer()
    }
    @IBAction func pauseAction(_ sender: Any) {
        pauseTimer()
    }
    @IBAction func resetAction(_ sender: Any) {
        resetTimer()
    }
    
    
    //MARK: - Custom Actions
    func runTimer() {
             timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
             isTimerRunning = true
             pauseButton.isEnabled = true
        }
    
    @objc func updateTimer() {
        if seconds < 1 {
             timer.invalidate()
             //Send alert to indicate "time's up!"
        } else {
             seconds -= 1
             timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    func startTimer() {
        if isTimerRunning == false {
             runTimer()
             self.startButton.isEnabled = false
        }
    }
    
    func pauseTimer() {
        if self.resumeTapped == false {
             timer.invalidate()
             self.resumeTapped = true
             self.pauseButton.setTitle("Resume",for: .normal)
        } else {
             runTimer()
             self.resumeTapped = false
             self.pauseButton.setTitle("Pause",for: .normal)
        }
    }
    
    func resetTimer() {
            timer.invalidate()
            seconds = 60
            timerLabel.text = timeString(time: TimeInterval(seconds))
            isTimerRunning = false
            pauseButton.isEnabled = false
            self.startButton.isEnabled = true
        }
        
        func timeString(time:TimeInterval) -> String {
            let hours = Int(time) / 3600
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
//            return String(format:"%02i", seconds)
        }
    
    //MARK: -

    


}

