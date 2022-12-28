//
//  AboutUsView.swift
//  ProtainCalc
//
//  Created by 梁程 on 2022/12/28.
//

import SwiftUI

struct AboutUsView: View {
    
    @State private var version = ""
    @State private var showingUserAgreement = false
    @State private var showingPrivacyPolicy = false
    
    init(){
        version = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!

    }
    //           https://humble-roadway-5e1.notion.site/b792147947774c15bce5b2cb91d76982
    //            https://humble-roadway-5e1.notion.site/2f19478733594d84901bf07a5be6710d
    //            https://humble-roadway-5e1.notion.site/35d114ed2889410d839350c5ced2a798
    var body: some View {
      
        
        VStack(spacing: 24) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .frame(width: 100, height: 100)
                .background(.cyan)
                .padding([.top], 50)

            Text("Version: \(Bundle.main.versionNumber)")
                .font(.system(size: 20, weight: .semibold))
                .italic()
            
            
            VStack(spacing: 16) {
                Button {
                    Helper.viberate(feedbackStyle: .heavy)
                    showingUserAgreement.toggle()
                    
                }label: {
                    
                    Helper.generateButton(title: "用户协议")
                }
                .foregroundColor(.black)
                .buttonStyle(ProfileButtonStyle())
                
                Button {
                    Helper.viberate(feedbackStyle: .heavy)
                    showingPrivacyPolicy.toggle()
                    
                }label: {
                    
                    Helper.generateButton(title: "隐私政策")
                }
                .foregroundColor(.black)
                .buttonStyle(ProfileButtonStyle())
            }
            

            
            Spacer()
            
                let link = URL(string: "https://www.hackingwithswift.com")!

                if #available(iOS 16.0, *) {

                    ShareLink("分享", item: link)
                        .padding()
                } else {
                    // Fallback on earlier versions
                }
        }
        .sheet(isPresented: $showingUserAgreement) {
            WebView(url: URL(string: "https://humble-roadway-5e1.notion.site/2f19478733594d84901bf07a5be6710d")!)
        }
        
        .sheet(isPresented: $showingPrivacyPolicy) {
            WebView(url: URL(string: "https://humble-roadway-5e1.notion.site/b792147947774c15bce5b2cb91d76982")!)
        }
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
