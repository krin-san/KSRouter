//
//  SidebarEmbedPanel.m
//  KSRouterExample
//
//  Created by Krin-San on 15.12.15.
//  Copyright © 2015 Krin-San. All rights reserved.
//

#import "SidebarEmbedPanel.h"
#import "SidebarItems.h"

@interface SidebarEmbedPanel ()
@property (nonatomic, strong) NSArray *itemKeys;
@end


@implementation SidebarEmbedPanel

- (void)viewDidLoad {
	[super viewDidLoad];

	_itemKeys = @[@">",
				  NSStringFromClass([SidebarItemFirst class]),
				  NSStringFromClass([SidebarItemSecond class]),
				  NSStringFromClass([SidebarItemThird class])
				  ];

	// Turn off current screen buttons

	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tag == %@", @([self screenIndex])];
	NSMutableArray *buttons = [NSMutableArray array];

	[buttons addObjectsFromArray:[self.segueButtons filteredArrayUsingPredicate:predicate]];
	[buttons addObjectsFromArray:[self.notificationButtons filteredArrayUsingPredicate:predicate]];
	[buttons addObjectsFromArray:[self.directButtons filteredArrayUsingPredicate:predicate]];

	for (UIButton *button in buttons) {
		button.enabled = NO;
	}
}

- (IBAction)switchBySegue:(UIButton *)sender {
	NSString *key = self.itemKeys[sender.tag];
	[self.delegate segueRouteToSidebarItem:key];
}

- (IBAction)switchByNotification:(UIButton *)sender {
	NSString *key = self.itemKeys[sender.tag];
	[self.delegate notificationRouteToSidebarItem:key];
}

- (IBAction)switchDirectly:(UIButton *)sender {
	NSString *key = self.itemKeys[sender.tag];
	[self.delegate directRouteToSidebarItem:key];
}

@end
