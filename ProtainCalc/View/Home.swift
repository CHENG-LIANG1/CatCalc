//
//  Home.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/11/22.
//

import SwiftUI

struct Home: View {
    var screenWidth = UIScreen().bounds.size.width
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.brand)]) var cans: FetchedResults<CannedFood>
    
    @State private var showingAdditionSheet = false
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var countries = [String]()
    @State private var presentFullScreen = false
    @State private var favCanNum = 0
    
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().isTranslucent = false
        
    }
    var body: some View {


        NavigationView{
            ZStack {

                List {
                    ForEach(cans) { can in
                        Section(can.country ?? "dd") {
                            ForEach(can.meatArray) { meat in
                                Text(meat.type!)

                            }

                        }
                    }
                }
                
                
                List{



                    NavigationLink {

                        CanListView()
                    }label: {
                        HStack {
                            Image(systemName:"archivebox.fill")
                                .modifier(systemImageModifier(font:.system(size: 16), forgroundColor: .cyan, backgroundColor: .clear, renderingMode: .multicolor))
                            Text("所有罐头")
                 
                            Text("\(cans.count) 个")
                                .modifier(secondaryTextModifier(textSize: 12, weight: .bold))
                        }
                        .padding(EdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4))

                    }
                    .modifier(listViewCellModifier())

                    NavigationLink {
                        FavListView()
                    }label: {
                        HStack {
                            Image(systemName:"heart.fill")
                                .modifier(systemImageModifier(font:.system(size: 16), forgroundColor: .cyan, backgroundColor: .clear, renderingMode: .multicolor))
                            Text("我的收藏")
                            Text("\(favCanNum) 个")
                                .modifier(secondaryTextModifier(textSize: 12, weight: .bold))
                        }
                        .padding(EdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4))
                    }
                    .modifier(listViewCellModifier())



                    Section("按国家分类"){



                        ForEach(countries, id:\.self) { country in
                            NavigationLink {
          
                                BrandListView(country: country)
                            }label: {
                                Text("\(country)罐头")
                                .padding(EdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4))
                            }
                            .modifier(listViewCellModifier())

                        }


                    }


                }
                
                
            
                VStack{
                    Spacer()
                    Button{
                        withAnimation {
                            presentFullScreen.toggle()
                        }
                        
                    }label: {

                        HStack {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.gray)
                            Text("设置")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.gray)
                            
                        }
                        .padding()
                        

                    }
                }


                HStack {
                    Spacer()
                    VStack{
                        Spacer()
                        Button{
                            showingAdditionSheet.toggle()
                            Helper.viberate(feedbackStyle: .heavy)
                        }label: {

                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .black))
                                .tint(Color.white)

                        }
                        .buttonStyle(AddButtonStyle())
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 24))
                        .sheet(isPresented: $showingAdditionSheet, onDismiss: {
                            self.countries = []
                            
                            for can in cans {
                                self.countries.append(can.country ?? "未知")
                            }
                            
                            countries = Array(Set(countries))
                            countries.sort()
                        }) {
                            if #available(iOS 16.0, *) {
                                AddCan()
                                    .presentationDetents([ .large])
                                    .presentationDragIndicator(.visible)
                            } else {
                                // Fallback on earlier versions
                            }

                        }
                    }
                }
//

                .fullScreenCover(isPresented: $presentFullScreen, content: SettingsView.init)


                .navigationTitle("My Cans")
                .navigationBarHidden(true)
                .toolbar(content: {
                    Button {
                        
                    }label: {
                        
                    }
                })
                .onAppear{
                    countries = []
                    favCanNum = 0
                    for can in cans {
                        self.countries.append(can.country ?? "未知")
                        if can.favorited == 1{
                            favCanNum += 1
                        }
                    }
                    
                    countries = Array(Set(countries))
                    countries.sort()
                }
            }
        }


    }
    

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
