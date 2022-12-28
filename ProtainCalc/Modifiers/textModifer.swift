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
            .foregroundColor(Color.TextColorPrimary)
            
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

struct whiteTextModifier: ViewModifier {
    var textSize: CGFloat
    var weight: Font.Weight
    
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: textSize, weight: weight, design: .rounded))
            .foregroundColor(.white)
            
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

struct largeCubeModifier: ViewModifier {
    var textSize: CGFloat
    var weight: Font.Weight
    var color: Color
    var width: CGFloat
    
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: textSize, weight: weight, design: .monospaced))
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .frame(width: width, height: width)
            .foregroundColor(.white)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.5), Color.blue.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
    }
}


struct rectangleModifier: ViewModifier {
    var textSize: CGFloat
    var weight: Font.Weight
    var color: Color
    var width: CGFloat
    var height: CGFloat
    
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: textSize, weight: weight, design: .monospaced))
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .frame(width: width, height: height)
            .foregroundColor(.white)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.5), Color.blue.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
    }
}
