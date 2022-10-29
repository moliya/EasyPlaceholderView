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
    var placeholder: EasyPlaceholder? {
        get {
            if let placeholder = objc_getAssociatedObject(self.base, &EasyPlaceholderKey) as? EasyPlaceholder {
                return placeholder
            }
            if let generator = EasyPlaceholderManager.shared.generator,
               let placeholder = generator.defaultPlaceholder?(for: self.base) {
                objc_setAssociatedObject(self.base, &EasyPlaceholderKey, placeholder, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return placeholder
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self.base, &EasyPlaceholderKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
