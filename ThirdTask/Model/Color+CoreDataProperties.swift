//
//  Color+CoreDataProperties.swift
//  ThirdTask
//
//  Created by fts on 14/04/2024.
//
//

import UIKit
import CoreData


extension Color {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Color> {
        return NSFetchRequest<Color>(entityName: "Color")
    }

    @NSManaged public var color: UIColor?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?

}

extension Color : Identifiable {

}
