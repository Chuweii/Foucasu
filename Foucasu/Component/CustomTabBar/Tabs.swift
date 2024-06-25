//
//  Tabs.swift
//  Foucasu
//
//  Created by Wei Chu on 2024/6/15.
//

import Foundation

enum Tabs: String, CaseIterable {
    case Focus, List
    
    var image: String {
        switch self {
        case .Focus:
            return "timer.circle"
        case .List:
            return "list.bullet.clipboard"
        }
    }
    
    var selectedImage: String {
        switch self {
        case .Focus:
            return "timer.circle.fill"
        case .List:
            return "list.bullet.clipboard.fill"
        }
    }
}
