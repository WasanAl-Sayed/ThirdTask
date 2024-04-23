//
//  AddColorViewModel.swift
//  ThirdTask
//
//  Created by fts on 23/04/2024.
//

import UIKit

class AddColorViewModel {
    let coreDataManager = CoreDataManager()
    func addNewColor(title: String, color: UIColor, description: String) {
        coreDataManager.addColor(title: title, color: color, description: description)
    }
}
