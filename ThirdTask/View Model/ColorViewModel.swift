//
//  ColorViewModel.swift
//  ThirdTask
//
//  Created by fts on 04/04/2024.
//

import UIKit

class ColorViewModel {
    
    private(set) var cells: [CellModel] = []
    private(set) var colors: [ColorModel] = []
        
    private func getAllColors() {
        colors.removeAll()
        colors = CoreDataManager.shared.getColors()
    }
    
    func updateCells() {
        getAllColors()
        cells.removeAll()
        cells = colors.map { color in
            return CellModel(
                colorModel: color,
                isEditing: false,
                isSelected: false
            )
        }
    }
        
    func deleteColors() {
        let colorsToDelete: [ColorModel] = cells.compactMap {
            $0.isSelected ? $0.colorModel : nil
        }
        CoreDataManager.shared.deleteColors(colors: colorsToDelete)
        updateCells()
    }
        
    func moveColor(from sourceIndex: Int, to destinationIndex: Int) {
        CoreDataManager.shared.moveColor(from: sourceIndex, to: destinationIndex)
        updateCells()
    }
            
    func setSelected(_ isSelected: Bool, at index: Int) {
        updateCells()
        guard index < cells.count else { return }
        cells[index].isSelected = isSelected
    }
    
    func isAnyCellSelected() -> Bool {
        return cells.contains(where: { $0.isSelected })
    }
    
    func updateContentView(selectedColor: ColorModel?, completion: @escaping (UIColor?, String?) -> Void) {
        guard let selectedColor else {
            completion(UIColor.white, " ")
            return
        }
        
        getAllColors()
        if !colors.contains(where: { $0 == selectedColor }) {
            if let firstColor = colors.first {
                completion(firstColor.color, firstColor.desc)
            } else {
                completion(UIColor.white, " ")
            }
        } else {
            completion(selectedColor.color, selectedColor.desc)
        }
    }
}
