//
//  SidebarViewController.m
//  KSRouterExample
//
//  Created by Krin-San on 15.12.15.
//  Copyright © 2015 Krin-San. All rights reserved.
//

#import "SidebarViewController.h"
#import "SidebarItems.h"

@interface SidebarViewController () <UITableViewDelegate>
@property (nonatomic, strong) NSArray *itemKeys;
@property (nonatomic, weak) KSRouterNavigationController *router;
@end

@implementation SidebarViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	_itemKeys = @[NSStringFromClass([SidebarItemFirst class]),
				  NSStringFromClass([SidebarItemSecond class]),
				  NSStringFromClass([SidebarItemThird class])
				  ];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.destinationViewController isKindOfClass:[UITableViewController class]]) {
//		UIView *view = segue.destinationViewController.view; // Load view
		((UITableViewController *)segue.destinationViewController).tableView.delegate = self;
	}
	else if ([segue.destinationViewController isKindOfClass:[KSRouterNavigationController class]]) {
		_router = segue.destinationViewController;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	if (indexPath.row == 0) {
		[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
	} else {
		NSUInteger index = indexPath.row - 1;
		NSString *key = self.itemKeys[index];
		[self.router performRouteWithKey:key animation:[KSRouterNavigationController fadeAnimation]];
	}
}

@end
