//
//  PomodoroModel.swift
//  Foucasu
//
//  Created by Wei Chu on 2024/6/23.
//

import Foundation
import SwiftUI

@Observable
class PomodoroViewModel {
    // MARK: - Timer Properties
    var progress: CGFloat = 1
    var timerStringValue: String = "00:00"
    var isStarted: Bool = false
    var isAddNewTimer: Bool = false
    
    var hour: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    private var totalSeconds: Int = 0
    private var staticTotalSeconds: Int = 0
    private let secondsInAnHour: Int = 3600
    
    private var isFinished: Bool = false
    
    var isTimeAtZero: Bool {
        hour == 0 && minutes == 0 && seconds == 0
    }
    
    // MARK: - Methods
    
    func startTimer() {
        withAnimation(.easeInOut(duration: 0.25)) { isStarted = true }
        
        // Setting Time String Value
        settingTimeStringValue()
        
        // Calculating Total Second For Timer
        totalSeconds = (hour * secondsInAnHour) + (minutes * 60) + seconds
        staticTotalSeconds = totalSeconds
        isAddNewTimer = false
    }
    
    func stopTimer() {
        withAnimation {
            isStarted = false
            resetTimer()
        }
        totalSeconds = 0
        staticTotalSeconds = 0
        timerStringValue = "00:00"
    }
    
    func updateTimer() {
        totalSeconds -= 1
        progress = CGFloat(totalSeconds) / CGFloat(staticTotalSeconds)
        progress = (progress < 0 ? 0 : progress)
        
        hour = totalSeconds / secondsInAnHour
        minutes = (totalSeconds / 60) % 60
        seconds = totalSeconds % 60
        
        // Setting Time String Value
        settingTimeStringValue()

        if isTimeAtZero {
            isStarted = false
            print("Finished")
        }
    }
    
    func resetTimer() {
        hour = 0
        minutes = 0
        seconds = 0
    }
    
    func settingTimeStringValue() {
        let hourStringValue = "\(hour == 0 ? "" : "\(hour):")"
        let minutesStringValue = "\(minutes >= 10 ? "\(minutes)" : "0\(minutes)"):"
        let secondsStringValue = "\(seconds >= 10 ? "\(seconds)" : "0\(seconds)")"
        timerStringValue = hourStringValue + minutesStringValue + secondsStringValue
    }
}
