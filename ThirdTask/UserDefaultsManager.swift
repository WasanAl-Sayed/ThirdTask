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
    
    static let colorsList: [UserDefaultsManager] = [
        UserDefaultsManager(color: .lightGray, description: Constants.lightGray),
        UserDefaultsManager(color: .red, description: Constants.red),
        UserDefaultsManager(color: .systemPurple, description: Constants.purple),
        UserDefaultsManager(color: .systemPink, description: Constants.pink),
        UserDefaultsManager(color: .systemOrange, description: Constants.orange),
        UserDefaultsManager(color: .systemTeal, description: Constants.teal),
        UserDefaultsManager(color: .systemBlue, description: Constants.blue),
        UserDefaultsManager(color: .systemCyan, description: Constants.cyan),
        UserDefaultsManager(color: .systemYellow, description: Constants.yellow),
        UserDefaultsManager(color: .systemBrown, description: Constants.brown),
    ]
        
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
    
    static func storeColorsList () {
        do {
            let encodedData = try JSONEncoder().encode(colorsList)
            UserDefaults.standard.set(encodedData, forKey: "colorsList")

        } catch {
            print("Error: Unable to encode colorsList - \(error)")
        }
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
