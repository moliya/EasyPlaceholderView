//
//  SwiftMultiStateDemoController.swift
//  EasyPlaceholderViewExample
//
//  Created by carefree on 2022/6/29.
//

import UIKit
import EasyPlaceholderView

class SwiftMultiStateDemoController: UIViewController {
    
    lazy var tableView = UITableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "多种状态页"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(changeState))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.easy.placeholder?.showLoading()
    }

    @objc func changeState() {
        let sheet = UIAlertController(title: "变更状态(Change State)", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "加载中(Loading)", style: .default, handler: { _ in
            self.tableView.easy.placeholder?.showLoading()
        }))
        sheet.addAction(UIAlertAction(title: "空白(Empty)", style: .default, handler: { _ in
            self.tableView.easy.placeholder?.showEmpty()
        }))
        sheet.addAction(UIAlertAction(title: "失败(Failed)", style: .default, handler: { _ in
            self.tableView.easy.placeholder?.showFailed()
        }))
        sheet.addAction(UIAlertAction(title: "完成(Finished)", style: .default, handler: { _ in
            self.tableView.easy.placeholder?.showFinished()
        }))
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(sheet, animated: true, completion: nil)
    }
}

extension SwiftMultiStateDemoController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "abc"
        return cell
    }
}

extension SwiftMultiStateDemoController: UITableViewDelegate {
    
}
