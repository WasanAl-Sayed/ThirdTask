//
//  ColorViewModel.swift
//  ThirdTask
//
//  Created by fts on 04/04/2024.
//

import UIKit

class ColorViewModel {
    
    private (set) var cells: [CellModel] = []
        
    func updateCells() {
        let colors = getAllColors()
        cells.removeAll()
        for color in colors {
            let cellModel = CellModel(
                colorModel: color,
                isEditing: false,
                isSelected: false
            )
            cells.append(cellModel)
        }
    }
        
    func getAllColors() -> [ColorModel] {
        return CoreDataManager.shared.getColors()
    }
        
    func deleteColors() {
        var colorsToDelete: [ColorModel] = []
                
        for (_, cell) in cells.enumerated() where cell.isSelected {
            let color = cell.colorModel
            colorsToDelete.append(color)
        }
        CoreDataManager.shared.deleteColors(colors: colorsToDelete)
        updateCells()
    }
        
    func moveColor(from sourceIndex: Int, to destinationIndex: Int) {
        CoreDataManager.shared.moveColor(from: sourceIndex, to: destinationIndex)
    }
            
    func setSelected(_ isSelected: Bool, at index: Int) {
        cells[index].isSelected = isSelected
    }
}
