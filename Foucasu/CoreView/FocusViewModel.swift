//
//  FocusViewModel.swift
//  Foucasu
//
//  Created by Wei Chu on 2024/6/23.
//

import Foundation
import SwiftUI
import Combine

@Observable
class FocusViewModel: NSObject, UNUserNotificationCenterDelegate {
    // MARK: - Properties
    
    var progress: CGFloat = 1
    var timerStringValue: String = "00:00"
    var isStarted: Bool = false
    var isTimerViewVisible: Bool = false
    var isFinished: Bool = false
    var isTimeAtZero: Bool {
        hour == 0 && minutes == 0 && seconds == 0
    }

    /// Timer Properties
    let timer = Timer.publish(every: 1, on: .main, in: .common)
    var timerCancellable: AnyCancellable?

    // MARK: - Time Calculate Properties
    
    var hour: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    private var totalSeconds: Int = 0
    private var staticTotalSeconds: Int = 0
    private let secondsInAnHour: Int = 3600
    
    // MARK: - Init For NSObject
    
    override init() {
        super.init()
        authorizeNotification()
    }
    
    // MARK: - Click Button
    
    func didClickSaveButton() {
        startTimer()
    }
    
    func didClickStartNewButton() {
        stopTimer()
        animatedShowTimerView(isVisible: true)
    }
    
    func didClickStopButton() {
        stopTimer()
    }
    
    func didClickEmptySpace() {
        resetTimer()
        animatedShowTimerView(isVisible: false)
    }
    
    func didClickActivityButton() {
        if isStarted {
            stopTimer()
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            
        } else {
            animatedShowTimerView(isVisible: true)
        }
    }
    
    // MARK: - Timer Methods
    
    private func startTimer() {
        withAnimation(.easeInOut(duration: 0.25)) {
            isStarted = true
            progress = 1
        }
        
        // Setting Time String Value
        setupTimeStringValue()
        
        // Calculating Total Second For Timer
        totalSeconds = (hour * secondsInAnHour) + (minutes * 60) + seconds
        staticTotalSeconds = totalSeconds
        
        animatedShowTimerView(isVisible: false)
        isFinished = false
        
        addNotification()
        
        updateTimer()
    }
    
    private func updateTimer() {
        // Cancel existing timer
        timerCancellable?.cancel()
        timerCancellable = timer
            .autoconnect()
            .sink(receiveValue: { [weak self] _ in
                self?.countingTime()
            })
    }
    
    private func countingTime() {
        if isStarted {
            totalSeconds -= 1
            progress = CGFloat(totalSeconds) / CGFloat(staticTotalSeconds)
            progress = (progress < 0 ? 0 : progress)
            
            hour = totalSeconds / secondsInAnHour
            minutes = (totalSeconds / 60) % 60
            seconds = totalSeconds % 60
            
            // Setting Time String Value
            setupTimeStringValue()

            if isTimeAtZero {
                isStarted = false
                isFinished = true
            }
        }
    }
    
    private func stopTimer() {
        withAnimation {
            isStarted = false
            isFinished = false
            resetTimer()
        }
        totalSeconds = 0
        staticTotalSeconds = 0
        timerStringValue = "00:00"
    }
    
    private func resetTimer() {
        hour = 0
        minutes = 0
        seconds = 0
    }
    
    // MARK: - Notification Center
    
    private func authorizeNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) { _, _ in }
        UNUserNotificationCenter.current().delegate = self
    }
        
    private func addNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Foucasu"
        content.subtitle = "Completed focus time!"
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(staticTotalSeconds), repeats: false)
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.sound, .banner])
    }
    
    // MARK: - Methods
    
    func animatedShowTimerView(isVisible: Bool) {
        withAnimation {
            if !isTimerViewVisible { progress = 1 }
            isTimerViewVisible = isVisible
        }
    }
    
    private func setupTimeStringValue() {
        let hourStringValue = "\(hour == 0 ? "" : "\(hour):")"
        let minutesStringValue = "\(minutes >= 10 ? "\(minutes)" : "0\(minutes)"):"
        let secondsStringValue = "\(seconds >= 10 ? "\(seconds)" : "0\(seconds)")"
        timerStringValue = hourStringValue + minutesStringValue + secondsStringValue
    }
}
