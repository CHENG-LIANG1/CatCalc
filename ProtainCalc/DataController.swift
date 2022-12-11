//
//  DataController.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/12/10.
//

import SwiftUI
import CoreData
class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CatFood")
    
    init(){
        container.loadPersistentStores { des, err in
            if let err = err {
                print("Failed")
            }
        }
    }
     
}
