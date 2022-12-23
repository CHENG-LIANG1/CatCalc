//
//  CannedFood+CoreDataProperties.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/12/23.
//
//

import Foundation
import CoreData


extension CannedFood {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CannedFood> {
        return NSFetchRequest<CannedFood>(entityName: "CannedFood")
    }

    @NSManaged public var brand: String?
    @NSManaged public var country: String?
    @NSManaged public var date: Date?
    @NSManaged public var pic: Data?
    @NSManaged public var price: Float
    @NSManaged public var fat: Float
    @NSManaged public var weight: Float
    @NSManaged public var meatType: NSSet?
    
    public var meatArray: [Meat] {
        let set = meatType as? Set<Meat> ?? []
        
        return set.sorted {
            $0.type! < $1.type!
        }
    }

}

// MARK: Generated accessors for meatType
extension CannedFood {

    @objc(addMeatTypeObject:)
    @NSManaged public func addToMeatType(_ value: Meat)

    @objc(removeMeatTypeObject:)
    @NSManaged public func removeFromMeatType(_ value: Meat)

    @objc(addMeatType:)
    @NSManaged public func addToMeatType(_ values: NSSet)

    @objc(removeMeatType:)
    @NSManaged public func removeFromMeatType(_ values: NSSet)

}

extension CannedFood : Identifiable {

}
