//
//  Product+CoreDataProperties.swift
//  ThrowAway
//
//  Created by Sujin Jin on 2022/11/05.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var title: String?
    @NSManaged public var memo: String?
    @NSManaged public var cleaningDay: Date?
    @NSManaged public var image: Data?

}

extension Product : Identifiable {

}
