//
//  SelectView.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/12/11.
//

import SwiftUI

struct SelectCountry: View {
    var selectionList: [String]
    @Environment(\.dismiss) var dismiss
    @Binding var selectedItem: String
    var body: some View {
        
        ZStack {

            
            List {
                ForEach(selectionList, id:\.self) { item in
                    CountryCell(selection: item, selected: $selectedItem)
                        .onTapGesture {
                            selectedItem = item
                            Helper.viberate(feedbackStyle: .heavy)
                            dismiss()
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 50)
                                .background(.clear)
                                .foregroundColor(Color.clear)
                        )
                    
                }
            }

            
        }
        

    }
}

struct CountryCell: View {
    let selection: String
    @Binding var selected: String
    
    var body: some View {
        HStack {
            Text(selection)
                .frame(maxWidth: .infinity)
                .font(.system(size: 15, weight: .semibold, design: .rounded))

            
            if selected.contains(selection) {
                Image(systemName: "checkmark.circle.fill")
                    .modifier(systemImageModifier(font: .system(size: 20, weight:.black), forgroundColor: .cyan, backgroundColor: .clear, renderingMode: .hierarchical))
            }else {
                Image(systemName: "circle.fill")
                    .modifier(systemImageModifier(font: .system(size: 20, weight:.black), forgroundColor: .gray.opacity(0.2), backgroundColor: .clear, renderingMode: .multicolor))
            }
        }
        .padding()
        .background(Helper.gradientBackground2)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
