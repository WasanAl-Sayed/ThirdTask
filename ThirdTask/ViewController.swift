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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var editButton: UIBarButtonItem!
    private let viewModel = ColorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didClickEditButton(_ sender: UIBarButtonItem) {
        let isEditing = tableView.isEditing
        tableView.isEditing = !isEditing
        editButton.title = isEditing ? "Edit" : "Done"
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.colorsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        let color = viewModel.colorsList[indexPath.row].getColor()
        let name = color?.accessibilityName.capitalized
        cell.backgroundColor = color
        var content = cell.defaultContentConfiguration()
        content.textProperties.color = .white
        content.text = name?.capitalized
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel.moveCell(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteCells(in: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contentView.backgroundColor = viewModel.colorsList[indexPath.row].getColor()
        descriptionLabel.text = viewModel.colorsList[indexPath.row].description
    }
}
