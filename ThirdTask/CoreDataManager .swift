//
//  CoreDataManager .swift
//  ThirdTask
//
//  Created by fts on 16/04/2024.
//

import UIKit
import CoreData

class CoreDataManager {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getColors() -> [ColorModel] {
        do {
            let colorsList = try context.fetch(ColorModel.fetchRequest())
            return colorsList
        } catch {
            print("Error fetching data: \(error)")
        }
        return []
    }
    
    func addColor(title: String, color: UIColor, description: String) {
        let newColor = ColorModel(context: self.context)
        newColor.title = title
        newColor.color = color
        newColor.desc = description
        do {
            try self.context.save()
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    func deleteColor(colors: [ColorModel]) {
        for color in colors {
            context.delete(color)
        }
        do {
            try context.save()
        } catch {
            print("Error deleting color: \(error)")
        }
    }
    
    func moveCell(from sourceIndex: Int, to destinationIndex: Int) {
        
    }
}
