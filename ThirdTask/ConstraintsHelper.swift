//
//  ConstraintsHelper.swift
//  ThirdTask
//
//  Created by fts on 23/03/2024.
//

import UIKit

class ConstraintsHelper {
    
    static func applyLandscapeConstraints(view: UIView, tableView: UITableView, content: UIView) -> [NSLayoutConstraint] {
        var landscapeConstraints = [NSLayoutConstraint]()
            
        tableView.translatesAutoresizingMaskIntoConstraints = false
        content.translatesAutoresizingMaskIntoConstraints = false
            
        let tableViewLeadingConstraint = tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let tableViewTopConstraint = tableView.topAnchor.constraint(equalTo: view.topAnchor)
        let tableViewBottomConstraint = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let tableViewWidthConstraint = tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
            
        landscapeConstraints.append(contentsOf: [tableViewLeadingConstraint, tableViewTopConstraint, tableViewBottomConstraint, tableViewWidthConstraint])
            
        let contentViewLeadingConstraint = content.leadingAnchor.constraint(equalTo: tableView.trailingAnchor)
        let contentViewTopConstraint = content.topAnchor.constraint(equalTo: view.topAnchor)
        let contentViewBottomConstraint = content.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let contentViewTrailingConstraint = content.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        landscapeConstraints.append(contentsOf: [contentViewLeadingConstraint, contentViewTopConstraint, contentViewBottomConstraint, contentViewTrailingConstraint])
            
        NSLayoutConstraint.activate(landscapeConstraints)
            
        return landscapeConstraints
    }
}
