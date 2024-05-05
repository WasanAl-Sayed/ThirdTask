//
//  ColorTableViewCell.swift
//  ThirdTask
//
//  Created by fts on 12/04/2024.
//

import UIKit

protocol ColorTableViewCellDelegate: AnyObject {
    func checkboxToggled(isSelected: Bool, forCell cell: ColorTableViewCell)
}

class ColorTableViewCell: UITableViewCell {
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    private var myReorderImage: UIImage? = nil

    static let identifier = "ColorTableViewCell"

    var isSelectedFlag: Bool = false
    weak var delegate: ColorTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ColorTableViewCell", bundle: nil)
    }
    
    func setCheckboxVisibility(_ visibility: Bool) {
        checkbox.isHidden = !visibility
    }
    
    @IBAction func didClickCheckbox(_ sender: UIButton) {
        isSelectedFlag.toggle()
        let imageName = isSelectedFlag ? "checkmark.circle.fill" : "circle"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
        delegate?.checkboxToggled(isSelected: isSelectedFlag, forCell: self)
    }
    
    func configureCell(cellModel: CellModel) {
        backgroundColor = cellModel.colorModel.color
        titleLabel.text = cellModel.colorModel.title
        setCheckboxVisibility(cellModel.isEditing)
        updateSelection(cellModel: cellModel)
    }
    
    private func updateSelection(cellModel: CellModel) {
        isSelectedFlag = cellModel.isSelected
        let imageName = cellModel.isSelected ? "checkmark.circle.fill" : "circle"
        checkbox.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
