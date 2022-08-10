//
//  UIView+Extensions.swift
//  EasyPlaceholderView
//
//  Created by carefree on 2022/6/26.
//

import UIKit

internal extension UIView {
    func edgeInContainer() {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        
        widthAnchor.constraint(equalTo: superview.widthAnchor, constant: 0).isActive = true
        heightAnchor.constraint(equalTo: superview.heightAnchor, constant: 0).isActive = true
    }
}
