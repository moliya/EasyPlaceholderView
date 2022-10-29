//
//  UIView+Extensions.swift
//  EasyPlaceholderView
//
//  Created by carefree on 2022/6/26.
//

import UIKit

internal extension UIView {
    func removeConstraint(for identifier: String, withSelf: Bool = false) {
        if withSelf {
            for constraint in constraints {
                if identifier == constraint.identifier {
                    if let item = constraint.firstItem as? UIView, item == self {
                        constraint.isActive = false
                        removeConstraint(constraint)
                    }
                }
            }
        }
        
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
    
    func widthToContainer(_ margin: CGFloat = 0) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        removeConstraint(for: "EasyPlaceholderWidth")
        let constraint = widthAnchor.constraint(equalTo: superview.widthAnchor, constant: -margin)
        constraint.identifier = "EasyPlaceholderWidth"
        constraint.isActive = true
    }
    
    func heightToContainer(_ margin: CGFloat = 0) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        removeConstraint(for: "EasyPlaceholderHeight")
        let constraint = heightAnchor.constraint(equalTo: superview.heightAnchor, constant: -margin)
        constraint.identifier = "EasyPlaceholderHeight"
        constraint.isActive = true
    }
    
    func widthEqual(to constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        
        removeConstraint(for: "EasyPlaceholderWidth", withSelf: true)
        let constraint = widthAnchor.constraint(equalToConstant: constant)
        constraint.identifier = "EasyPlaceholderWidth"
        constraint.isActive = true
    }
    
    func heightEqual(to constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        
        removeConstraint(for: "EasyPlaceholderHeight", withSelf: true)
        let constraint = heightAnchor.constraint(equalToConstant: constant)
        constraint.identifier = "EasyPlaceholderHeight"
        constraint.isActive = true
    }
}
