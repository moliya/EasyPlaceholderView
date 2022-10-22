//
//  EasyPlaceholder.swift
//  EasyPlaceholderView
//
//  Created by carefree on 2022/3/25.
//  Copyright © 2020 carefree. All rights reserved.
//

import UIKit

/// 占位状态
@objc(KFEasyPlaceholderState)
public enum EasyPlaceholderState: Int, Hashable {
    /// 闲置状态，默认的初始状态，一般不用于展示
    case idle = 0
    /// 加载中状态，用于展示获取数据的加载效果
    case loading
    /// 已完成状态，用于展示最终的实际效果
    case finished
    /// 空数据状态，用于展示无数据的空白效果
    case empty
    /// 失败状态，用于展示网络超时、响应报错等异常效果
    case failed
}

/// 布局策略
@objc(KFEasyPlaceholderLayoutPolicy)
public enum EasyPlaceholderLayoutPolicy: Int {
    /// 默认策略
    case `default` = 0
    /// 自定义策略
    case custom
}

fileprivate class EasyCoverView: UIView {
    var lastInsets = UIEdgeInsets.zero
    var shouldAdjustCenter = true
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !shouldAdjustCenter {
            return
        }
        
        if let scrollView = superview as? UIScrollView {
            var insets = scrollView.contentInset
            if #available(iOS 11.0, *) {
                insets = scrollView.adjustedContentInset
            }
            if insets == lastInsets {
                return
            }
            lastInsets = insets
            leftToContainer(-insets.left)
            topToContainer(-insets.top)
        }
    }
}

public typealias EasyLayoutPolicy = (EasyPlaceholderLayoutPolicy) -> Void

@objc(KFEasyPlaceholderDelegate)
public protocol EasyPlaceholderDelegate: NSObjectProtocol {
    /// 为指定状态提供一个展示视图
    ///
    /// - Parameters:
    ///  - placeholder: 占位符对象
    ///  - state: 指定的状态
    /// - Returns: 展示的视图，如果是nil则不展示
    @objc(placeholder:viewForState:)
    optional func placeholder(_ placeholder: EasyPlaceholder, viewFor state: EasyPlaceholderState) -> UIView?
    
    /// 决定布局的方式
    ///
    /// - Parameters:
    ///  - placeholder: 占位符对象
    ///  - policy: 布局策略回调
    ///  - view: 需要布局的视图
    ///  - state: 指定的状态
    /// - Note: 默认的布局方式是使用Autolayout铺满父视图
    ///  如果使用EasyPlaceholderLayoutPolicy.custom，你需要自行使用Autolayout或Frame来设置视图的布局
    @objc(placeholder:decideLayoutPolicy:withView:forState:)
    optional func placeholder(_ placeholder: EasyPlaceholder, decideLayout policy: EasyLayoutPolicy, with view: UIView, for state: EasyPlaceholderState)
    
    /// 对指定状态进行自定义配置
    ///
    /// - Parameters:
    ///  - placeholder: 占位符对象
    ///  - view: 需要布局的视图
    ///  - state: 指定的状态
    /// - Note: 你可以在这里为按钮添加点击事件等操作
    @objc(placeholder:customizeView:forState:)
    optional func placeholder(_ placeholder: EasyPlaceholder, customize view: UIView, for state: EasyPlaceholderState)
    
    /// 能否改变状态
    ///
    /// - Parameters:
    ///  - placeholder: 占位符对象
    ///  - fromState: 原来的状态
    ///  - toState: 将改变的状态
    /// - Note: 你可以在这里控制状态的变更
    @objc(placeholder:shouldChangeFromState:toState:)
    optional func placeholder(_ placeholder: EasyPlaceholder, shouldChange fromState: EasyPlaceholderState, toState: EasyPlaceholderState) -> Bool
}

@objc(KFEasyPlaceholder)
open class EasyPlaceholder: NSObject {
    
    /// 目标视图
    private(set) weak var view: UIView?
    
    /// 占位状态
    @objc(state)
    public var state: EasyPlaceholderState {
        set {
            if !isEnabled {
                return
            }
            if let delegate = delegate {
                if delegate.placeholder?(self, shouldChange: self.internalState, toState: newValue) == false {
                    return
                }
            } else if let shouldChange = savedChange {
                if shouldChange(self.internalState, newValue) == false {
                    return
                }
            }
            self.internalState = newValue
        }
        get {
            return self.internalState
        }
    }
    
    /// 回调代理
    @objc(delegate)
    public var delegate: EasyPlaceholderDelegate?
    
    /// 是否启用
    @objc(enabled)
    public var isEnabled = true
    
    /// 是否可以滚动
    @objc(scrollEnabled)
    public var isScrollEnabled = false
    
    /// 是否自动调整中心位置
    @objc(shouldAdjustCenter)
    public var shouldAdjustCenter = true
    
    /// 当前显示的状态视图
    private(set) var showingView: UIView?
    
    private var savedViews = [EasyPlaceholderState: (EasyPlaceholder) -> UIView?]()
    private var savedLayouts = [EasyPlaceholderState: (UIView, EasyLayoutPolicy) -> Void]()
    private var savedCustomizations = [EasyPlaceholderState: (UIView) -> Void]()
    private var savedChange: ((EasyPlaceholderState, EasyPlaceholderState) -> Bool)?
    
    private var internalState: EasyPlaceholderState = .idle {
        didSet {
            reload(with: internalState)
        }
    }
    
    // MARK: - Public
    @objc(initWithView:)
    public init(with view: UIView?) {
        self.view = view
    }
    
    /// 为指定状态设置展示视图
    ///
    /// - Parameters:
    ///  - closure: 用于返回视图的闭包
    ///  - state: 指定的状态
    @objc(setViewBy:forState:)
    public func setView(by closure: @escaping (_ placeholder: EasyPlaceholder) -> UIView?, for state: EasyPlaceholderState) {
        savedViews[state] = closure
    }
    
    /// 为指定状态的视图设置自定义布局
    ///
    /// - Parameters:
    ///  - closure: 用于设置布局的闭包
    ///  - state: 指定的状态
    @objc(setLayoutBy:forState:)
    public func setLayout(by closure: @escaping (_ view: UIView, _ policy: EasyLayoutPolicy) -> Void, for state: EasyPlaceholderState) {
        savedLayouts[state] = closure
    }
    
    /// 为指定状态的视图添加自定义配置
    ///
    /// - Parameters:
    ///  - closure: 用于添加配置的闭包
    ///  - state: 指定的状态
    @objc(setCustomizeBy:forState:)
    public func setCustomize(by closure: @escaping (_ view: UIView) -> Void, for state: EasyPlaceholderState) {
        savedCustomizations[state] = closure
    }
    
    /// 设置状态的自定义改变
    ///
    /// - Parameters:
    ///  - closure: 用于决定改变的闭包
    @objc(setShouldChangeBy:)
    public func setShouldChange(by closure: @escaping (EasyPlaceholderState, EasyPlaceholderState) -> Bool) {
        savedChange = closure
    }
    
    /// 显示Loading状态
    @objc(showLoading)
    public func showLoading() {
        state = .loading
    }
    
    /// 显示Finished状态
    @objc(showFinished)
    public func showFinished() {
        state = .finished
    }
    
    /// 显示Empty状态
    @objc(showEmpty)
    public func showEmpty() {
        state = .empty
    }
    
    /// 显示Failed状态
    @objc(showFailed)
    public func showFailed() {
        state = .failed
    }
    
    // MARK: - Private
    private func reload(with state: EasyPlaceholderState) {
        guard let superview = self.view else { return }
        
        // 1. 视图
        guard let view = getPlaceholderView(for: state) else {
            if let coverView = showingView?.superview as? EasyCoverView {
                coverView.removeFromSuperview()
            } else {
                showingView?.removeFromSuperview()
            }
            showingView = nil
            return
        }
        
        // 2. 布局
        getLayoutPolicy(with: view, for: state) { policy in
            if view.superview == nil {
                let coverView = EasyCoverView()
                coverView.shouldAdjustCenter = shouldAdjustCenter
                coverView.addGestureRecognizer(UITapGestureRecognizer())
                if !isScrollEnabled {
                    coverView.addGestureRecognizer(UIPanGestureRecognizer())
                }
                superview.addSubview(coverView)
                coverView.topToContainer()
                coverView.leftToContainer()
                coverView.widthToContainer()
                coverView.heightToContainer()
                coverView.addSubview(view)
            }
            if policy == .default {
                // 使用默认布局
                view.topToContainer()
                view.leftToContainer()
                view.widthToContainer()
                view.heightToContainer()
            }
            if let coverView = showingView?.superview as? EasyCoverView {
                coverView.removeFromSuperview()
            } else {
                showingView?.removeFromSuperview()
            }
            showingView = view
            
            // 3. 自定义配置
            useCustomization(with: view, for: state)
        }
    }
    
    private func getPlaceholderView(for state: EasyPlaceholderState) -> UIView? {
        if let view = delegate?.placeholder?(self, viewFor: state) {
            return view
        }
        if let closure = savedViews[state] {
            return closure(self)
        }
        return nil
    }
    
    private func getLayoutPolicy(with view: UIView, for state: EasyPlaceholderState, callback: (EasyPlaceholderLayoutPolicy) -> Void) {
        if let delegate = delegate {
            delegate.placeholder?(self, decideLayout: callback, with: view, for: state)
        } else if let closure = savedLayouts[state] {
            closure(view, callback)
        } else {
            callback(.default)
        }
    }
    
    private func useCustomization(with view: UIView, for state: EasyPlaceholderState) {
        if let delegate = delegate {
            delegate.placeholder?(self, customize: view, for: state)
        }
        if let closure = savedCustomizations[state] {
            closure(view)
        }
    }
}
