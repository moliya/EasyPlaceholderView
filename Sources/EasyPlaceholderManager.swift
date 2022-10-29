//
//  EasyPlaceholderManager.swift
//  EasyPlaceholderView
//
//  Created by carefree on 2022/5/26.
//

import UIKit

@objc(EasyPlaceholderGenerator)
public protocol EasyPlaceholderGenerator: NSObjectProtocol {
    
    @objc(easy_defaultPlaceholderForView:)
    optional func defaultPlaceholder(for view: UIView) -> EasyPlaceholder
    
}

@objc(EasyPlaceholderManager)
open class EasyPlaceholderManager: NSObject {
    
    @objc(generator)
    public weak var generator: EasyPlaceholderGenerator?
    
    @objc
    public static let shared = EasyPlaceholderManager()
    private override init() {}
    
}
