//
//  ColorTableViewCell.swift
//  ThirdTask
//
//  Created by fts on 12/04/2024.
//

import UIKit

protocol ColorTableViewCellDelegate: AnyObject {
    func checkboxToggled(isSelected: Bool, forIndex index: Int)
}

class ColorTableViewCell: UITableViewCell {
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "ColorTableViewCell"
    private var index: Int = 0
    var isSelectedFlag: Bool = false
    weak var delegate: ColorTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ColorTableViewCell", bundle: nil)
    }
    
    private func updateSelection(cellModel: CellModel) {
        isSelectedFlag = cellModel.isSelected
        let imageName = cellModel.isSelected ? "checkmark.circle.fill" : "circle"
        checkbox.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func setCheckboxVisibility(_ visibility: Bool) {
        checkbox.isHidden = !visibility
    }
    
    func configureCell(cellModel: CellModel, index: Int) {
        backgroundColor = cellModel.colorModel.color
        titleLabel.text = cellModel.colorModel.title
        setCheckboxVisibility(cellModel.isEditing)
        updateSelection(cellModel: cellModel)
        self.index = index
    }
    
    @IBAction func didClickCheckbox(_ sender: UIButton) {
        isSelectedFlag.toggle()
        let imageName = isSelectedFlag ? "checkmark.circle.fill" : "circle"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
        delegate?.checkboxToggled(isSelected: isSelectedFlag, forIndex: index)
    }
}
