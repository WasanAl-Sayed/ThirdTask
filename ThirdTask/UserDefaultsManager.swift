//
//  UserDefaultsManager.swift
//  ThirdTask
//
//  Created by fts on 02/04/2024.
//

import UIKit

struct UserDefaultsManager: Codable {
    
    static func storeColorsList (colorsList: [ColorListModel]) {
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
