//
//  SelectView.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/12/11.
//

import SwiftUI

struct SelectView: View {
    var selectionList: [String]
    @Environment(\.dismiss) var dismiss
    @Binding var selectedItem: String
    var body: some View {
        List {
            ForEach(selectionList, id:\.self) { item in
                SelectionCell(selection: item, selected: $selectedItem)
                    .onTapGesture {
                        selectedItem = item
                        Helper.viberate(feedbackStyle: .heavy)
                        dismiss()
                    }
                    .listRowSeparator(.hidden)
                
            }
        }
    }
}

//struct SelectView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectView(selectionList: ["中国", "德国"], selectedItem: "中国")
//    }
//}

struct SelectionCell: View {
    let selection: String
    @Binding var selected: String
    
    var body: some View {
        HStack {
            Text(selection)
            Spacer()
            
            if selection == selected {
                Image(systemName: "checkmark.circle.fill")
                    .modifier(systemImageModifier(font: .system(size: 20, weight:.black), forgroundColor: .cyan, backgroundColor: .clear, renderingMode: .hierarchical))
            }else {
                Image(systemName: "circle.fill")
                    .modifier(systemImageModifier(font: .system(size: 20), forgroundColor: .gray.opacity(0.2), backgroundColor: .clear, renderingMode: .multicolor))
            }
        }
    }
}
