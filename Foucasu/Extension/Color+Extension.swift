//
//  Color+Extension.swift
//  Foucasu
//
//  Created by Wei Chu on 2024/6/20.
//

import SwiftUI

extension Color {

    /// Convert hex to rgb
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }

    static let primary500 = Color(hex: "#005786")
    static let primary300 = Color(hex: "#4C8CAF")
    static let gray100 = Color(hex: "#F2F2F2")
    static let gray200 = Color(hex: "#DCDCDC")
    static let gray300 = Color(hex: "#B7B7B7")
    static let gray500 = Color(hex: "#878787")
    static let gray600 = Color(hex: "#5A5A5A")
    static let gray800 = Color(hex: "#2E2E2E")
    static let orange100 = Color(hex: "#FDF3D1")
    static let orange500 = Color(hex: "#FA9E14")
    static let red100 = Color(hex: "#FCEDEB")
    static let red500 = Color(hex: "#DD4B39")
    static let green100 = Color(hex: "#BBE5C3")
    static let green300 = Color(hex: "#34C759")
    static let green500 = Color(hex: "#1AAD19")
    static let blue500 = Color(hex: "#007AFF")
    static let blue700 = Color(hex: "#0F5BB3")
    static let mask100 = Color(hex: "#C4C4C4").opacity(0.5)
    static let mask500 = Color(.black).opacity(0.8)
    static let backgroundDark = Color(hex: "#00354E")
}

extension ShapeStyle where Self == Color {
    static var primary500: Color { .primary500 }
    static var primary300: Color { .primary300 }
    static var gray100: Color { .gray100 }
    static var gray200: Color { .gray200 }
    static var gray300: Color { .gray300 }
    static var gray500: Color { .gray500 }
    static var gray600: Color { .gray600 }
    static var gray800: Color { .gray800 }
    static var orange100: Color { .orange100 }
    static var orange500: Color { .orange500 }
    static var red100: Color { .red100 }
    static var red500: Color { .red500 }
    static var green100: Color { .green100 }
    static var green300: Color { .green300 }
    static var green500: Color { .green500 }
    static var blue500: Color { .blue500 }
    static var blue700: Color { .blue700 }
    static var mask100: Color { .mask100 }
    static var mask500: Color { .mask500 }
    static var backgroundDark: Color { .backgroundDark }
}
