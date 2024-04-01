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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let descreption = ColorListModel.retreiveDescreption()
        let colors = ColorListModel.retreiveColors()
        let color = colors[indexPath.row]
        let name = descreption[indexPath.row]
        contentView.backgroundColor = color
        contentDescription.text = name
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let colors = ColorListModel.retreiveColors()
        return colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        let colors = ColorListModel.retreiveColors()
        let color = colors[indexPath.row]
        let name = colors[indexPath.row].accessibilityName.capitalized
        cell.backgroundColor = color
        var content = cell.defaultContentConfiguration()
        content.textProperties.color = .white
        content.text = name.capitalized
        cell.contentConfiguration = content
        return cell
    }
}
