//
//  BrandListView.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/12/11.
//

import SwiftUI


struct FavListView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var cans: FetchedResults<CannedFood>
        
    
    @State private var brands = [String]()
    @State private var showDeleteAlert = false

    @State private var sortedCans = [CannedFood]()
    
    @State private var sortRule = ""
    
    @State private var favedCans = [CannedFood]()
    
    var body: some View {
        
        VStack {
            if favedCans.isEmpty {
                Text("暂无罐头")
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
                    .navigationBarTitle("我的收藏")
            } else {
                List {

                    
                    
                    Section(sortRule) {
            
                        ForEach(sortedCans) { can in
                            NavigationLink {

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
                .navigationBarTitle("我的收藏")
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
        }

      


            
            
        }
   
        .onAppear {
            sortRule = "价格升序"
            brands = []
            
            
            favedCans = []
            for can in cans {
                if can.favorited == 1 {
                    favedCans.append(can)
                }
                
             
            }
            
            for can in favedCans {
                brands.append(can.brand ?? "none")
            }
            
            brands = Array(Set(brands))
            
            sortedCans = favedCans.sorted {
                $0.price < $1.price
            }
        }


 

        
    }
    

    func sortByPriceDSC() {
        sortedCans = sortedCans.sorted {
            $0.price > $1.price
        }
        
        sortRule = "价格降序"
        
    }
    
    
    func sortByPriceASC(){
        sortedCans = sortedCans.sorted {
            $0.price < $1.price
        }
        
        
        sortRule = "价格升序"
    }
    
    func sortByProtain() {
        sortedCans = sortedCans.sorted {
            $0.protain > $1.protain
        }
        
        
        sortRule = "蛋白质含量"
    }
    
    func sortByFat() {
        sortedCans = sortedCans.sorted {
            $0.fat > $1.fat
        }
        
        
        sortRule = "脂肪含量"
    }
    
    func sortByWater() {
        sortedCans = sortedCans.sorted {
            $0.water > $1.water
        }
        
        
        sortRule = "水分含量"
    }
    
    func goBack(){
        dismiss()
    }
}

