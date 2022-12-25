//
//  customTextField.swift
//  SystemCapsule
//
//  Created by Cheng Liang(Louis) on 2022/9/17.
//

import Foundation
import SwiftUI


struct listViewCellModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowSeparator(.hidden)
            .listRowBackground(
                RoundedRectangle(cornerRadius: 50)
                    .background(.clear)
                    .foregroundColor(Color.BackgroundColor)
                    .padding(EdgeInsets(top: 8 , leading: 0, bottom: 8, trailing: 0))

            )
    }
}

struct brandCellModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowSeparator(.hidden)
            .listRowBackground(
                RoundedRectangle(cornerRadius: 8)
                    .background(.clear)
                    .foregroundColor(Color.BackgroundColor)
                    .padding(EdgeInsets(top: 8 , leading: 0, bottom: 8, trailing: 0))

            )
    }
}

struct gradientTextFieldModifier: ViewModifier {
    var radius: CGFloat
    var startColor: Color
    var endColor: Color
    var textColor: Color
    var textSize: CGFloat

    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(radius)
            .foregroundColor(textColor)
            .font(.system(size: textSize, weight: .semibold, design: .rounded))
            .tint(.TextColorPrimary)
//            .accentColor(textColor)
    }
}

struct singleColoredTextFieldModifier: ViewModifier {
    var radius: CGFloat
    var bgColor: Color
    var textColor: Color
    var textSize: CGFloat

    func body(content: Content) -> some View {
        content
            .padding()
            .background(bgColor)
            .cornerRadius(radius)
            .foregroundColor(textColor)
            .font(.system(size: textSize, weight: .semibold, design: .rounded))
            .accentColor(textColor)
    }
}


public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String
    var forgroundColor: Color

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .foregroundColor(Color.gray)
                .padding(.horizontal, 10)
            }
            content
            .foregroundColor(forgroundColor)
            .padding(5.0)
        }
    }
}
