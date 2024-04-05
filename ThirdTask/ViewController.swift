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
    @IBOutlet weak var reorderButton: UIBarButtonItem!
    private let viewModel = ColorListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func reorderCells(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.isEditing = false
            reorderButton.title = "Edit"
        } else {
            tableView.isEditing = true
            reorderButton.title = "Done"
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfColors()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        let color = viewModel.colorAtIndex(indexPath.row)
        let name = color?.accessibilityName.capitalized
        cell.backgroundColor = color
        var content = cell.defaultContentConfiguration()
        content.textProperties.color = .white
        content.text = name?.capitalized
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contentView.backgroundColor = viewModel.colorAtIndex(indexPath.row)
        contentDescription.text = viewModel.descriptionAtIndex(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel.reorderCells(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}
