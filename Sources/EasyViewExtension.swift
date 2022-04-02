//
//  EasyViewExtension.swift
//  EasyPlaceholderView
//
//  Created by carefree on 2022/3/25.
//  Copyright © 2020 carefree. All rights reserved.
//

import UIKit
import EasyCompatible

private var EasyPlaceholderKey = "EasyPlaceholderKey"
//添加easy扩展
extension UIView: EasyCompatible { }

public extension EasyExtension where Base: UIView {
    
    // MARK: - Placeholder
    var placeholder: EasyPlaceholder {
        get {
            if let placeholder = objc_getAssociatedObject(self.base, &EasyPlaceholderKey) as? EasyPlaceholder {
                return placeholder
            }
            let placeholder = EasyPlaceholder(with: self.base)
            objc_setAssociatedObject(self.base, &EasyPlaceholderKey, placeholder, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return placeholder
        }
    }
    
}
