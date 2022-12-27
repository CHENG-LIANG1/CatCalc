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

    @State private var favorited = false

    @State private var image = UIImage()
    
    @State private var meatTypes = [String]()
    @State private var didDisappear = false

    private let numberFormatter = NumberFormatter()
    private let dateFormatter = DateFormatter()
    
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
                                    .frame(width: 100, height: 100)

                                
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
                            .frame(height: 100)
             
                            Spacer()
                            
                            Button(action: {
                                favorited.toggle()
      
                        
                            }) {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 24))
                                    .frame(height: 70)
                     
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
                        Text(String(format:"粗蛋白质\n%.2f%%", can.protain))
                            .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 2))
                            .multilineTextAlignment(.center)
                            .tint(.clear)
                        
                        Spacer()
                        
                        ZStack {
                            Text(String(format:"真蛋白质\n%.2f%%", calculateNetValue(value: can.protain)))
                                .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 2))
                                .multilineTextAlignment(.center)
                                .tint(.clear)
                            
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Text("Dick")
                                        .padding()
                                }
                            }
                        }
                        
      
                    }
                    


                }

                VStack {
              
                    HStack {
                        Text(String(format:"粗脂肪\n%.2f%%", can.fat))
                            .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 2))
                            .multilineTextAlignment(.center)
                            .tint(.clear)
                        
                        Spacer()
                        
                        Text(String(format:"真脂肪\n%.2f%%", calculateNetValue(value: can.fat)))
                            .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 2))
                            .multilineTextAlignment(.center)
                            .tint(.clear)
                    }
                    


                }
                
                VStack {
              
                    HStack {
                        Text(String(format:"粗灰分\n%.2f%%", can.ash))
                            .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 2))
                            .multilineTextAlignment(.center)
                            .tint(.clear)
                        
                        Spacer()
                        
                        Text(String(format:"干物质剂\n%.2f%%", calculateNetValue(value: can.ash)))
                            .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 2))
                            .multilineTextAlignment(.center)
                            .tint(.clear)
                    }
                    


                }

                
                VStack {
              
                    HStack {
                        Text(String(format:"钙\n%.2f%%", can.calcium))
                            .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 3))
                            .multilineTextAlignment(.center)
                            .tint(.clear)
                        
                        Spacer()
                        
                        Text(String(format:"总磷\n%.2f%%", can.phosphate))
                            .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 3))
                            .multilineTextAlignment(.center)
                            .tint(.clear)
                        
                        Text(String(format:"钙磷比\n%.2f%%", can.calcium / can.phosphate))
                            .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 3))
                            .multilineTextAlignment(.center)
                            .tint(.clear)
                    }
                    


                }

                
                
                VStack {
              
                    HStack {
                        Text(String(format:"氯化物\n%.2f%%", can.cl))
                            .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 2))
                            .multilineTextAlignment(.center)
                            .tint(.clear)
                        
                        Spacer()
                        
                        Text(String(format:"牛磺酸\n%.2f%%", can.taurine))
                            .modifier(largeCubeModifier(textSize: 20, weight: .bold, color: .cyan, width: (screenWidth - 48) / 2))
                            .multilineTextAlignment(.center)
                            .tint(.clear)
                    }
                    


                }

                
                Text(String(format:"水分\n%.2f%%", can.water))
                    .modifier(rectangleModifier(textSize: 20, weight: .bold, color: .cyan, width: screenWidth - 80, height:  (screenWidth - 48) / 2))
                    .multilineTextAlignment(.center)
                    .tint(.clear)
                    .padding([.bottom], 16)
                
                
            }
            .padding()
            .padding([.top], 40)
            


            
            .onAppear {
                image = UIImage(data: can.pic ?? Data()) ?? UIImage()
                meatTypes = self.can.meatArray.map({ e in
                    e.type ?? ""
                })
                
                favorited = can.favorited == 1
    
            }

            
            
            
        }


        



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
        if can.favorited == 0 {
            moc.performAndWait {
                can.favorited = 1
                try? moc.save()
            }
        }else {
            moc.performAndWait {
                can.favorited = 0
                try? moc.save()
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
