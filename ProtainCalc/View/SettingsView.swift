//
//  SettingsView.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/12/27.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var image = UIImage()
    @State private var showImagePicker = false
    @State private var showNameEditor = false
    @State private var showAboutUsSheet = false
    @State private var name = ""
    @AppStorage("userName") private var userName = "User"
    let screenWidth = UIScreen.main.bounds.width
    
    func saveImage() {
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: "profileImage")
    }

    func loadImage() {
         guard let data = UserDefaults.standard.data(forKey: "profileImage") else { return }
         let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
         image = UIImage(data: decoded) ?? UIImage()
    }
    
    func generateButton(title: String) -> some View {
        
        return HStack {
            Text(title)
                .modifier(defaultTextModifier(textSize: 20, weight: .semibold))
            Spacer()
            Image(systemName: "chevron.compact.right")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
        }
        .padding([.leading, .trailing])
        .cornerRadius(20)
        .frame(width: screenWidth - 120)
        .padding()

    }
    
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 24) {
                ZStack{
                    Image(uiImage: image)
                        .resizable()
                        .cornerRadius(100)
                        .frame(width: 100, height: 100)

                        
                    
                    if  CGSizeEqualToSize(image.size, CGSizeZero) {
                        
                        ZStack {
                            Color.black.opacity(0.1)
                                .frame(width: 100, height: 100)
                                .cornerRadius(100, corners: .allCorners)
                            Image(systemName: "person.fill")
                                .modifier(systemImageModifier(font: .system(size: 24), forgroundColor: .pink, backgroundColor: .clear, renderingMode: .hierarchical))
                        }

                    }
                }
                .padding([.top], 24)
                .onTapGesture {
                    Helper.viberate(feedbackStyle: .heavy)
                    showImagePicker.toggle()
                }
                Text(name)
                    .modifier(defaultTextModifier(textSize: 24, weight: .semibold))
                
                Button {
                    Helper.viberate(feedbackStyle: .heavy)
                    showNameEditor.toggle()
                    
                }label: {
                    generateButton(title: "修改用户名")
                        
      
                    
                }
                .foregroundColor(.black)
                .buttonStyle(ProfileButtonStyle())
                
                Button {
                    Helper.viberate(feedbackStyle: .heavy)
                    showImagePicker.toggle()
                    
                }label: {
                    
                    generateButton(title: "修改头像")
        
                    
                }
                .foregroundColor(.black)
                .buttonStyle(ProfileButtonStyle())
                
                Button {
                    Helper.viberate(feedbackStyle: .heavy)
                    showAboutUsSheet.toggle()
                    
                }label: {
                    
                    generateButton(title: "关于 My Cans")
                }
                .foregroundColor(.black)
                .buttonStyle(ProfileButtonStyle())
                
                
//                Button {
//                    Helper.viberate(feedbackStyle: .heavy)
//
//                }label: {
//
//                    HStack {
//                        let link = URL(string: "https://www.hackingwithswift.com")!
//
//                        if #available(iOS 16.0, *) {
//
//                            ShareLink("", item: link)
//                        } else {
//                            // Fallback on earlier versions
//                        }
//                        generateButton(title: "分享 My Cans")
//
//
//                    }
//
//                }
//                .foregroundColor(.black)
//                .buttonStyle(ProfileButtonStyle())
                
                
                Spacer()
            }

            
            .sheet(isPresented: $showImagePicker, onDismiss: {
                saveImage()
                
            }, content: {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)


            })
            
            .sheet(isPresented: $showNameEditor, onDismiss: {
                userName = name
                
            }, content: {
                if #available(iOS 16.0, *) {
                    EditStringValue(title: "修改用户名", value: $name)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                } else {
                    // Fallback on earlier versions
                }

            })
            
            .sheet(isPresented: $showAboutUsSheet, content: {
                if #available(iOS 16.0, *) {
                    AboutUsView()
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                } else {
                    // Fallback on earlier versions
                }
            })
            
            

            .onAppear {
//                userName = name
                name = userName
                loadImage()
                
        
            }
            


            VStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("关闭")
                        .modifier(whiteTextModifier(textSize: 12, weight: .bold))
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .background(.cyan)
                        .clipShape(Capsule())
    
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
