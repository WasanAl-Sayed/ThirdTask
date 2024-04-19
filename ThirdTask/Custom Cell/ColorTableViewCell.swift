//
//  ColorTableViewCell.swift
//  ThirdTask
//
//  Created by fts on 12/04/2024.
//

import UIKit

protocol ColorTableViewCellDelegate: AnyObject {
    func didRequestDelete()
}

class ColorTableViewCell: UITableViewCell {
    
    static let identifier = "ColorTableViewCell"
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    weak var delegate: ColorTableViewCellDelegate?
    var isSelectedFlag: Bool = false
    
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
    
    func setCheckboxVisibility(_ visibility: Bool) {
        checkbox.isHidden = !visibility
    }
    
    @IBAction func didClickCheckbox(_ sender: UIButton) {
        self.isSelectedFlag = !self.isSelectedFlag
        if(self.isSelectedFlag == true) {
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
}
