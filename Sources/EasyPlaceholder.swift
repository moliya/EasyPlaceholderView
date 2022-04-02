//
//  EasyPlaceholder.swift
//  EasyPlaceholderView
//
//  Created by carefree on 2022/3/25.
//  Copyright © 2020 carefree. All rights reserved.
//

import UIKit

@objc(KFEasyPlaceholderState)
public enum EasyPlaceholderState: Int {
    case idle = 0
    case loading
    case finished
    case empty
    case failed
}

@objcMembers
open class EasyPlaceholder: NSObject {
    
    public var state: EasyPlaceholderState {
        didSet {
            
        }
    }
    public weak private(set) var view: UIView?
    
    @objc(initWithView:)
    public init(with view: UIView) {
        self.state = .idle
        self.view = view
    }
}
