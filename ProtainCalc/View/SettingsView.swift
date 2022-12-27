//
//  SettingsView.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/12/27.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.primary.edgesIgnoringSafeArea(.all)
            Button("Dismiss Modal") {
                dismiss()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
