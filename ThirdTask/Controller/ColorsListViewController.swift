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
        viewModel.getAllColors()
        configureTableView()
        updateNoColorsLabelVisibility()
        selectFirstColorByDefault()
    }
    
    private func configureTableView() {
        tableView.register(ColorTableViewCell.nib(), forCellReuseIdentifier: ColorTableViewCell.identifier)
        tableView.allowsSelectionDuringEditing = true
    }
    
    private func updateNoColorsLabelVisibility() {
        if viewModel.colors.isEmpty {
            noColorsLabel.isHidden = false
            editButton.title = "Add"
            contentView.backgroundColor = UIColor.white
            descriptionLabel.text = " "
            toolsView.isHidden = true
        }
    }
    
    private func selectFirstColorByDefault() {
        if let firstColor = viewModel.colors.first {
            selectedColor = firstColor
            viewModel.updateContentView(selectedColor: selectedColor) { color, description in
                self.contentView.backgroundColor = color
                self.descriptionLabel.text = description
            }
        }
    }
    
    private func updateDeleteButtonState() {
        deleteButton.isEnabled = viewModel.isAnyCellSelected()
    }
    
    private func openAddNewColorPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: "newColorVC"
        ) as? AddColorViewController
        viewController?.navigationItem.title = "New Color"
        viewController?.delegate = self
        navigationController?.pushViewController(viewController ?? AddColorViewController(), animated: true)
    }
    
    private func configureRightBarButton(bool: Bool) {
        tableView.isEditing = !bool
        editButton.title = bool ? "Edit" : "Done"
        toolsView.isHidden = bool
        tableView.reloadData()
    }
    
    @IBAction func didPressRightBarButton(_ sender: UIBarButtonItem) {
        if editButton.title == "Add" {
            openAddNewColorPage()
        } else {
            configureRightBarButton(bool: tableView.isEditing)
        }
    }
    
    @IBAction func didPressAddButton(_ sender: UIButton) {
        openAddNewColorPage()
    }
    
    @IBAction func didPressDeleteButton(_ sender: UIButton) {
        viewModel.deleteColors()
        tableView.reloadData()
        updateNoColorsLabelVisibility()
        updateDeleteButtonState()
        viewModel.updateContentView(selectedColor: selectedColor) { color, description in
            self.contentView.backgroundColor = color
            self.descriptionLabel.text = description
        }
    }
}

extension ColorsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // UITableViewDataSource functions
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.colors.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ColorTableViewCell.identifier,
            for: indexPath
        ) as? ColorTableViewCell
        let color = viewModel.colors[indexPath.row]
        let cellModel = CellModel(
            colorModel: color,
            isEditing: tableView.isEditing,
            isSelected: false
        )
        cell?.configureCell(cellModel: cellModel, index: indexPath.row)
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
        noColorsLabel.isHidden = true
        configureRightBarButton(bool: true)
        
        if viewModel.colors.count == 1 {
            let newColor = viewModel.colors.first
            viewModel.updateContentView(selectedColor: newColor) { color, description in
                self.contentView.backgroundColor = color
                self.descriptionLabel.text = description
            }
        }
    }
}

extension ColorsListViewController: ColorTableViewCellDelegate {
    func checkboxToggled(isSelected: Bool, forIndex index: Int) {
        viewModel.setSelected(isSelected, at: index)
        updateDeleteButtonState()
    }
}
