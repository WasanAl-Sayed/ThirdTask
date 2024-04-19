//
//  ColorModel+CoreDataProperties.swift
//  ThirdTask
//
//  Created by fts on 20/04/2024.
//
//

import UIKit
import CoreData


extension ColorModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ColorModel> {
        return NSFetchRequest<ColorModel>(entityName: "ColorModel")
    }

    @NSManaged public var color: UIColor?
    @NSManaged public var desc: String?
    @NSManaged public var title: String?
    @NSManaged public var index: Int16

}

extension ColorModel : Identifiable {

}
