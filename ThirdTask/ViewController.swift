//
//  ViewController.swift
//  ThirdTask
//
//  Created by fts on 21/03/2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentDescription: UILabel!
    var colorsList: [ColorListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorsList = UserDefaultsManager.retrieveColorsList()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        let color = colorsList[indexPath.row].getColor()
        let name = color?.accessibilityName.capitalized
        cell.backgroundColor = color
        var content = cell.defaultContentConfiguration()
        content.textProperties.color = .white
        content.text = name?.capitalized
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contentView.backgroundColor = colorsList[indexPath.row].getColor()
        contentDescription.text = colorsList[indexPath.row].description
    }
}



