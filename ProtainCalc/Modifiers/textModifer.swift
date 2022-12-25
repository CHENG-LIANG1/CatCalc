//
//  textModifer.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/12/25.
//

import SwiftUI

struct defaultTextModifier: ViewModifier {
    var textSize: CGFloat
    var weight: Font.Weight
    
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: textSize, weight: weight, design: .rounded))
            
    }
}


struct secondaryTextModifier: ViewModifier {
    var textSize: CGFloat
    var weight: Font.Weight
    
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: textSize, weight: weight, design: .rounded))
            .foregroundColor(.gray.opacity(0.6))
            
    }
}

