//
//  ProtainCalcApp.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/11/12.
//

import SwiftUI

@main
struct ProtainCalcApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
