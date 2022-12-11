//
//  AddCan.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/12/10.
//

import SwiftUI



struct AddCan: View {
    @State private var showImagePicker = false
    @State private var showCountry = false

    @State private var image = UIImage()
    @State private var selectedCountry = "国家"
    
    @Environment(\.dismiss) var dismiss
    
    @State private var brand = ""
    @State private var price = 0.0
    @State private var meat = ""
    @State private var country = ""
    
    var meatTypes = ["鸡肉", "鸭肉", "牛肉", "鹿肉", "兔肉", "其他"]
    
    var contries = ["中国", "德国", "美国", "澳洲", "新西兰", "日本", "韩国", "其他"]
    
    private let numberFormatter: NumberFormatter
    
    @State private var date = Date.now
    
    init() {
      numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .decimal
        numberFormatter.zeroSymbol = ""

    }
    var body: some View {
        ZStack{
            
            VStack(spacing: 16) {
                HStack(spacing: 16){
                    ZStack{
                        Image(uiImage: image)
                            .resizable()
                            .cornerRadius(10)
                            .frame(width: 100, height: 100)
    
                            
                        
                        if  CGSizeEqualToSize(image.size, CGSizeZero) {
                            
                            ZStack {
                                Color.black.opacity(0.1)
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(100, corners: .allCorners)
                                Image(systemName: "photo.on.rectangle")
                                    .modifier(systemImageModifier(font: .system(size: 18), forgroundColor: .pink, backgroundColor: .clear, renderingMode: .hierarchical))
                            }

                        }
                    }
                    .onTapGesture {
                        showImagePicker.toggle()
                    }
                    VStack(spacing: 16){
                        TextField("品牌", text: $brand)
                            .modifier(gradientTextFieldModifier(radius: 10, startColor: .pink.opacity(0.2), endColor: .orange.opacity(0.2), textColor: .black, textSize: 16))
                            .multilineTextAlignment(.center)
                          
                        HStack(spacing: 16) {
                            
                            ZStack{
                                TextField("价格", value: $price, formatter: numberFormatter)
                                    .modifier(gradientTextFieldModifier(radius: 10, startColor: .pink.opacity(0.2), endColor: .orange.opacity(0.2), textColor: .black, textSize: 16))
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad)
                                    .tint(.clear)
                                
                                HStack{
                                    Spacer()
                                    Text("元")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(.gray)
                                        .padding([.trailing, .top], 8)
                                    
                                }
                        
                            }

                            
                            Text(selectedCountry)
                                .font(.system(size: 16, weight: .medium))
                                .padding(EdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24))
                                .background(Helper.gradientBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .onTapGesture {
                                    showCountry = true
                                }
                        }
     
                    }
                

                }
                .padding([.top, .trailing, .leading], 30)


//                HStack {
//                    Picker("\(meat)", selection: $meat) {
//                        ForEach(meatTypes, id:\.self) { m in
//                                Text("\(m)")
//
//                            }
//                        }
//                    .tint(.primary)
//
//
//
//                    Picker("\(country)", selection: $country) {
//                        ForEach(contries, id:\.self) { c in
//                                Text("\(c)")
//
//                            }
//                        }
//                    .tint(.primary)
//
//
//                }
                
                HStack {
                    Text("选择成分")
                        .font(.system(size: 16, weight: .medium))
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        .frame(minWidth: 100)
                        .background(Helper.gradientBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Spacer(minLength: 16)
                    Text("选择过期日期")
                        .font(.system(size: 16, weight: .medium))
                        .padding(EdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24))
                        .frame(maxWidth: .infinity)
                        .background(Helper.gradientBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
       
                }
                .padding([.leading, .trailing], 32)

    
                Spacer()
            }
            
            
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        Helper.viberate(feedbackStyle: .heavy)
                        dismiss()
                    }label: {
                        Text("添加")
                            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                        .background(.cyan)
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .cornerRadius(10, corners: .allCorners)
                    .padding([.bottom, .trailing])
                }
      
            }
        }

        
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
        .sheet(isPresented: $showCountry) {
            if #available(iOS 16.0, *) {
                SelectView(selectionList: contries, selectedItem: $selectedCountry)
                    .presentationDetents([.medium])
            } else {
                // Fallback on earlier versions
            }
        }
    }
    


}

struct AddCan_Previews: PreviewProvider {
    static var previews: some View {
        AddCan()
    }
}
