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
    @State private var showMeat = false
    @State private var showDatePicker = false

    @State private var image = UIImage()
    @State private var selectedCountry = ["国家"]
    @State private var selectedMeat = [String]()
    @State private var selectedDate = Date.now
    
    @Environment(\.dismiss) var dismiss
    
    @State private var brand = ""
    @State private var price = 0.0
    @State private var meat = ""
    @State private var country = ""
    
    var meatTypes = ["鸡肉", "鸭肉", "牛肉", "鹿肉", "兔肉", "三文鱼", "其他"]
    
    var contries = ["中国", "德国", "美国", "澳洲", "新西兰", "日本", "韩国", "其他"]
    
    private let numberFormatter: NumberFormatter
    private let dateFormatter: DateFormatter
    
    @State private var date = Date.now
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var cans: FetchedResults<CannedFood>
    
    
    init() {
        numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .decimal
        numberFormatter.zeroSymbol = ""
        
        dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "过期日: yyyy年 MM月 dd日"
        
        

    }
    
    
    func addCan(){
        let canned = CannedFood(context: moc)
        canned.brand = brand
        canned.price = Float(price)
        canned.country = country
        
        canned.pic = image.pngData()
        
        for meatName in selectedMeat {
            let meat = Meat(context: moc)
            meat.type = meatName
            meat.origin = canned
        }
        
        try? moc.save()
                                
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

                            HStack {
                                Text(selectedCountry[0])
                                Image(systemName: "chevron.compact.right")
                                    .font(.system(size: 14, weight: .bold))
                            }
                  
                                .font(.system(size: 16, weight: .medium))
                                .padding(EdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24))
                                .background(Helper.gradientBackground2)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .onTapGesture {
                                    Helper.viberate(feedbackStyle: .heavy)
                                    showCountry = true
                                }
                        }
     
                    }
                

                }
                .padding([.top, .trailing, .leading], 30)
                

                
                HStack {
                    Text(selectedMeat.isEmpty ? "选择肉" : selectedMeat[0])
                    Image(systemName: "chevron.compact.right")
                        .font(.system(size: 16, weight: .bold))
                    
                }

                    .font(.system(size: 16, weight: .medium))
                    .padding(EdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 8))
                    .frame(maxWidth: .infinity)
                    .background(Helper.gradientBackground2)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        Helper.viberate(feedbackStyle: .heavy)
                        showMeat = true
                    }
                    .padding([ .trailing, .leading], 30)
                
                HStack {
                    Text(dateFormatter.string(from: selectedDate))
                    Image(systemName: "chevron.compact.right")
                        .font(.system(size: 14, weight: .bold))
                    
                }
                
                    .font(.system(size: 16, weight: .medium))
                    .padding(EdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 8))
                    .frame(maxWidth: .infinity)
                    .background(Helper.gradientBackground2)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        Helper.viberate(feedbackStyle: .heavy)
                        showDatePicker = true
                    }
                    .padding([ .trailing, .leading], 30)

//                HStack {
//                    Text(selectedMeat[0])
//                    Image(systemName: "chevron.compact.right")
//                        .font(.system(size: 14, weight: .bold))
//                }
//
//                    .font(.system(size: 14, weight: .medium))
//                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
//                    .frame(minWidth: 100)
//                    .background(Helper.gradientBackground2)
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//
//
//                    .onTapGesture {
//                        Helper.viberate(feedbackStyle: .heavy)
//                        showMeat = true
//                    }
//
                Spacer()
            }
            
            
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        Helper.viberate(feedbackStyle: .heavy)
                        addCan()
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
                SelectView(selectionList: contries, selectedItems: $selectedCountry)
                    .presentationDetents([.medium])
            } else {
                // Fallback on earlier versions
            }
        }
        .sheet(isPresented: $showMeat) {
            if #available(iOS 16.0, *) {
                SelectView(selectionList: meatTypes, selectedItems: $selectedMeat)
                    .presentationDetents([.medium])
            } else {
                // Fallback on earlier versions
            }
        }
        .sheet(isPresented: $showDatePicker) {
            if #available(iOS 16.0, *) {
                SelectDate(date: $selectedDate)
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
