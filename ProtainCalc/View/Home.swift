//
//  Home.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/11/22.
//

import SwiftUI

struct Home: View {
    var screenWidth = UIScreen().bounds.size.width
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                VStack{
                    Spacer()
                    Button{
                        
                    }label: {
                        
                        ZStack {
                            Color.ButtonColor
                            Image(systemName: "plus")
                                .font(.system(size: 30, weight: .semibold))
                                .tint(Color.white)
                        }
                        .frame(width: 44, height: 44)
                        .clipShape(Circle())
                        
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 24))
                }
            }
            

        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
