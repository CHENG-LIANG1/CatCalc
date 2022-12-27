//
//  SelectView.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/12/11.
//

import SwiftUI

struct EditNumberValue: View {
    var title: String

    @Binding var value: Float

    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            VStack {
                TextField(title, value: $value, formatter: Helper.getNumberFormatter())
                    .modifier(gradientTextFieldModifier(radius: 10, startColor: .pink.opacity(0.2), endColor: .orange.opacity(0.2), textColor: .TextColorPrimary, textSize: 16))
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
                
                Spacer()
            }.padding()
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        
              
                        Helper.viberate(feedbackStyle: .heavy)
                
                        dismiss()
             

                    }label: {
                        Text("完成")
                            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                        .background(.cyan)
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .cornerRadius(10, corners: .allCorners)
                    .padding([.bottom, .trailing])
                }
      
            }
        }
        




    }
}

