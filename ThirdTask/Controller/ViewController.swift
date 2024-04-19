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
    private let cellManager = CellManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ColorTableViewCell.nib(), forCellReuseIdentifier: ColorTableViewCell.identifier)
    }
    
    @IBAction func didClickEditButton(_ sender: UIBarButtonItem) {
        let isEditing = tableView.isEditing
        tableView.isEditing = !isEditing
        editButton.title = isEditing ? "Edit" : "Done"
        toolsView.isHidden = isEditing ? true : false
        tableView.reloadData()
    }
    
    @IBAction func didClickAddButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "newColorVC") as! NewColorController
        viewController.navigationItem.title = "New Color"
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func didClickDeleteButton(_ sender: UIButton) {
        didRequestDelete()
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    //UITableViewDataSource functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getAllColors().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cellManager.configureCell(for: indexPath, in: tableView)
        cell.setCheckboxVisibility(tableView.isEditing)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel.moveColor(from: sourceIndexPath.row, to: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    //UITableViewDelegate functions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contentView.backgroundColor = viewModel.getAllColors()[indexPath.row].color
        descriptionLabel.text = viewModel.getAllColors()[indexPath.row].desc
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension ViewController: ColorTableViewCellDelegate {
    
    func didRequestDelete() {
        viewModel.deleteColor(colors: cellManager.deleteCell(tableView: tableView))
    }
}

extension ViewController: NewColorControllerDelegate {
    func didAddNewColor() {
        tableView.reloadData()
    }
}
