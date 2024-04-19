//
//  ColorListViewModel.swift
//  ThirdTask
//
//  Created by fts on 04/04/2024.
//

import UIKit
import CoreData

class ColorViewModel {
    
    let coreDataManager = CoreDataManager()
    
    func getAllColors() -> [ColorModel] {
        return coreDataManager.getColors()
    }
    
    func addNewColor(title: String, color: UIColor, description: String) {
        coreDataManager.addColor(title: title, color: color, description: description)
    }
    
    func deleteColor(colors: [ColorModel]) {
        coreDataManager.deleteColor(colors: colors)
    }
    
    func moveColor(from sourceIndex: Int, to destinationIndex: Int) {
        coreDataManager.moveColor(from: sourceIndex, to: destinationIndex)
    }
}
