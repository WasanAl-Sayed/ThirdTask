//
//  ColorTransformer.swift
//  ThirdTask
//
//  Created by fts on 14/04/2024.
//

import UIKit

class ColorTransformer: NSSecureUnarchiveFromDataTransformer {
    override class var allowedTopLevelClasses: [AnyClass] {
        return [UIColor.self]
    }
    
    static func register() {
        let transformer = ColorTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: NSValueTransformerName(rawValue: "ColorTransformer"))
    }
}
