//
//  SelectView.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/12/11.
//

import SwiftUI

struct EditStringValue: View {
    var title: String

    @Binding var value: String

    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            VStack {
                TextField(title, text:$value)
                    .frame(height: 48)
                    .modifier(gradientTextFieldModifier(radius: 10, startColor: .pink.opacity(0.2), endColor: .orange.opacity(0.2), textColor: .TextColorPrimary, textSize: 24))
           
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
                
                Spacer()
            }
            .padding([.top, .leading, .trailing], 24)
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        
              
                        Helper.viberate(feedbackStyle: .heavy)
                
                        print(value)
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

