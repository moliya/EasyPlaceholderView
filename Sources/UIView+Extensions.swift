//
//  UIView+Extensions.swift
//  EasyPlaceholderView
//
//  Created by carefree on 2022/6/26.
//

import UIKit

internal extension UIView {
    func edgeInContainer(_ insets: UIEdgeInsets = .zero) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        for constraint in superview.constraints {
            guard let identifier = constraint.identifier, identifier.hasPrefix("EasyPlaceholderView") else {
                continue
            }
            if let item = constraint.firstItem as? UIView, item == self {
                constraint.isActive = false
                self.removeConstraint(constraint)
            }
        }
        
        let leading = leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left)
        leading.identifier = "EasyPlaceholderViewLeading"
        
        let trailing = trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right)
        trailing.identifier = "EasyPlaceholderViewTrailing"
        
        let top = topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top)
        top.identifier = "EasyPlaceholderViewTop"
        
        let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom)
        bottom.identifier = "EasyPlaceholderViewBottom"
        
        let width = widthAnchor.constraint(equalTo: superview.widthAnchor, constant: 0)
        width.identifier = "EasyPlaceholderViewWidth"
        
        let height = heightAnchor.constraint(equalTo: superview.heightAnchor, constant: 0)
        height.identifier = "EasyPlaceholderViewHeight"
        
        NSLayoutConstraint.activate([leading, trailing, top, bottom, width, height])
    }
}
