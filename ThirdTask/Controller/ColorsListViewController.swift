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
    @IBOutlet weak var deleteButton: UIButton!
    
    private let viewModel = ColorViewModel()
    private var selectedColor: ColorModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updateCells()
        tableView.register(ColorTableViewCell.nib(), forCellReuseIdentifier: ColorTableViewCell.identifier)
        tableView.allowsSelectionDuringEditing = true
        updateNoColorsLabelVisibility()
        selectFirstColorByDefault()
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
        updateDeleteButtonState()
        viewModel.updateContentView(selectedColor: selectedColor) { color, description in
            self.contentView.backgroundColor = color
            self.descriptionLabel.text = description
        }
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
        ) as? AddColorViewController
        viewController?.navigationItem.title = "New Color"
        viewController?.delegate = self
        navigationController?.pushViewController(viewController ?? AddColorViewController(), animated: true)
    }
    
    private func updateDeleteButtonState() {
        let isAnyCellSelected = viewModel.isAnyCellSelected()
        deleteButton.isEnabled = isAnyCellSelected
    }
    
    func selectFirstColorByDefault() {
        if let firstColor = viewModel.getAllColors().first {
            selectedColor = firstColor
            viewModel.updateContentView(selectedColor: selectedColor) { color, description in
                self.contentView.backgroundColor = color
                self.descriptionLabel.text = description
            }
        }
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
        ) as? ColorTableViewCell
        let color = viewModel.getAllColors()[indexPath.row]
        let cellModel = CellModel(
            colorModel: color,
            isEditing: tableView.isEditing,
            isSelected: false
        )
        cell?.configureCell(cellModel: cellModel)
        cell?.delegate = self
        return cell ?? ColorTableViewCell()
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
        selectedColor = selectedCellModel.colorModel
        viewModel.updateContentView(selectedColor: selectedColor) { color, description in
            self.contentView.backgroundColor = color
            self.descriptionLabel.text = description
        }
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
        
        if viewModel.getAllColors().count == 1 {
            let newColor = viewModel.getAllColors().first
            viewModel.updateContentView(selectedColor: selectedColor) { color, description in
                self.contentView.backgroundColor = color
                self.descriptionLabel.text = description
            }
        }
    }
}

extension ColorsListViewController: ColorTableViewCellDelegate {
    func checkboxToggled(isSelected: Bool, forCell cell: ColorTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        viewModel.setSelected(isSelected, at: indexPath.row)
        updateDeleteButtonState()
    }
}
