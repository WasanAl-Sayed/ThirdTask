//
//  ColorListModel.swift
//  ThirdTask
//
//  Created by fts on 07/04/2024.
//

import UIKit

struct ColorListModel: Codable {
    var colorData: Data
    var description: String
    
    init(color: UIColor, description: String) {
        self.colorData = try! NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
        self.description = description
    }
    
    func getColor() -> UIColor? {
        do {
            if let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData) {
                return color
            }
        } catch {
            print("Error: Unable to unarchive color - \(error)")
        }
        return nil
    }
}
