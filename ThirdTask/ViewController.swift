//
//  ViewController.swift
//  ThirdTask
//
//  Created by fts on 21/03/2024.
//

import UIKit

class ViewController: UIViewController {
    //UI elements
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = Array(ColorListModel.colors)[indexPath.row]
        let color = selectedRow.key
        let name = selectedRow.value
        
        contentView.backgroundColor = color
        contentDescription.text = name
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ColorListModel.colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        let colorTuple = Array(ColorListModel.colors)[indexPath.row]
        let color = colorTuple.key
        let name = color.accessibilityName.capitalized
        
        cell.backgroundColor = color
        var content = cell.defaultContentConfiguration()
        content.textProperties.color = .white
        content.text = name.capitalized
        cell.contentConfiguration = content
        
        return cell
    }
}
