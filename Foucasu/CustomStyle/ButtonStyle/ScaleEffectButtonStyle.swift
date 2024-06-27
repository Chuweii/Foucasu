//
//  ScaleEffectButtonStyle.swift
//  Foucasu
//
//  Created by Wei Chu on 2024/6/26.
//

import SwiftUI

struct ScaleEffectButtonStyle: ButtonStyle {
    let scale: CGFloat
    
    init(scale: CGFloat = 0.9) {
        self.scale = scale
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1)
            .animation(.snappy(duration: 0.3, extraBounce: 0), value: configuration.isPressed)
    }
}
