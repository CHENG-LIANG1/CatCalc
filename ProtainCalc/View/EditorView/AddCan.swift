//
//  AddCan.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/12/10.
//

import SwiftUI
import AlertToast



struct AddCan: View {
    @State private var showImagePicker = false
    @State private var showCountry = false
    @State private var showMeat = false
    @State private var showDatePicker = false
    @State private var showAlert = false

    @State private var image = UIImage()
    @State private var selectedCountry = "国家"
    @State private var selectedMeat = [String]()
    @State private var selectedDate = Date.now
    
    @Environment(\.dismiss) var dismiss
    
    @State private var brand = ""
    @State private var price = 0.0
    @State private var weight = 0.0
    @State private var meat = ""
    @State private var country = ""
    
    @State private var fat: Float = 0.0
    @State private var protain: Float = 0.0
    @State private var ash: Float = 0.0
    @State private var fiber: Float = 0.0
    @State private var calcium: Float = 0.0
    @State private var phosphate: Float = 0.0
    @State private var taurine: Float = 0.0
    @State private var cl: Float = 0.0
    @State private var water: Float = 0.0
    
    
    @State private var showToast = false
    
    
    var spacing:CGFloat = 16
    
    var meatTypes = ["鸡肉", "鸭肉", "牛肉", "鹿肉", "兔肉", "猪肉","三文鱼", "鸵鸟肉", "其他"]
    
    var contries = ["中国", "德国", "美国", "澳洲", "新西兰", "日本", "韩国", "其他"]

    

    @State private var date = Date.now
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var cans: FetchedResults<CannedFood>
    
    
    private let numberFormatter: NumberFormatter
    private let dateFormatter: DateFormatter
    
    
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
        canned.country = selectedCountry
        canned.date = selectedDate
        canned.weight = Float(weight)
        canned.pic = image.pngData()
        
        canned.water = water
        canned.protain = protain
        canned.fiber = fiber
        canned.cl = cl
        canned.phosphate = phosphate
        canned.calcium = calcium
        canned.taurine = taurine
        canned.ash = ash
        canned.fat = fat
        
        
        for meatName in selectedMeat {
            let meat = Meat(context: moc)
            meat.type = meatName
            meat.origin = canned
        }
        
        try? moc.save()
                                
    }
    
    
    var body: some View {
        ZStack{
            
            VStack(spacing: 32) {

                VStack(spacing: spacing) {
                    HStack(spacing: spacing){
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
                        VStack(spacing: spacing){
                            TextField("品牌", text: $brand)
                                .modifier(gradientTextFieldModifier(radius: 10, startColor: .pink.opacity(0.2), endColor: .orange.opacity(0.2), textColor: .TextColorPrimary, textSize: 16))
                                .multilineTextAlignment(.center)
                              
                            HStack(spacing: spacing) {
                                
                                ZStack{
                                    TextField("价格", value: $price, formatter: numberFormatter)
                                        .modifier(gradientTextFieldModifier(radius: 10, startColor: .pink.opacity(0.2), endColor: .orange.opacity(0.2), textColor: .TextColorPrimary, textSize: 16))
                                        .multilineTextAlignment(.center)
                                        .keyboardType(.decimalPad)
                                     
                                    
                                    HStack{
                                        Spacer()
                                        Text("元")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(.gray)
                                            .padding([.trailing, .top], 8)
                                        
                                    }
                            
                                }

                                HStack {
                                    Text(selectedCountry)
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
                    

                    HStack(spacing: spacing) {
                        ZStack{
                            TextField("重量", value: $weight, formatter: numberFormatter)
                                .modifier(gradientTextFieldModifier(radius: 10, startColor: .pink.opacity(0.2), endColor: .orange.opacity(0.2), textColor: .TextColorPrimary, textSize: 16))
                                .multilineTextAlignment(.center)
                                .keyboardType(.decimalPad)
                          
                                .padding([ .leading], 30)
                      
                            
                            HStack{
                                Spacer()
                                Text("克")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.gray)
                                    .padding([.trailing, .top], 8)
                                
                            }
                    
                        }
                        
                        HStack {
                        
                            
                            Text(selectedMeat.isEmpty ? "选择肉" : "查看已选")
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
                            .padding([ .trailing], 30)
                        
                    }


                    
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


                }
                
                VStack(spacing: 16){
                    HStack {
                        Text("详细信息(若没有可不填)")
                            .modifier(secondaryTextModifier(textSize: 14, weight: .semibold))
                        Spacer()
                    }
                    
                    HStack(spacing: 16) {
                        ZStack{
                            TextField("粗蛋白质", value: $protain, formatter: numberFormatter)
                                .modifier(gradientTextFieldModifier(radius: 10, startColor: .yellow.opacity(0.2), endColor: .green.opacity(0.2), textColor: .TextColorPrimary, textSize: 12))
                                .multilineTextAlignment(.center)
                                .keyboardType(.decimalPad)
                                .tint(.clear)
                      
                            
                            HStack{
                                Spacer()
                                Text("%")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.gray)
                                    .padding([.trailing, .top], 8)
                                
                            }
                    
                        }
                        
                        ZStack{
                            TextField("粗脂肪", value: $fat, formatter: numberFormatter)
                                .modifier(gradientTextFieldModifier(radius: 10, startColor: .yellow.opacity(0.2), endColor: .green.opacity(0.2), textColor: .TextColorPrimary, textSize: 12))
                                .multilineTextAlignment(.center)
                                .keyboardType(.decimalPad)
                  
    
                      
                            
                            HStack{
                                Spacer()
                                Text("%")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.gray)
                                    .padding([.trailing, .top], 8)
                                
                            }
                    
                        }
                        
                        ZStack{
                            TextField("粗灰分", value: $ash, formatter: numberFormatter)
                                .modifier(gradientTextFieldModifier(radius: 10, startColor: .yellow.opacity(0.2), endColor: .green.opacity(0.2), textColor: .TextColorPrimary, textSize: 12))
                                .multilineTextAlignment(.center)
                                .keyboardType(.decimalPad)
                 
                      
                            
                            HStack{
                                Spacer()
                                Text("%")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.gray)
                                    .padding([.trailing, .top], 8)
                                
                            }
                    
                        }
                        
                        
                        
                    }
                    
                    
                    HStack(spacing: 16) {

                        
                        ZStack{
                            TextField("粗纤维", value: $fiber, formatter: numberFormatter)
                                .modifier(gradientTextFieldModifier(radius: 10, startColor: .yellow.opacity(0.2), endColor: .green.opacity(0.2), textColor: .TextColorPrimary, textSize: 12))
                                .multilineTextAlignment(.center)
                                .keyboardType(.decimalPad)
    
                      
                            
                            HStack{
                                Spacer()
                                Text("%")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.gray)
                                    .padding([.trailing, .top], 8)
                                
                            }
                    
                        }
                        
                        ZStack{
                            TextField("钙", value: $calcium, formatter: numberFormatter)
                                .modifier(gradientTextFieldModifier(radius: 10, startColor: .yellow.opacity(0.2), endColor: .green.opacity(0.2), textColor: .TextColorPrimary, textSize: 12))
                                .multilineTextAlignment(.center)
                                .keyboardType(.decimalPad)
                     
                      
                            
                            HStack{
                                Spacer()
                                Text("%")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.gray)
                                    .padding([.trailing, .top], 8)
                                
                            }
                    
                        }
                        
                        
                        ZStack{
                            TextField("总磷", value: $phosphate, formatter: numberFormatter)
                                .modifier(gradientTextFieldModifier(radius: 10, startColor: .yellow.opacity(0.2), endColor: .green.opacity(0.2), textColor: .TextColorPrimary, textSize: 12))
                                .multilineTextAlignment(.center)
                                .keyboardType(.decimalPad)
            
    
                      
                            
                            HStack{
                                Spacer()
                                Text("%")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.gray)
                                    .padding([.trailing, .top], 8)
                                
                            }
                    
                        }

                        
                        
                        
                    }
                    
                    
                    
                    HStack(spacing: 16) {
                        ZStack{
                            TextField("牛磺酸", value: $taurine, formatter: numberFormatter)
                                .modifier(gradientTextFieldModifier(radius: 10, startColor: .yellow.opacity(0.2), endColor: .green.opacity(0.2), textColor: .TextColorPrimary, textSize: 12))
                                .multilineTextAlignment(.center)
                                .keyboardType(.decimalPad)
                      
                      
                            
                            HStack{
                                Spacer()
                                Text("%")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.gray)
                                    .padding([.trailing, .top], 8)
                                
                            }
                    
                        }
                        
                        ZStack{
                            TextField("水溶性氯化物", value: $cl, formatter: numberFormatter)
                                .modifier(gradientTextFieldModifier(radius: 10, startColor: .yellow.opacity(0.2), endColor: .green.opacity(0.2), textColor: .TextColorPrimary, textSize: 12))
                                .multilineTextAlignment(.center)
                                .keyboardType(.decimalPad)
              
    
                      
                            
                            HStack{
                                Spacer()
                                Text("%")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.gray)
                                    .padding([.trailing, .top], 8)
                                
                            }
                    
                        }
                        
                        
                        
                    }
                    
                    ZStack{
                        TextField("水分含量", value: $water, formatter: numberFormatter)
                            .modifier(gradientTextFieldModifier(radius: 10, startColor: .cyan.opacity(0.2), endColor: .blue.opacity(0.2), textColor: .TextColorPrimary, textSize: 16))
                            .multilineTextAlignment(.center)
                            .keyboardType(.decimalPad)
                         
                  
                        
                        HStack{
                            Spacer()
                            Text("%")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.gray)
                                .padding([.trailing, .top], 8)
                            
                        }
                
                    }
   
                }
                
                
                .padding([ .trailing, .leading], 30)
                
                Spacer()
                
            }
            

            
            
            
            
            
            
            
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        Helper.viberate(feedbackStyle: .heavy)
                        
//                        if selectedCountry == "国家" || selectedMeat == [] || brand == "" || price == 0.0 || weight == 0.0{
//                            showAlert = true
//                        }else {
//                            addCan()
//                            dismiss()
//                        }
                        showToast.toggle()

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

        .toast(isPresenting: $showToast){
            AlertToast(displayMode:.banner(.slide), type: .regular, title: "已添加!")
        }
        .toast(isPresenting: $showAlert){
            AlertToast(type: .regular, title: "请输入必填项")
        }
        
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
        .sheet(isPresented: $showCountry) {
            if #available(iOS 16.0, *) {
                SelectCountry(selectionList: contries, selectedItem: $selectedCountry)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            } else {
                // Fallback on earlier versions
            }
        }
        .sheet(isPresented: $showMeat) {
            if #available(iOS 16.0, *) {
                SelectView(selectionList: meatTypes, selectedItems: $selectedMeat)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            } else {
                // Fallback on earlier versions
            }
        }
        .sheet(isPresented: $showDatePicker, onDismiss: {
            print(selectedDate)
        }) {
            if #available(iOS 16.0, *) {
                SelectDate(date: $selectedDate)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
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
