//
//  ObjCListController.m
//  EasyPlaceholderViewExample
//
//  Created by carefree on 2022/6/22.
//

#import "ObjCListController.h"
#import "ObjCNormalDemoController.h"

@interface ObjCListController ()

@end

@implementation ObjCListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        ObjCNormalDemoController *vc = [[ObjCNormalDemoController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
