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
                        Section(can.brand!) {
                            ForEach(can.meatArray) { meat in
                                Text(meat.type!)
                                
                            }
                            
                            Image(uiImage: UIImage(data: can.pic ?? Data()) ?? UIImage())
                        }
                        
                    }
                }
//                List{
//                    //                    ForEach(0...30, id: \.self) {e in
//                    //
//                    //                        Text("滋奇 \(e)")
////                                                .listRowSeparator(.hidden)
////                                                .listRowBackground(
////                                                    RoundedRectangle(cornerRadius: 50)
////                                                        .background(.clear)
////                                                        .foregroundColor(Color.BackgroundColor)
////                                                        .padding(EdgeInsets(top: 8 , leading: 0, bottom: 8, trailing: 0))
////
////                                                )
//                    //                            .padding()
//                    //                            .swipeActions(edge:.leading) {
//                    //                                Button {
//                    //
//                    //                                } label: {
//                    //                                    Image(systemName: "heart.fill")
//                    //                                        .modifier(systemImageModifier(font: .largeTitle, forgroundColor: .orange, backgroundColor: .clear, renderingMode: .multicolor))
//                    //                                }
//                    //                                .tint(.clear)
//                    //                                .clipShape(Circle())
//                    //
//                    //
//                    //
//                    //                            }
//
//
//                    NavigationLink {
//
//                    }label: {
//                        HStack {
//                            Image(systemName:"archivebox.fill")
//                                .modifier(systemImageModifier(font:.system(size: 16), forgroundColor: .cyan, backgroundColor: .clear, renderingMode: .multicolor))
//                            Text("所有罐头")
//                        }
//                        .padding(EdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4))
//
//                    }
//                    .modifier(listViewCellModifier())
//
//                    NavigationLink {
//
//                    }label: {
//                        HStack {
//                            Image(systemName:"heart.fill")
//                                .modifier(systemImageModifier(font:.system(size: 16), forgroundColor: .cyan, backgroundColor: .clear, renderingMode: .multicolor))
//                            Text("我的收藏")
//                        }
//                        .padding(EdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4))
//                    }
//                    .modifier(listViewCellModifier())
//
//
//
//
//
//                    Section("按肉分类"){
//                        NavigationLink {
//
//                        }label: {
//                            Text("🐔 鸡肉罐头")
//                            .padding(EdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4))
//                        }
//                        .modifier(listViewCellModifier())
//
//
//                        NavigationLink {
//
//                        }label: {
//                            Text("🦆 鸭肉罐头")
//                            .padding(EdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4))
//                        }
//                        .modifier(listViewCellModifier())
//
//                        NavigationLink {
//
//                        }label: {
//                            Text("🐮 牛肉罐头")
//                            .padding(EdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4))
//                        }
//                        .modifier(listViewCellModifier())
//
//                        NavigationLink {
//
//                        }label: {
//                            Text("🐰 兔肉罐头")
//                            .padding(EdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4))
//                        }
//                        .modifier(listViewCellModifier())
//
//                        NavigationLink {
//
//                        }label: {
//                            Text("🦌 鹿肉罐头")
//                            .padding(EdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4))
//                        }
//                        .modifier(listViewCellModifier())
//
//                    }
//
//                    Section("按国家分类"){
//
//                        NavigationLink {
//                            BrandListView()
//                        }label: {
//                            Text("美国罐头")
//                            .padding(EdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4))
//                        }
//                        .modifier(listViewCellModifier())
//
//
//                        NavigationLink {
//                            BrandListView()
//                        }label: {
//                            Text("新西兰罐头")
//                            .padding(EdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4))
//                        }
//                        .modifier(listViewCellModifier())
//
//                        NavigationLink {
//                            BrandListView()
//                        }label: {
//                            Text("澳洲罐头")
//                            .padding(EdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4))
//                        }
//                        .modifier(listViewCellModifier())
//
//                        NavigationLink {
//                            BrandListView()
//                        }label: {
//                            Text("德国罐头")
//                            .padding(EdgeInsets(top: 17, leading: 4, bottom: 17, trailing: 4))
//                        }
//                        .modifier(listViewCellModifier())
//
//                        NavigationLink {
//                            BrandListView()
//                        }label: {
//                            Text("英国罐头")
//                            .padding(EdgeInsets(top: 17, leading: 4, bottom: 17, trailing: 4))
//                        }
//                        .modifier(listViewCellModifier())
//
//                    }
//
//
//
//
//
//                }
//
//
//
                HStack {
                    Spacer()
                    VStack{
                        Spacer()
                        Button{
                            showingAdditionSheet.toggle()
                            Helper.viberate(feedbackStyle: .heavy)
                        }label: {

                            ZStack {
                                Color.cyan
                                Image(systemName: "plus")
                                    .font(.system(size: 24, weight: .black))
                                    .tint(Color.white)
                            }
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())

                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 24))
                        .sheet(isPresented: $showingAdditionSheet) {
                            if #available(iOS 16.0, *) {
                                AddCan()
                                    .presentationDetents([.medium, .large])
                                    .presentationDragIndicator(.visible)
                            } else {
                                // Fallback on earlier versions
                            }

                        }
                    }
                }
//


                .navigationTitle("My Cans")
                .navigationBarHidden(true)
                .onAppear{

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
