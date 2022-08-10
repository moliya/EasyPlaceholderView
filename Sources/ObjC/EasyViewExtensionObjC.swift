//
//  EasyViewExtensionObjC.swift
//  EasyPlaceholderView
//
//  Created by carefree on 2022/6/27.
//

import UIKit

public extension UIView {
    
    // MARK: - Placeholder
    @objc var easy_placeholder: EasyPlaceholder? {
        get {
            return easy.placeholder
        }
        set {
            easy.placeholder = newValue
        }
    }
    
}
