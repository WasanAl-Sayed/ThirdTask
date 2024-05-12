//
//  AddColorViewModel.swift
//  ThirdTask
//
//  Created by fts on 23/04/2024.
//

import UIKit

class AddColorViewModel: ColorViewModel {
    func addNewColor(title: String, color: UIColor, description: String) {
        CoreDataManager.shared.addColor(title: title, color: color, description: description)
        updateCells()
    }
}
