//
//  AddColorViewController.swift
//  ThirdTask
//
//  Created by fts on 12/04/2024.
//

import UIKit

protocol AddColorViewControllerDelegate: AnyObject {
    func didAddNewColor()
}

class AddColorViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var colorSelector: UIColorWell!
    
    private let addColorViewModel = AddColorViewModel()
    weak var delegate: AddColorViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    func configureViews() {
        configureTitleTextField()
        configureDescriptionTextView()
    }
    
    func configureDescriptionTextView() {
        let borderColor: UIColor = UIColor(named: "border") ?? UIColor.black
        descriptionTextView.layer.borderColor = borderColor.cgColor
        descriptionTextView.layer.borderWidth = 0.7
        descriptionTextView.layer.cornerRadius = 25
        let padding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        descriptionTextView.textContainerInset = padding
    }
    
    func configureTitleTextField() {
        let borderColor: UIColor = UIColor(named: "border") ?? UIColor.black
        titleTextField.layer.borderColor = borderColor.cgColor
        titleTextField.layer.borderWidth = 0.7
        titleTextField.layer.cornerRadius = 25
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: titleTextField.frame.height))
        paddingView.backgroundColor = .clear
        titleTextField.leftView = paddingView
        titleTextField.leftViewMode = .always
    }

    @IBAction func didClickAddButton(_ sender: UIButton) {
        let title = titleTextField.text 
        let description = descriptionTextView.text
        let color = colorSelector.selectedColor
        
        if title != nil &&
            description != nil &&
            color != nil {
            
            addColorViewModel.addNewColor(
                title: title ?? "",
                color: color ?? UIColor.black,
                description: description ?? ""
            )
            
            delegate?.didAddNewColor()
        }
        navigationController?.popToRootViewController(animated: true)
    }
}
