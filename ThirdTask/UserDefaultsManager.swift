//
//  UserDefaultsManager.swift
//  ThirdTask
//
//  Created by fts on 02/04/2024.
//

import UIKit

struct UserDefaultsManager: Codable {
    
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
    
    static func retrieveColorsList () -> [UserDefaultsManager] {
        if let savedData = UserDefaults.standard.object(forKey: "colorsList") as? Data {
            do {
                let colorsList = try JSONDecoder().decode([UserDefaultsManager].self, from: savedData)
                return colorsList
            } catch {
                print("Error: Unable to decode colorsList - \(error)")
            }
        }
        return []
    }
}
