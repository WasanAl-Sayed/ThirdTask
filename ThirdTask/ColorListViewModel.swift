//
//  ColorListViewModel.swift
//  ThirdTask
//
//  Created by fts on 04/04/2024.
//

import UIKit

class ColorListViewModel {
    
    private var colorsList: [UserDefaultsManager]
    
    init() {
        self.colorsList = UserDefaultsManager.retrieveColorsList()
    }
    
    func numberOfColors() -> Int {
        return colorsList.count
    }
    
    func colorAtIndex(_ index: Int) -> UIColor? {
        return colorsList[index].getColor()
    }
    
    func descriptionAtIndex(_ index: Int) -> String {
        return colorsList[index].description
    }
    
    func reorderCells(from sourceIndex: Int, to destinationIndex: Int) {
        let movedItem = colorsList.remove(at: sourceIndex)
        colorsList.insert(movedItem, at: destinationIndex)
        storeColorsList()
    }
    
    private func storeColorsList () {
        do {
            let encodedData = try JSONEncoder().encode(colorsList)
            UserDefaults.standard.set(encodedData, forKey: "colorsList")

        } catch {
            print("Error: Unable to encode colorsList - \(error)")
        }
    }
}
