//
//  ColorListViewModel.swift
//  ThirdTask
//
//  Created by fts on 04/04/2024.
//

import UIKit
import CoreData

class ColorViewModel {
    
    var colorsList: [Color] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getColors() {
        do {
            self.colorsList = try context.fetch(Color.fetchRequest())
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func addColor(title: String, color: UIColor, description: String) {
        let newColor = Color(context: self.context)
        newColor.title = title
        newColor.color = color
        newColor.desc = description
        do {
            try self.context.save()
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    func deleteColor(colors: [Color]) {
        self.getColors()
        for color in colors {
            context.delete(color)
        }
        do {
            try context.save()
        } catch {
            print("Error deleting color: \(error)")
        }
    }
    
    /*private (set) var colorsList = UserDefaultsManager.retrieveColorsList()
    
    func moveCell(from sourceIndex: Int, to destinationIndex: Int) {
        let movedItem = colorsList.remove(at: sourceIndex)
        colorsList.insert(movedItem, at: destinationIndex)
        UserDefaultsManager.storeColorsList(colorsList: colorsList)
    }
    
    func deleteCells(in rowIndex: Int) {
        colorsList.remove(at: rowIndex)
        UserDefaultsManager.storeColorsList(colorsList: colorsList)
    }*/
}
