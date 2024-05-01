//
//  CoreDataManager.swift
//  ThirdTask
//
//  Created by fts on 16/04/2024.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getColors() -> [ColorModel] {
        do {
            let colorsList = try context.fetch(ColorModel.fetchRequest())
            return colorsList.sorted { $0.index < $1.index }
        } catch {
            print("Error fetching data: \(error)")
        }
        return []
    }
    
    func addColor(title: String, color: UIColor, description: String) {
        let colors = getColors()
        let newColor = ColorModel(context: context)
        newColor.title = title
        newColor.color = color
        newColor.desc = description
        newColor.index = colors.isEmpty ? 0 : (colors.last?.index ?? 0) + 1
        do {
            try context.save()
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    func deleteColors(colors: [ColorModel]) {
        for color in colors {
            context.delete(color)
        }
        do {
            try context.save()
        } catch {
            print("Error deleting color: \(error)")
        }
    }
    
    func moveColor(from sourceIndex: Int, to destinationIndex: Int) {
        let colors = getColors()
        let movedItem = colors[sourceIndex]
        var updatedColors = colors.filter { $0 != movedItem }
        updatedColors.insert(movedItem, at: destinationIndex)
        for (index, color) in updatedColors.enumerated() {
            color.index = Int16(index)
        }
        do {
            try context.save()
        } catch {
            print("Error moving color: \(error)")
        }
    }
}
