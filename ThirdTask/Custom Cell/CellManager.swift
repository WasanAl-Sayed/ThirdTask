//
//  CellModelUI.swift
//  ThirdTask
//
//  Created by fts on 19/04/2024.
//

import UIKit

class CellManager {
    var cells: [ColorTableViewCell] = []
    let viewModel = ColorViewModel()
    
    func configureCell(for indexPath: IndexPath, in tableView: UITableView) -> ColorTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: ColorTableViewCell.identifier, for: indexPath) as! ColorTableViewCell
        cell.backgroundColor = viewModel.getAllColors()[indexPath.row].color
        cell.titleLabel.text = viewModel.getAllColors()[indexPath.row].title
        cell.isSelectedFlag = false
        cells.append(cell)
        return cell
    }
    
    func deleteCell(tableView: UITableView) -> [ColorModel] {
        var colorsToDelete: [ColorModel] = []
        for cell in cells {
            if cell.isSelectedFlag {
                if let indexPath = tableView.indexPath(for: cell) {
                    let color = viewModel.getAllColors()[indexPath.row]
                    colorsToDelete.append(color)
                }
            }
        }
        return colorsToDelete
    }
}
