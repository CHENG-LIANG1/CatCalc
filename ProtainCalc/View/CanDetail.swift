//
//  CanDetail.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/12/12.
//

import SwiftUI

struct CanDetail: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    var can: CannedFood
    
    @State private var showingDeleteAlert = false
    
    var body: some View {
        Image(uiImage: UIImage(data: can.pic ?? Data()) ?? UIImage())
        Text(can.brand ?? "")
        
        
            .alert("确认删除？", isPresented: $showingDeleteAlert, actions: {
                
                Button {
                    
                }label: {
                    Text("取消")
                }
                
                Button {
                    deleteCan()
                    dismiss()
                }label: {
                    Text("删除")
                        .foregroundColor(.red)
                        .bold()
                }
                

            })
        
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading:
                               Button(action: goBack) {
                                   HStack {
                                       Image(systemName: "chevron.backward")
                                           .font(.system(size: 16, weight: .bold))
                                           .padding([.leading])
                                           .foregroundColor(.cyan)
                                           .symbolRenderingMode(.none)
                
                                   }
                               }
                           )
            .navigationBarTitle("\(can.brand ?? "")")
            .toolbar {
                Button {
                    showingDeleteAlert = true
                } label: {
                    Text("删除")
                        .foregroundColor(.red)
                }

            }
    }
    
    
    func deleteCan() {
        moc.delete(can)
        try? moc.save()
    }
    
    func goBack(){
        dismiss()
    }
}

//struct CanDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        CanDetail()
//    }
//}
