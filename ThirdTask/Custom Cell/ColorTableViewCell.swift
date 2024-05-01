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
        
        for subViewA in subviews {
            if subViewA.classForCoder.description() == "UITableViewCellReorderControl" {
                for subViewB in subViewA.subviews {
                    if subViewB.isKind(of: UIImageView.classForCoder()) {
                        subViewB.removeFromSuperview()
                        let imageView = UIImageView()
                        if self.myReorderImage == nil {
                            if let myImage = imageView.image {
                                self.myReorderImage = myImage.withRenderingMode(.alwaysTemplate)
                            }
                        }
                        var frame = imageView.frame
                        frame.origin.x = 0
                        frame.origin.y = 23
                        frame.size = CGSize(width: 25, height: 20)
                        self.myReorderImage = UIImage(named:"3lines")
                        imageView.frame = frame
                        imageView.image = self.myReorderImage
                        subViewA.addSubview(imageView)
                        break
                    }
                }
                break
            }
        }
    }
    
    private func updateSelection(cellModel: CellModel) {
        isSelectedFlag = cellModel.isSelected
        let imageName = cellModel.isSelected ? "checkmark.circle.fill" : "circle"
        checkbox.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
