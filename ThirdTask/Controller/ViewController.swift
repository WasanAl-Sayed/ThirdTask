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
    var colorsToDelete: [ColorModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ColorTableViewCell.nib(), forCellReuseIdentifier: ColorTableViewCell.identifier)
    }
    
    @IBAction func didClickEditButton(_ sender: UIBarButtonItem) {
        let isEditing = tableView.isEditing
        tableView.isEditing = !isEditing
        editButton.title = isEditing ? "Edit" : "Done"
        toolsView.isHidden = isEditing ? true : false
        checkboxStatus(!isEditing)
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
        viewModel.deleteColor(colors: colorsToDelete)
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    //UITableViewDataSource functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getAllColors().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ColorTableViewCell.identifier, for: indexPath) as! ColorTableViewCell
        cell.delegate = self
        return viewModel.configureCell(cell: cell, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
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
    func checkboxStatus(_ status: Bool) {
        for cell in tableView.visibleCells {
            guard let colorCell = cell as? ColorTableViewCell else { continue }
            colorCell.setCheckboxVisibility(status)
        }
    }
    
    func didRequestDelete() {
        for cell in tableView.visibleCells {
            guard let colorCell = cell as? ColorTableViewCell else { continue }
            if colorCell.checkbox.isSelected {
                if let indexPath = tableView.indexPath(for: colorCell) {
                    let color = viewModel.getAllColors()[indexPath.row]
                    colorsToDelete.append(color)
                }
            }
        }
    }
}

extension ViewController: NewColorControllerDelegate {
    func didAddNewColor() {
        tableView.reloadData()
    }
}
