//
//  Extension.swift
//  Foucasu
//
//  Created by Wei Chu on 2024/6/23.
//

import SwiftUI

extension View {
    @ViewBuilder
    public func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: hidden()
        case false: self
        }
    }
    
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
