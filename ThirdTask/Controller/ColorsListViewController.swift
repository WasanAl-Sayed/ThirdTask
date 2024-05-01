//
//  ColorsListViewController.swift
//  ThirdTask
//
//  Created by fts on 21/03/2024.
//

import UIKit

class ColorsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var toolsView: UIView!
    @IBOutlet weak var noColorsLabel: UILabel!
    
    private let viewModel = ColorViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updateCells()
        tableView.register(ColorTableViewCell.nib(), forCellReuseIdentifier: ColorTableViewCell.identifier)
        tableView.allowsSelectionDuringEditing = true
        updateNoColorsLabelVisibility()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard tableView.numberOfRows(inSection: 0) > 0 else {
            return
        }
        let firstIndexPath = IndexPath(row: 0, section: 0)
        tableView.selectRow(at: firstIndexPath, animated: false, scrollPosition: .none)
        tableView(tableView, didSelectRowAt: firstIndexPath)
    }
    
    @IBAction func didClickEditButton(_ sender: UIBarButtonItem) {
        if editButton.title == "Add" {
            openAddNewColorPage()
        } else {
            let isEditing = tableView.isEditing
            tableView.isEditing = !isEditing
            editButton.title = isEditing ? "Edit" : "Done"
            toolsView.isHidden = isEditing ? true : false
            tableView.reloadData()
        }
    }
    
    @IBAction func didClickAddButton(_ sender: UIButton) {
        openAddNewColorPage()
    }
    
    @IBAction func didClickDeleteButton(_ sender: UIButton) {
        viewModel.deleteColors()
        tableView.reloadData()
        updateNoColorsLabelVisibility()
    }
    
    private func updateNoColorsLabelVisibility() {
        if viewModel.getAllColors().isEmpty {
            noColorsLabel.isHidden = false
            editButton.title = "Add"
            contentView.backgroundColor = UIColor.white
            descriptionLabel.text = " "
            toolsView.isHidden = true
        }
    }
    
    func openAddNewColorPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: "newColorVC"
        ) as! AddColorViewController
        viewController.navigationItem.title = "New Color"
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ColorsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // UITableViewDataSource functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getAllColors().count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ColorTableViewCell.identifier,
            for: indexPath
        ) as! ColorTableViewCell
        let color = viewModel.getAllColors()[indexPath.row]
        let cellModel = CellModel(
            colorModel: color,
            isEditing: tableView.isEditing,
            isSelected: false
        )
        cell.configureCell(cellModel: cellModel)
        cell.delegate = self
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        canMoveRowAt indexPath: IndexPath
    ) -> Bool {
        return true
    }
    
    func tableView(
        _ tableView: UITableView,
        moveRowAt sourceIndexPath: IndexPath,
        to destinationIndexPath: IndexPath
    ) {
        viewModel.moveColor(from: sourceIndexPath.row, to: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    // UITableViewDelegate functions
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let selectedCellModel = viewModel.cells[indexPath.row]
        contentView.backgroundColor = selectedCellModel.colorModel.color
        descriptionLabel.text = selectedCellModel.colorModel.desc
    }
    
    func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath
    ) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(
        _ tableView: UITableView,
        shouldIndentWhileEditingRowAt indexPath: IndexPath
    ) -> Bool {
        return false
    }
}

extension ColorsListViewController: AddColorViewControllerDelegate {
    func didAddNewColor() {
        viewModel.updateCells()
        tableView.isEditing = false
        editButton.title = "Edit"
        toolsView.isHidden = true
        noColorsLabel.isHidden = true
        tableView.reloadData()
    }
}

extension ColorsListViewController: ColorTableViewCellDelegate {
    func checkboxToggled(isSelected: Bool, forCell cell: ColorTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        viewModel.setSelected(isSelected, at: indexPath.row)
    }
}
