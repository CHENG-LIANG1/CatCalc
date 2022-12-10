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
    @State private var engine: CHHapticEngine?
    @State private var image = UIImage()
    
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            
            VStack {
                HStack{
                    Image(uiImage: image)
                    Text("Choose")
                }
            }
            
            
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        complexSuccess()
                        dismiss()
                    }label: {
                        Text("Done!")
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
            .onTapGesture {
                showImagePicker.toggle()
            }
        
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
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
