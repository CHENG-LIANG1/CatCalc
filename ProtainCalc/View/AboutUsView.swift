//
//  AboutUsView.swift
//  ProtainCalc
//
//  Created by 梁程 on 2022/12/28.
//

import SwiftUI

struct AboutUsView: View {
    
    @State private var version = ""
    
    init(){
        version = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!

    }
    
    var body: some View {
      
        
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .frame(width: 100, height: 100)
                .background(.cyan)
                .padding([.top], 50)

            Text("Version: \(Bundle.main.versionNumber)")
                .font(.system(size: 20, weight: .semibold))
                .italic()
            
            Spacer()
            
                let link = URL(string: "https://www.hackingwithswift.com")!

                if #available(iOS 16.0, *) {

                    ShareLink("分享", item: link)
                        .padding()
                } else {
                    // Fallback on earlier versions
                }
        }
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
