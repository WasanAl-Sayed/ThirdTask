//
//  ColorListViewModel.swift
//  ThirdTask
//
//  Created by fts on 04/04/2024.
//

import UIKit

class ColorListViewModel {
    
    private (set) var colorsList: [ColorListModel] = UserDefaultsManager.retrieveColorsList()
    
    func reorderCells(from sourceIndex: Int, to destinationIndex: Int) {
        let movedItem = colorsList.remove(at: sourceIndex)
        colorsList.insert(movedItem, at: destinationIndex)
        UserDefaultsManager.storeColorsList(colorsList: colorsList)
    }
}
