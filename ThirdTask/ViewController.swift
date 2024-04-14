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
    @IBOutlet weak var toolsView: UIView!
    private let viewModel = ColorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getColors()
        
        tableView.register(ColorTableViewCell.nib(), forCellReuseIdentifier: ColorTableViewCell.identifier)
    }
    
    @IBAction func didClickEditButton(_ sender: UIBarButtonItem) {
        let isEditing = tableView.isEditing
        tableView.isEditing = !isEditing
        editButton.title = isEditing ? "Edit" : "Done"
        toolsView.isHidden = isEditing ? true : false
        tableView.visibleCells.forEach { cell in
            if let colorCell = cell as? ColorTableViewCell {
                colorCell.setEditing(!isEditing)
            }
        }
    }
    
    @IBAction func didClickAddButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "newColorVC")
        viewController.navigationItem.title = "New Color"
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.colorsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ColorTableViewCell.identifier, for: indexPath) as! ColorTableViewCell
        let color = viewModel.colorsList[indexPath.row].color
        let name = viewModel.colorsList[indexPath.row].title
        cell.backgroundColor = color
        cell.titleLabel.text = name
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //viewModel.moveCell(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contentView.backgroundColor = viewModel.colorsList[indexPath.row].color
        descriptionLabel.text = viewModel.colorsList[indexPath.row].desc
    }
}
