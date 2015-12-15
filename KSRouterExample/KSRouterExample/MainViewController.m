//
//  MainViewController.m
//  KSRouterExample
//
//  Created by Krin-San on 15.12.15.
//  Copyright © 2015 Krin-San. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
