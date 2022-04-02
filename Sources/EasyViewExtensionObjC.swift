//
//  EasyViewExtensionObjC.swift
//  EasyPlaceholderView
//
//  Created by carefree on 2022/3/25.
//  Copyright © 2020 carefree. All rights reserved.
//

import UIKit

public extension UIView {
    
    // MARK: - Placeholder
    @objc var easy_placeholder: EasyPlaceholder {
        get {
            return easy.placeholder
        }
    }
    
}
