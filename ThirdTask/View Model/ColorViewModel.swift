//
//  ColorListViewModel.swift
//  ThirdTask
//
//  Created by fts on 04/04/2024.
//

import UIKit
import CoreData

class ColorViewModel {
    
    private (set) var cells: [ColorTableViewCell] = []
    
    func setCell(_ cell: ColorTableViewCell, at index: Int) {
        cells[index] = cell
    }
    
    func updateCells() {
        let colors = getAllColors()
        cells.removeAll()
        for _ in colors {
            cells.append(ColorTableViewCell())
        }
    }
    
    func getAllColors() -> [ColorModel] {
        return CoreDataManager.shared.getColors()
    }
    
    func deleteColor(tableView: UITableView) {
        var colorsToDelete: [ColorModel] = []
        let allColors: [ColorModel] = getAllColors()
        for cell in cells where cell.isSelectedFlag {
            if let indexPath = tableView.indexPath(for: cell) {
                let color = allColors[indexPath.row]
                colorsToDelete.append(color)
            }
        }
        CoreDataManager.shared.deleteColor(colors: colorsToDelete)
    }
    
    func moveColor(from sourceIndex: Int, to destinationIndex: Int) {
        CoreDataManager.shared.moveColor(from: sourceIndex, to: destinationIndex)
    }
}
