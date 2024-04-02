//
//  UserDefaultsManager.swift
//  ThirdTask
//
//  Created by fts on 02/04/2024.
//

import UIKit

struct UserDefaultsManager: Codable {
    
    static let colorsList: [ColorListModel] = [
        ColorListModel(color: .lightGray, description: Constants.lightGray),
        ColorListModel(color: .red, description: Constants.red),
        ColorListModel(color: .systemPurple, description: Constants.purple),
        ColorListModel(color: .systemPink, description: Constants.pink),
        ColorListModel(color: .systemOrange, description: Constants.orange),
        ColorListModel(color: .systemTeal, description: Constants.teal),
        ColorListModel(color: .systemBlue, description: Constants.blue),
        ColorListModel(color: .systemCyan, description: Constants.cyan),
        ColorListModel(color: .systemYellow, description: Constants.yellow),
        ColorListModel(color: .systemBrown, description: Constants.brown),
    ]
    
    
    static func storeColorsList () {
        do {
            let encodedData = try JSONEncoder().encode(colorsList)
            UserDefaults.standard.set(encodedData, forKey: "colorsList")

        } catch {
            print("Error: Unable to encode colorsList - \(error)")
        }
    }
    
    static func retrieveColorsList () -> [ColorListModel] {
        if let savedData = UserDefaults.standard.object(forKey: "colorsList") as? Data {
            do {
                let colorsList = try JSONDecoder().decode([ColorListModel].self, from: savedData)
                return colorsList
            } catch {
                print("Error: Unable to decode colorsList - \(error)")
            }
        }
        return []
    }
}
