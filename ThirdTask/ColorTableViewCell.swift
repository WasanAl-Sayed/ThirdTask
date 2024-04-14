//
//  ColorTableViewCell.swift
//  ThirdTask
//
//  Created by fts on 12/04/2024.
//

import UIKit

class ColorTableViewCell: UITableViewCell {
    
    static let identifier = "ColorTableViewCell"
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabelLeadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ColorTableViewCell", bundle: nil)
    }
    
    func setEditing(_ editing: Bool) {
        checkbox.isHidden = !editing
        updateLabelLeadingConstraint()
    }
    
    private func updateLabelLeadingConstraint() {
        titleLabelLeadingConstraint.constant = checkbox.isHidden ? 18 : 50
    }
    
    @IBAction func didClickCheckbox(_ sender: UIButton) {
        sender.setImage(UIImage(systemName: "circle"), for: .normal)
        sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        sender.isSelected = !sender.isSelected
    }
}
