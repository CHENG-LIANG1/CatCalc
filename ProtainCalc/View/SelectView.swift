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
    @Binding var selectedItems: [String]
    var body: some View {
        
        ZStack {

            
            List {
                ForEach(selectionList, id:\.self) { item in
                    SelectionCell(selection: item, selected: $selectedItems)
                        .onTapGesture {
                            if selectedItems.contains(item) {
                                selectedItems.remove(at: selectedItems.firstIndex(of: item)!)
                            } else {
                                selectedItems.append(item)
                            }
                            
                        
                            Helper.viberate(feedbackStyle: .heavy)
    //                        dismiss()
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 50)
                                .background(.clear)
                                .foregroundColor(Color.clear)
                        )
                    
                }
            }

            
//            VStack {
//                HStack {
//                    
//                    Spacer()
//                    
//                    Button{
//                        Helper.viberate(feedbackStyle: .heavy)
//
//                        dismiss()
//                    }label: {
//                        Text("添加")
//                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
//                        .background(.cyan)
//                    }
//                    .foregroundColor(.white)
//                    .font(.system(size: 12, weight: .semibold, design: .rounded))
//                    .cornerRadius(5, corners: .allCorners)
//
//                }
//                .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 8 ))
//                Spacer()
//            }
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
    @Binding var selected: [String]
    
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
