//
//  EasyPlaceholderManager.swift
//  EasyPlaceholderView
//
//  Created by carefree on 2022/5/26.
//

import UIKit

@objc(KFEasyPlaceholderManager)
open class EasyPlaceholderManager: NSObject {
    
    @objc
    public static let shared = EasyPlaceholderManager()
    private override init() {}
    
    /// 默认的Placeholder配置
    @objc
    public var defaultPlaceholder: ((UIView) -> EasyPlaceholder)?
}
