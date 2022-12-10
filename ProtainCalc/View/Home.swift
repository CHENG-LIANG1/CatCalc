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
            
            
            List{
                ForEach(0...30, id: \.self) {e in
                    
                    Text("滋奇 \(e)")
                        .listRowSeparator(.hidden)
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 10)
                                .background(.clear)
                                .foregroundColor(Color.BackgroundColor)
                                .padding(EdgeInsets(top: 8 , leading: 0, bottom: 8, trailing: 0))
                                
                        )
                        .padding()
                        .swipeActions {
                            Button(role: .destructive) {
                                
                            } label: {
                                Label("Delete", systemImage: "minus.circle")
                                    .padding(EdgeInsets(top: 8 , leading: 0, bottom: 8, trailing: 0))
                            }
                        
              

                        }
                    
                        .swipeActions(edge:.leading) {
                            Button {
                                
                            } label: {
                                Image(systemName: "pin")
                                    .foregroundColor(.orange)
                            }
                            .tint(.clear)
                            .clipShape(Circle())
         
                            
  
                        }
               
                    
                }
                .listStyle(.plain)
            }
            
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
