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



struct capsuleTextModifier: ViewModifier {
    var textSize: CGFloat
    var weight: Font.Weight
    var color: Color
    
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: textSize, weight: weight, design: .monospaced))
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .foregroundColor(.white)
            .background(color)
            .clipShape(Capsule())
            
    }
}
