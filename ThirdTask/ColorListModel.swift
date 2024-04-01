import UIKit

struct ColorListModel {
    
    static let colors: [UIColor] = [.lightGray, .red, .systemPurple, .systemPink, .systemOrange, .systemTeal, .systemBlue, .systemCyan, .systemYellow, .systemBrown]
    static let descreption: [String] = [Constants.lightGray, Constants.red, Constants.purple, Constants.pink, Constants.orange, Constants.teal, Constants.blue, Constants.cyan, Constants.yellow, Constants.brown]
    
    static func storeDescreption () {
        UserDefaults.standard.set(descreption, forKey: "descreption")
    }
    
    static func retreiveDescreption () -> [String] {
        guard let descreption = UserDefaults.standard.object(forKey: "descreption") as? [String] else {
            return []
        }
        return descreption
    }
    
    static func storeColors () {
        do {
            let colorDataArray = try colors.map { try NSKeyedArchiver.archivedData(withRootObject: $0, requiringSecureCoding: false) }
            UserDefaults.standard.set(colorDataArray, forKey: "colors")
        } catch {
            print("Error: Unable to archive colors - \(error)")
        }
    }
    
    static func retreiveColors () -> [UIColor] {
        guard let colorDataArray = UserDefaults.standard.array(forKey: "colors") as? [Data] else {
            return []
        }
        do {
            let colors = try colorDataArray.compactMap { try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: $0) }
            return colors
        } catch {
            print("Error: Unable to unarchive colors - \(error)")
            return []
        }
    }
}
