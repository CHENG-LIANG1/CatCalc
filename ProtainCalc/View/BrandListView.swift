//
//  BrandListView.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/12/11.
//

import SwiftUI

struct Brand: Identifiable {
    let id = UUID()
    let name: String
    var cans: [Brand]?
}



struct BrandListView: View {
    @Environment(\.dismiss) var dismiss
    
    var country: String
    
    @FetchRequest(sortDescriptors: []) var cans: FetchedResults<CannedFood>
        
    
    @State private var filteredCans = [CannedFood]()
//
//    init(){
//        brandList = [brand1, brand2, brand3]
//
//    }
//

    
    var body: some View {
        
        List {
            
            ForEach(filteredCans) { can in
                Text(can.brand!)
                
            }
            
//            ForEach(brandList) { menuItem in
//
//                Section(header:
//                    HStack {
//
//                        Text(menuItem.name)
//                        .font(.headline)
//                            .fontWeight(.heavy)
//
//
//                    }
//                    .padding(.vertical)
//
//                ) {
//                    OutlineGroup(menuItem.cans ?? [Brand](), children: \.cans) {  item in
//                        NavigationLink {
//                            CanDetail()
//                        }label: {
//                            Text(item.name)
//                            .padding(EdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4))
//                        }
//
//                    }
//
//                }
//            }
        }
        .padding([.top], 38)

        .listStyle(.insetGrouped)
        .onAppear{

        }
        .tint(.cyan)

    
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
        .navigationBarTitle("美国罐头")
        .onAppear {
            filteredCans = cans.filter { $0.country == country}
        }
        

 

        
    }
    
    func goBack(){
        dismiss()
    }
}

//struct BrandListView_Previews: PreviewProvider {
//    static var previews: some View {
//        BrandListView()
//    }
//}
