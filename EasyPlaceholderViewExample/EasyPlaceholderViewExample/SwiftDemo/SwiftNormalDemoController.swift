//
//  SwiftNormalDemoController.swift
//  EasyPlaceholderViewExample
//
//  Created by carefree on 2022/6/25.
//

import UIKit
import EasyPlaceholderView

class SwiftNormalDemoController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "常用示例"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(changeState))
        
        // 添加空白页
        view.easy.placeholder?.setView(by: { _ in
            let contentView = UIView()
            contentView.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
            
            let imgView = UIImageView(image: UIImage(named: "img_empty_normal"))
            imgView.contentMode = .scaleAspectFit
            contentView.addSubview(imgView)
            imgView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-20)
                make.width.equalTo(120)
            }
            
            let msgLabel = UILabel()
            msgLabel.font = UIFont.systemFont(ofSize: 12)
            msgLabel.numberOfLines = 0
            msgLabel.textAlignment = .center
            msgLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            msgLabel.text = "这里空空如也~\nThere's nothing here~"
            contentView.addSubview(msgLabel)
            msgLabel.snp.makeConstraints { make in
                make.top.equalTo(imgView.snp_bottom).offset(-70)
                make.centerX.equalToSuperview()
            }
            
            return contentView
        }, for: .empty)
        
        // 添加失败状态的自定义配置
        view.easy.placeholder?.setCustomize(by: { [unowned self] view in
            if let button = view.subviews.filter({ $0.isKind(of: UIButton.self) }).first as? UIButton {
                // 给按钮添加点击事件
                button.addTarget(self, action: #selector(retryAction), for: .touchUpInside)
            }
        }, for: .failed)
        
        // 最终展示的内容
        let iconView = UIImageView()
        iconView.image = UIImage(named: "img_watermelon")
        self.view.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
            make.width.height.equalTo(160)
        }
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        textView.isEditable = false
        textView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        self.view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp_bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        // 开始Loading
        view.easy.placeholder?.showLoading()
    }
    
    @objc func retryAction() {
        view.easy.placeholder?.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            self.view.easy.placeholder?.showEmpty()
        }
    }

    @objc func changeState() {
        let sheet = UIAlertController(title: "变更状态(Change State)", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "加载中(Loading)", style: .default, handler: { _ in
            self.view.easy.placeholder?.showLoading()
        }))
        sheet.addAction(UIAlertAction(title: "空白(Empty)", style: .default, handler: { _ in
            self.view.easy.placeholder?.showEmpty()
        }))
        sheet.addAction(UIAlertAction(title: "失败(Failed)", style: .default, handler: { _ in
            self.view.easy.placeholder?.showFailed()
        }))
        sheet.addAction(UIAlertAction(title: "完成(Finished)", style: .default, handler: { _ in
            self.view.easy.placeholder?.showFinished()
        }))
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(sheet, animated: true, completion: nil)
    }
}
