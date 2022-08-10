//
//  AppDelegate.swift
//  EasyPlaceholderViewExample
//
//  Created by carefree on 2022/3/27.
//

import UIKit
import EasyPlaceholderView
import SnapKit
import FLAnimatedImage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 设置默认的占位视图
        EasyPlaceholderManager.shared.defaultPlaceholder = { view in
            let placeholder = EasyPlaceholder(with: view)
            // 加载状态视图
            placeholder.setView(by: { _ in
                let contentView = UIView()
                contentView.backgroundColor = .white
                
                let imageView = FLAnimatedImageView()
                if let url = Bundle.main.url(forResource: "img_loading_normal", withExtension: "gif"), let data = try? Data(contentsOf: url) {
                    imageView.animatedImage = FLAnimatedImage(gifData: data)
                }
                contentView.addSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.width.equalTo(400)
                    make.height.equalTo(300)
                }
                
                let msgLabel = UILabel()
                msgLabel.font = UIFont.systemFont(ofSize: 14)
                msgLabel.text = "Loading..."
                msgLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                contentView.addSubview(msgLabel)
                msgLabel.snp.makeConstraints { make in
                    make.top.equalTo(imageView.snp_bottom).offset(-80)
                    make.centerX.equalToSuperview()
                }
                
                return contentView
            }, for: .loading)
            
            // 失败状态视图
            placeholder.setView(by: { _ in
                let contentView = UIView()
                contentView.backgroundColor = .white
                
                let imgView = UIImageView(image: UIImage(named: "img_error_normal"))
                imgView.contentMode = .scaleAspectFit
                contentView.addSubview(imgView)
                imgView.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview().offset(-50)
                    make.width.equalTo(140)
                }
                
                let msgLabel = UILabel()
                msgLabel.text = "网络离家出走了(Network Error)"
                msgLabel.font = UIFont.systemFont(ofSize: 14)
                contentView.addSubview(msgLabel)
                msgLabel.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(imgView.snp_bottom).offset(-40)
                }
                
                let button = UIButton(type: .system)
                button.layer.cornerRadius = 18
                button.clipsToBounds = true
                button.backgroundColor = #colorLiteral(red: 1, green: 0.7104307922, blue: 0.2800133115, alpha: 1)
                button.setTitle("戳这重试(Reload)", for: .normal)
                button.setTitleColor(.white, for: .normal)
                contentView.addSubview(button)
                button.snp.makeConstraints { make in
                    make.top.equalTo(msgLabel.snp_bottom).offset(15)
                    make.centerX.equalTo(contentView)
                    make.width.equalTo(180)
                    make.height.equalTo(36)
                }
                
                return contentView
            }, for: .failed)
            
            return placeholder
        }
        
        return true
    }

}

