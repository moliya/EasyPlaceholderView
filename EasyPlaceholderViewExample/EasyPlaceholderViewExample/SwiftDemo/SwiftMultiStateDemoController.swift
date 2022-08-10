//
//  SwiftMultiStateDemoController.swift
//  EasyPlaceholderViewExample
//
//  Created by carefree on 2022/6/29.
//

import UIKit

class SwiftMultiStateDemoController: UIViewController {
    
    lazy var scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "多种状态页"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(changeState))
        
        scrollView.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.easy.placeholder?.showLoading()
    }

    @objc func changeState() {
    }
}
