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
    @Environment(\.managedObjectContext) var moc
    var country: String
    
    @FetchRequest(sortDescriptors: []) var cans: FetchedResults<CannedFood>
        
    
    @State private var filteredCans = [CannedFood]()
    @State private var brands = [String]()
    @State private var showDeleteAlert = false
//
//    init(){
//        brandList = [brand1, brand2, brand3]
//
//    }
//

    
    func deleteCan(at offsets: IndexSet) {
        for offset in offsets {
            let can = filteredCans[offset]
            moc.delete(can)
        }
        try? moc.save()
        filteredCans = cans.filter { $0.country == country}
        brands = []
        for can in filteredCans {
            brands.append(can.brand ?? "none")
        }
        brands = Array(Set(brands))

    }
    
    var body: some View {
        
        List {
            
            ForEach(brands, id:\.self) { brand in
                
                Section(brand){
                    ForEach(filteredCans.filter {$0.brand == brand}) { can in
                        NavigationLink {
//                                Brandlist
//                            BrandListView(country: country)
                        }label: {
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 8){
                                    Text(can.brand ?? "")
                                        .modifier(defaultTextModifier(textSize: 18, weight: .semibold))
                                    
                                    Text(can.meatArray.map({ e in
                                        e.type ?? ""
                                    }).joined(separator: ", ") )
                                    .modifier(secondaryTextModifier(textSize: 12, weight: .medium))
                                    
                                }
                                
                                Spacer()
                                
                                Text(String(format:"%.2f g", can.weight))
                                    .modifier(defaultTextModifier(textSize: 16, weight: .semibold))
                                
                                
                            }

                            .padding(EdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4))
                        }
                        .modifier(brandCellModifier())
                    }
                }
                
                
            }
            
//            .onDelete(perform: deleteCan(at:))
            
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
        .navigationBarTitle("\(country)罐头")
        .onAppear {
            filteredCans = cans.filter { $0.country == country}
            
            for can in filteredCans {
                brands.append(can.brand ?? "none")
            }
            brands = Array(Set(brands))
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
