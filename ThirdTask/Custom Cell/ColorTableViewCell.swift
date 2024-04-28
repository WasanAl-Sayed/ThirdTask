//
//  ColorTableViewCell.swift
//  ThirdTask
//
//  Created by fts on 12/04/2024.
//

import UIKit

class ColorTableViewCell: UITableViewCell {
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var titleLabel: UILabel!

    static let identifier = "ColorTableViewCell"

    var isSelectedFlag: Bool = false
    
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
    }
    
    func configureCell(title: String, color: UIColor, isEditing: Bool) {
        backgroundColor = color
        titleLabel.text = title
        isSelectedFlag = false
        setCheckboxVisibility(isEditing)
    }
}
