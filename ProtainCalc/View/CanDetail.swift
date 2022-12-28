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
    @State private var showingEditProtainSheet = false
    @State private var showingEditFatSheet = false
    @State private var showingEditAshSheet = false
    @State private var showingEditPhosphateSheet = false
    @State private var showingEditCalciumSheet = false
    @State private var showingEditClSheet = false
    @State private var showingEditTaurineSheet = false
    @State private var showingEditWaterSheet = false


    @State private var favorited = false

    @State private var image = UIImage()
    
    @State private var meatTypes = [String]()
    @State private var didDisappear = false

        
    @State private var protain: Float = 0.0
    @State private var fat: Float = 0.0
    @State private var ash: Float = 0.0
    @State private var calcium: Float = 0.0
    @State private var phosphate: Float = 0.0
    @State private var cl: Float = 0.0
    @State private var taurine: Float = 0.0
    @State private var water: Float = 0.0

    
    @Environment(\.scenePhase) var scenePhase

    
    var screenWidth = UIScreen.main.bounds.width
    
    private func generateContent() -> some View {

        return Spacer()
    }
    
    func calculateNetValue(value: Float) -> Float {
        return value / (100 - can.water) * 100
    }


    
    var body: some View {
        
        ScrollView {
            
            LazyVStack(spacing: 16) {
                
                HStack(alignment:.top) {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(alignment: .top, spacing: 16){
                            ZStack{
                                Image(uiImage: image)
                                    .resizable()
                                    .cornerRadius(10)
                                    .frame(width: 110, height: 110)

                                
                                if  CGSizeEqualToSize(image.size, CGSizeZero) {
                                    
                                    ZStack {
                                        Color.black.opacity(0.1)
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(10, corners: .allCorners)
                                        Image(systemName: "photo.on.rectangle")
                                            .modifier(systemImageModifier(font: .system(size: 18), forgroundColor: .pink, backgroundColor: .clear, renderingMode: .hierarchical))
                                    }

                                }
                            }
           
                            VStack(alignment: .leading)  {
                                
                                Text("\(can.brand ?? "")")
                                    .modifier(capsuleTextModifier(textSize: 12, weight: .semibold, color: .yellow))

                                
                                Text(String(format:"%.1f 元", can.price))
                                    .modifier(capsuleTextModifier(textSize: 12, weight: .semibold, color: .yellow))

                                
                                Text(String(format:"%.1f 克", can.weight))
                                    .modifier(capsuleTextModifier(textSize: 12, weight: .semibold, color: .yellow))
                                


                            
                            }
                            .frame(height: 110)
             
                         
                            
                            Button(action: {
                                Helper.viberate(feedbackStyle: .heavy)
                                favorited.toggle()

                        
                            }) {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 24))
                                    .frame(height: 72)
                     
                            }
                            .padding([.leading])
                            .buttonStyle(GradientButtonStyle(favorited: favorited))

                        }
                        

                        HStack {
                            Text(can.date!, style: .date)
                                .modifier(capsuleTextModifier(textSize: 12, weight: .semibold, color: .yellow))
        
                            Text("产地：\(can.country!)")
                                .modifier(capsuleTextModifier(textSize: 12, weight: .semibold, color: .yellow))
                        }
                        
                        HStack {
                            HStack {
                                ForEach(meatTypes, id:\.self) { meat in
                                    Text(meat)
                                        .modifier(capsuleTextModifier(textSize: 12, weight: .semibold, color: .cyan))
                                    
                                }
                            }
                            
                            Spacer()
                        }
                        

                        


                    }

    
         
                }
               
                .padding()
                .background(.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                
                VStack {
              
                    HStack {
                  
                        ZStack {
                            Text(String(format:"粗蛋白质\n%.2f%%", protain))
                                .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 2))
                                .multilineTextAlignment(.center)
                                .tint(.clear)
                            
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Image(systemName: "square.and.pencil")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding()
                       
                                }
                            }
                        }
                        .onTapGesture {
                            showingEditProtainSheet.toggle()
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text(String(format:"真蛋白质\n%.2f%%", calculateNetValue(value: calculateNetValue(value: protain))))
                            Text(String(format: "%.2f g", calculateNetValue(value: protain) * can.weight))
                        }
                      
                            .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 2))
                            .multilineTextAlignment(.center)
                            .tint(.clear)
                        

                        
      
                    }
                    


                }

                VStack {
              
                    HStack {
                        ZStack {
                            Text(String(format:"粗脂肪\n%.2f%%", fat))
                                .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 2))
                                .multilineTextAlignment(.center)
                                .tint(.clear)
                            
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Image(systemName: "square.and.pencil")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding()
                       
                                }
                            }
                        }
                        .onTapGesture {
                            showingEditFatSheet.toggle()
                        }
                        
                        
                        
                        
                        

                        
                        Spacer()
                        
                        
                        
                        VStack {
                            Text(String(format:"真脂肪\n%.2f%%", calculateNetValue(value: fat)))
                            Text(String(format: "%.2f g", calculateNetValue(value: fat) * can.weight))
                        }
                      
       
                            .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 2))
                            .multilineTextAlignment(.center)
                            .tint(.clear)
                    }
                    


                }
                
                VStack {
              
                    HStack {
                        
                        
                        ZStack {
                            Text(String(format:"粗灰分\n%.2f%%", ash))
                                .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 2))
                                .multilineTextAlignment(.center)
                                .tint(.clear)
                            
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Image(systemName: "square.and.pencil")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding()
                       
                                }
                            }
                        }
                        .onTapGesture {
                            showingEditAshSheet.toggle()
                        }
                        
                        

                        
                        Spacer()
                        
                        Text(String(format:"干物质剂\n%.2f%%", calculateNetValue(value: ash)))
                            .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 2))
                            .multilineTextAlignment(.center)
                            .tint(.clear)
                    }
                    


                }

                
                VStack {
              
                    HStack {
                        
                        
                        ZStack {
                            Text(String(format:"钙\n%.2f%%", calcium))
                                .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 3))
                                .multilineTextAlignment(.center)
                                .tint(.clear)
                            
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Image(systemName: "square.and.pencil")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding(8)
                       
                                }
                            }
                        }
                        .onTapGesture {
                            showingEditCalciumSheet.toggle()
                        }
                        
                        
 
                        
                        Spacer()
                        
                        
                        ZStack {
                            Text(String(format:"总磷\n%.2f%%", phosphate))
                                .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 3))
                                .multilineTextAlignment(.center)
                                .tint(.clear)
                            
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Image(systemName: "square.and.pencil")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding(8)
                       
                                }
                            }
                        }
                        .onTapGesture {
                            showingEditPhosphateSheet.toggle()
                        }
                        
                        
                        
                        Text(String(format:"钙磷比\n%.2f%%", calcium / phosphate))
                            .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 3))
                            .multilineTextAlignment(.center)
                            .tint(.clear)
                    }
                    


                }

                
                
                VStack {
              
                    HStack {
                        ZStack {
                            Text(String(format:"氯化物\n%.2f%%", cl))
                                .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 2))
                                .multilineTextAlignment(.center)
                                .tint(.clear)
                            
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Image(systemName: "square.and.pencil")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding()
                       
                                }
                            }
                        }
                        .onTapGesture {
                            showingEditClSheet.toggle()
                        }
                        
                        
                        
                        
                        Spacer()
                        
                        Text(String(format:"牛磺酸\n%.2f%%", taurine))
                            .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 2))
                            .multilineTextAlignment(.center)
                            .tint(.clear)
                    }
                    


                }

                
                ZStack {
                    Text(String(format:"水分\n%.2f%%", water))
                        .modifier(rectangleModifier(textSize: 20, weight: .bold, color: .cyan, width: screenWidth - 32, height:  (screenWidth - 48) / 2))
                        .multilineTextAlignment(.center)
                        .tint(.clear)
           
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(24)
               
                        }
                    }
                }
                .padding([.bottom], 16)
                .onTapGesture {
                    showingEditWaterSheet.toggle()
                }
                
                
                
                
                
                
            }
            .padding()
            .padding([.top], 40)
            


            
            .onAppear {
                image = UIImage(data: can.pic ?? Data()) ?? UIImage()
                meatTypes = self.can.meatArray.map({ e in
                    e.type ?? ""
                })
                
                favorited = can.favorited == 1
                
                protain = can.protain
                fat = can.fat
                calcium = can.calcium
                cl = can.cl
                phosphate = can.phosphate
                water = can.water
                ash = can.ash
                taurine = can.taurine
                
    
            }

            
            
            
        }
        .sheet(isPresented: $showingEditProtainSheet, content: {
            
            
            if #available(iOS 16.0, *) {
                
                EditNumberValue(title: "输入粗蛋白质", value: $protain)
                    .interactiveDismissDisabled(false)
                    .presentationDetents([.medium])
                
            } else {
                // Fallback on earlier versions
            }
        })
        
        .sheet(isPresented: $showingEditFatSheet, content: {
            
            
            if #available(iOS 16.0, *) {
                
                EditNumberValue(title: "输入粗脂肪", value: $fat)
                    .interactiveDismissDisabled(false)
                    .presentationDetents([.medium])
                
            } else {
                // Fallback on earlier versions
            }
        })
        .sheet(isPresented: $showingEditAshSheet, content: {
            
            
            if #available(iOS 16.0, *) {
                
                EditNumberValue(title: "输入粗灰质", value: $ash)
                    .interactiveDismissDisabled(false)
                    .presentationDetents([.medium])
                
            } else {
                // Fallback on earlier versions
            }
        })
        
        .sheet(isPresented: $showingEditCalciumSheet, content: {
            
            
            if #available(iOS 16.0, *) {
                
                EditNumberValue(title: "输入钙", value: $calcium)
                    .interactiveDismissDisabled(false)
                    .presentationDetents([.medium])
                
            } else {
                // Fallback on earlier versions
            }
        })
        
        .sheet(isPresented: $showingEditPhosphateSheet, content: {
            
            
            if #available(iOS 16.0, *) {
                
                EditNumberValue(title: "输入总磷", value: $phosphate)
                    .interactiveDismissDisabled(false)
                    .presentationDetents([.medium])
                
            } else {
                // Fallback on earlier versions
            }
        })
        
        .sheet(isPresented: $showingEditClSheet, content: {

            
            if #available(iOS 16.0, *) {
                
                EditNumberValue(title: "输入氯化物", value: $cl)
                    .interactiveDismissDisabled(false)
                    .presentationDetents([.medium])
                
            } else {
                // Fallback on earlier versions
            }
        })
        
        .sheet(isPresented: $showingEditTaurineSheet, content: {
            
            
            if #available(iOS 16.0, *) {
                
                EditNumberValue(title: "输入牛磺酸", value: $taurine)
                    .interactiveDismissDisabled(false)
                    .presentationDetents([.medium])
                
            } else {
                // Fallback on earlier versions
            }
        })
        .sheet(isPresented: $showingEditWaterSheet, content: {
            
            
            if #available(iOS 16.0, *) {
                
                EditNumberValue(title: "输入水分", value: $water)
                    .interactiveDismissDisabled(false)
                    .presentationDetents([.medium])
                
            } else {
                // Fallback on earlier versions
            }
        })
        



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
        
            .onDisappear {
                saveValues()
            }
            .onChange(of: scenePhase) { newPhase in
                 if newPhase == .active {
                     print("Active")
                 } else if newPhase == .inactive {
                     
                     print("Inactive")
                 } else if newPhase == .background {
                     saveValues()
                 }
             }
        
        
        
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
                Menu("操作") {
                    Button("删除", action: delete)
                        .foregroundColor(.red)
//                    Button("收藏", action: favorite)
                }
                .foregroundColor(.cyan)
                
                

            }
    }
    
    
    
    
    
    func delete(){
        showingDeleteAlert = true
    }
    
    func favorite(){
        
        moc.performAndWait {
            can.favorited = 1
            try? moc.save()
        }

    }
    
    func unfavorite(){
        moc.performAndWait {
            can.favorited = 0
            try? moc.save()
        }
    }
    
    func saveValues() {
        if favorited {
            unfavorite()
        }else  {
            favorite()
        }
        
        
        can.protain = protain
        can.fat = fat
        can.calcium = calcium
        can.phosphate = phosphate
        can.water = water
        can.cl = cl
        can.ash = ash
        can.taurine = taurine

        
        try? moc.save()
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
