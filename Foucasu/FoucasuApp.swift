//
//  CustomTabApp.swift
//  CustomTab
//
//  Created by Wei Chu on 2024/6/15.
//

import SwiftUI

@main
struct CustomTabApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .preferredColorScheme(.dark)
        }
    }
}
