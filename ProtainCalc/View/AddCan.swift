//
//  AddCan.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/12/10.
//

import SwiftUI
import CoreHaptics


struct AddCan: View {
    @State private var showImagePicker = false
    @State private var showCountry = false
    @State private var engine: CHHapticEngine?
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
    
    init() {
      numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .decimal
        numberFormatter.zeroSymbol = ""

    }
    var body: some View {
        ZStack{
            
            VStack() {
                HStack(spacing: 8){
                    ZStack{
                        Image(uiImage: image)
                            .resizable()
                            .cornerRadius(20)
                            .frame(width: 100, height: 100)
                            .padding([.trailing])
                            
                        
                        if  CGSizeEqualToSize(image.size, CGSizeZero) {
                            
                            ZStack {
                                Color.black.opacity(0.1)
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(20, corners: .allCorners)
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
                          
                        HStack(spacing: 10) {
                            
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
                                .background(LinearGradient(gradient: Gradient(colors: [.pink.opacity(0.2), .orange.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .onTapGesture {
                                    showCountry = true
                                }
                        }
     
                    }
                    

                    

    

                    

       
    

                }
                .padding([.top, .trailing, .leading], 30)

                HStack {
                    Picker("\(meat)", selection: $meat) {
                        ForEach(meatTypes, id:\.self) { m in
                                Text("\(m)")

                            }
                        }
                    .tint(.primary)
            
            

                    
                    
                    Picker("\(country)", selection: $country) {
                        ForEach(contries, id:\.self) { c in
                                Text("\(c)")

                            }
                        }
                    .tint(.primary)
         

                }
                Spacer()
            }
            
            
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        complexSuccess()
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
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }

}

struct AddCan_Previews: PreviewProvider {
    static var previews: some View {
        AddCan()
    }
}
