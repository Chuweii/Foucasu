//
//  Extension.swift
//  Foucasu
//
//  Created by Wei Chu on 2024/6/23.
//

import SwiftUI

extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
