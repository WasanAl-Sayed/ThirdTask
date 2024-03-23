//
//  ViewController.swift
//  ThirdTask
//
//  Created by fts on 21/03/2024.
//

import UIKit

class ViewController: UIViewController {
    //portrait constraints
    @IBOutlet weak var one: NSLayoutConstraint!
    @IBOutlet weak var two: NSLayoutConstraint!
    @IBOutlet weak var three: NSLayoutConstraint!
    @IBOutlet weak var four: NSLayoutConstraint!
    @IBOutlet weak var five: NSLayoutConstraint!
    @IBOutlet weak var six: NSLayoutConstraint!
    @IBOutlet weak var seven: NSLayoutConstraint!
    @IBOutlet weak var eight: NSLayoutConstraint!
    @IBOutlet weak var nine: NSLayoutConstraint!
    @IBOutlet weak var ten: NSLayoutConstraint!
    @IBOutlet weak var eleven: NSLayoutConstraint!
    //UI elements
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentDescription: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    //constraints arrays
    var landscapeConstraints: [NSLayoutConstraint] = []
    var portraitConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        //add portrait constraints to the portrait constraints array
        portraitConstraints.append(one)
        portraitConstraints.append(two)
        portraitConstraints.append(three)
        portraitConstraints.append(four)
        portraitConstraints.append(five)
        portraitConstraints.append(six)
        portraitConstraints.append(seven)
        portraitConstraints.append(eight)
        portraitConstraints.append(nine)
        portraitConstraints.append(ten)
        portraitConstraints.append(eleven)
    }
    
    @objc func orientationChanged(notification: NSNotification) {
        let deviceOrientation = UIDevice.current.orientation

        switch deviceOrientation {
        case .portrait, .portraitUpsideDown:
            applyPortraitConstraints()
        case .landscapeLeft, .landscapeRight:
            applyLandscapeConstraints()
        default:
            print("unknown orientation")
        }
    }
    
    func applyPortraitConstraints() {
        NSLayoutConstraint.deactivate(landscapeConstraints)
        view.addConstraints(portraitConstraints)
    }
    
    func applyLandscapeConstraints() {
        NSLayoutConstraint.deactivate(portraitConstraints)
        NSLayoutConstraint.deactivate(landscapeConstraints)
        landscapeConstraints = ConstraintsHelper.applyLandscapeConstraints(view: self.view, tableView: tableView, content: contentView)
        NSLayoutConstraint.activate(landscapeConstraints)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = Array(ColorListModel.colors)[indexPath.row]
        let color = selectedRow.key
        let name = selectedRow.value
        
        contentView.backgroundColor = color
        contentDescription.text = name
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ColorListModel.colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        let colorTuple = Array(ColorListModel.colors)[indexPath.row]
        let color = colorTuple.key
        let name = color.accessibilityName.capitalized
        
        cell.backgroundColor = color
        var content = cell.defaultContentConfiguration()
        content.textProperties.color = .white
        content.text = name.capitalized
        cell.contentConfiguration = content
        
        return cell
    }
}
