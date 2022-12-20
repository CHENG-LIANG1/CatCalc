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
    
    let brand1 = Brand(name: "滋奇", cans: [Brand(name: "Can 1"), Brand(name: "Can 2"), Brand(name: "Can 3")])
    let brand2 = Brand(name: "滋奇", cans: [Brand(name: "Can 1"), Brand(name: "Can 2"), Brand(name: "Can 3")])
    let brand3 = Brand(name: "滋奇", cans: [Brand(name: "Can 1"), Brand(name: "Can 2"), Brand(name: "Can 3")])
    let brandList: [Brand]
    
    init(){
        brandList = [brand1, brand2, brand3]
    }
    

    
    var body: some View {
        
        List {
            ForEach(brandList) { menuItem in

                Section(header:
                    HStack {

                        Text(menuItem.name)
                        .font(.headline)
                            .fontWeight(.heavy)


                    }
                    .padding(.vertical)

                ) {
                    OutlineGroup(menuItem.cans ?? [Brand](), children: \.cans) {  item in
                        NavigationLink {
                            CanDetail()
                        }label: {
                            Text(item.name)
                            .padding(EdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4))
                        }
                   
                    }

                }
            }
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

 

        
    }
    
    func goBack(){
        dismiss()
    }
}

struct BrandListView_Previews: PreviewProvider {
    static var previews: some View {
        BrandListView()
    }
}
