//
//  ColorExt.swift
//  SystemCapsule
//
//  Created by Cheng Liang(Louis) on 2022/9/14.
//


import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

extension Color {
    static var theme: Color  {
        return Color("theme")
    }
    static var BackgroundColor: Color  {
        return Color("BackgroundColor")
    }

    static var ColorPrimary: Color  {
        return Color("ColorPrimary")
    }

    static var Accent: Color  {
        return Color("AccentColor")
    }

    static var TextColorPrimary: Color  {
        return Color("TextColorPrimary")
    }

    static var TextColorSecondary: Color  {
        return Color("TextColorSecondary")
    }
        
    static var ButtonColor: Color {
        return Color(hex: 0x1DB854)
    }
}
