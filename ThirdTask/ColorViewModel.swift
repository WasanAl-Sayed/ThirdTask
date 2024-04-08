//
//  ColorListViewModel.swift
//  ThirdTask
//
//  Created by fts on 04/04/2024.
//

import UIKit

class ColorViewModel {
    
    private (set) var colorsList = UserDefaultsManager.retrieveColorsList()
    
    func moveCell(from sourceIndex: Int, to destinationIndex: Int) {
        let movedItem = colorsList.remove(at: sourceIndex)
        colorsList.insert(movedItem, at: destinationIndex)
        UserDefaultsManager.storeColorsList(colorsList: colorsList)
    }
    
    func deleteCells(in rowIndex: Int) {
        colorsList.remove(at: rowIndex)
        UserDefaultsManager.storeColorsList(colorsList: colorsList)
    }
}
