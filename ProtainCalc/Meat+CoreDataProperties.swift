//
//  Meat+CoreDataProperties.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/12/23.
//
//

import Foundation
import CoreData


extension Meat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meat> {
        return NSFetchRequest<Meat>(entityName: "Meat")
    }

    @NSManaged public var type: String?
    @NSManaged public var origin: CannedFood?

}

extension Meat : Identifiable {

}
