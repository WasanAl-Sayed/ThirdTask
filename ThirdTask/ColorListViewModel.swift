//
//  ColorListViewModel.swift
//  ThirdTask
//
//  Created by fts on 04/04/2024.
//

import UIKit

class ColorListViewModel {
    
    private var colorsList: [UserDefaultsManager]
    
    init() {
        self.colorsList = UserDefaultsManager.retrieveColorsList()
    }
    
    func numberOfColors() -> Int {
        return colorsList.count
    }
    
    func colorAtIndex(_ index: Int) -> UIColor? {
        return colorsList[index].getColor()
    }
    
    func descriptionAtIndex(_ index: Int) -> String {
        return colorsList[index].description
    }
}
