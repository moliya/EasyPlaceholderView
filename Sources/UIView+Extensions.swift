//
//  UIView+Extensions.swift
//  EasyPlaceholderView
//
//  Created by carefree on 2022/6/26.
//

import UIKit

internal extension UIView {
    func removeConstraint(for identifier: String) {
        guard let superview = self.superview else { return }
        for constraint in superview.constraints {
            if identifier == constraint.identifier {
                if let item = constraint.firstItem as? UIView, item == self {
                    constraint.isActive = false
                    removeConstraint(constraint)
                }
            }
        }
    }
    
    func leftToContainer(_ offset: CGFloat = 0) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        removeConstraint(for: "EasyPlaceholderLeft")
        let constraint = leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: offset)
        constraint.identifier = "EasyPlaceholderLeft"
        constraint.isActive = true
    }
    
    func rightToContainer(_ offset: CGFloat = 0) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        removeConstraint(for: "EasyPlaceholderRight")
        let constraint = trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: offset)
        constraint.identifier = "EasyPlaceholderRight"
        constraint.isActive = true
    }
    
    func topToContainer(_ offset: CGFloat = 0) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        removeConstraint(for: "EasyPlaceholderTop")
        let constraint = topAnchor.constraint(equalTo: superview.topAnchor, constant: offset)
        constraint.identifier = "EasyPlaceholderTop"
        constraint.isActive = true
    }
    
    func bottomToContainer(_ offset: CGFloat = 0) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        removeConstraint(for: "EasyPlaceholderBottom")
        let constraint = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: offset)
        constraint.identifier = "EasyPlaceholderBottom"
        constraint.isActive = true
    }
    
    func widthToContainer() {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        removeConstraint(for: "EasyPlaceholderWidth")
        let constraint = widthAnchor.constraint(equalTo: superview.widthAnchor, constant: 0)
        constraint.identifier = "EasyPlaceholderWidth"
        constraint.isActive = true
    }
    
    func heightToContainer() {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        removeConstraint(for: "EasyPlaceholderHeight")
        let constraint = heightAnchor.constraint(equalTo: superview.heightAnchor, constant: 0)
        constraint.identifier = "EasyPlaceholderHeight"
        constraint.isActive = true
    }
}
