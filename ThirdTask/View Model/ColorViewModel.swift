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
    var cells: [ColorTableViewCell] = []
    
    func getAllColors() -> [ColorModel] {
        return coreDataManager.getColors()
    }
    
    func deleteColor(colors: [ColorModel]) {
        coreDataManager.deleteColor(colors: colors)
    }
    
    func moveColor(from sourceIndex: Int, to destinationIndex: Int) {
        coreDataManager.moveColor(from: sourceIndex, to: destinationIndex)
    }
}
