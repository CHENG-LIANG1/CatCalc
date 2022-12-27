//
//  Helper.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/12/10.
//

import SwiftUI
import CoreHaptics

struct Helper {
    
    static var gradientBackground: LinearGradient = LinearGradient(gradient: Gradient(colors: [.pink.opacity(0.2), .orange.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    static var gradientBackground2: LinearGradient = LinearGradient(gradient: Gradient(colors: [.orange.opacity(0.2), .cyan.opacity(0.2) ]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    static func viberate(feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
    }
    
    static func getNumberFormatter() -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .decimal
        numberFormatter.zeroSymbol = ""
        
        return numberFormatter
    }

}
