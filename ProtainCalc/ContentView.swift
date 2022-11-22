//
//  ContentView.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/11/12.
//

import SwiftUI

struct ContentView: View {
    

    var body: some View {
        Home()
            .font(.system(size: 30))
            .tabItem {
                Image(systemName: "house.fill")
            }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
