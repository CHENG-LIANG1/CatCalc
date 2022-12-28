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

    @State private var sortRule = ""
    var body: some View {
        
        List {
            
            
            Section(sortRule){
                ForEach(filteredCans) { can in
                    NavigationLink {
//                                Brandlist
//                            BrandListView(country: country)
                    
                        CanDetail(can: can)
                        
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
                            
                            Text(String(format:"%.1f 元", can.price))
                                .modifier(capsuleTextModifier(textSize: 12, weight: .bold, color: .cyan))
                            
                            
                        }

                        .padding(EdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4))
                    }
                    .modifier(brandCellModifier())
                }
            }
            
        }
        .padding([.top], 38)

        .listStyle(.insetGrouped)
        .onAppear{

        }
        .tint(.cyan)
        .toolbar(content: {
            Menu("排序") {
                Button("价格降序", action: sortByPriceDSC)
                Button("价格升序", action: sortByPriceASC)
                Button("蛋白质含量", action: sortByProtain)
                Button("脂肪含量", action: sortByFat)
                Button("水分含量", action: sortByWater)
            }
            .foregroundColor(.cyan)
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
        .navigationBarTitle("\(country)罐头")
        .onAppear {
            brands = []
            filteredCans = cans.filter { $0.country == country}
            
            for can in filteredCans {
                brands.append(can.brand ?? "none")
            }
            brands = Array(Set(brands))
        }
        

 

        
    }
    
    func sortByPriceDSC() {
        filteredCans = filteredCans.sorted {
            $0.price > $1.price
        }
        
        sortRule = "价格降序"
        
    }
    
    
    func sortByPriceASC(){
        filteredCans = filteredCans.sorted {
            $0.price < $1.price
        }
        
        
        sortRule = "价格升序"
    }
    
    func sortByProtain() {
        filteredCans = filteredCans.sorted {
            $0.protain > $1.protain
        }
        
        
        sortRule = "蛋白质含量"
    }
    
    func sortByFat() {
        filteredCans = filteredCans.sorted {
            $0.fat > $1.fat
        }
        
        
        sortRule = "脂肪含量"
    }
    
    func sortByWater() {
        filteredCans = filteredCans.sorted {
            $0.water > $1.water
        }
        
        
        sortRule = "水分含量"
    }
    
    func goBack(){
        dismiss()
    }
}

