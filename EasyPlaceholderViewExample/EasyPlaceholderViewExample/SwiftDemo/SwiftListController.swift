//
//  SwiftListController.swift
//  EasyPlaceholderViewExample
//
//  Created by carefree on 2022/6/22.
//

import UIKit

class SwiftListController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            let vc = SwiftNormalDemoController()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 1 {
            let vc = SwiftMultiStateDemoController()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 2 {
            let vc = SwiftAnimationDemoController()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 3 {
            let vc = SwiftSkeletonDemoController()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
