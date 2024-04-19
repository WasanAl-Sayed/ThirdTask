//
//  NewColorController.swift
//  ThirdTask
//
//  Created by fts on 12/04/2024.
//

import UIKit

protocol NewColorControllerDelegate: AnyObject {
    func didAddNewColor()
}

class NewColorController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var colorSelector: UIColorWell!
    private let viewModel = ColorViewModel()
    weak var delegate: NewColorControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let borderColor : UIColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        descriptionTextView.layer.borderColor = borderColor.cgColor
        descriptionTextView.layer.borderWidth = 0.7
        descriptionTextView.layer.cornerRadius = 25
        titleTextField.layer.borderColor = borderColor.cgColor
        titleTextField.layer.borderWidth = 0.7
        titleTextField.layer.cornerRadius = 25
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: titleTextField.frame.height))
        paddingView.backgroundColor = .clear
        titleTextField.leftView = paddingView
        titleTextField.leftViewMode = .always
        let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        descriptionTextView.textContainerInset = padding
    }
    
    @IBAction func didClickAddButton(_ sender: UIButton) {
        if titleTextField.text != nil && descriptionTextView.text != nil && colorSelector.selectedColor != nil {
            viewModel.addNewColor(title: titleTextField.text ?? "", color: colorSelector.selectedColor ?? UIColor.black, description: descriptionTextView.text)
            delegate?.didAddNewColor()
        }
        navigationController?.popToRootViewController(animated: true)
    }
}
