//
//  FoucasuApp.swift
//  Foucasu
//
//  Created by Wei Chu on 2024/6/15.
//

import SwiftUI

@main
struct FoucasuApp: App {
    // MARK: - Properties
    
    @Environment(\.scenePhase) var phase
    @State var lastActiveTimeStamp: Date = .init()

    let tabBarData: TabBarData = .init()
    let focusViewModel: FocusViewModel = .init()
    
    var body: some Scene {
        WindowGroup {
            TabBarView(tabBarData: tabBarData, focusViewModel: focusViewModel)
        }
        .onChange(of: phase, { _, newValue in
            if focusViewModel.isStarted {
                if newValue == .background {
                    lastActiveTimeStamp = Date()
                }
                
                if newValue == .active {
                    let currentTimeStampDiff = Date().timeIntervalSince(lastActiveTimeStamp)
                    if focusViewModel.totalSeconds - Int(currentTimeStampDiff) <= 0 {
                        focusViewModel.isStarted = false
                        focusViewModel.totalSeconds = 0
                        focusViewModel.isFinished = true
                    } else {
                        focusViewModel.totalSeconds -= Int(currentTimeStampDiff)
                    }
                }
            }
        })
    }
}
