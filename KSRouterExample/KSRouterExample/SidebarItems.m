//
//  SidebarItems.m
//  KSRouterExample
//
//  Created by Krin-San on 15.12.15.
//  Copyright © 2015 Krin-San. All rights reserved.
//

#import "SidebarItems.h"
#import "SidebarEmbedPanel.h"

@interface SidebarItem () <SidebarEmbedPanelDelegate>
@end

@implementation SidebarItem

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

	NSLog(@"VIEW CONTROLLERS STACK: %@", self.navigationController.viewControllers);
}

- (NSUInteger)itemIndex {
	return 0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"Embed"]) {
		SidebarEmbedPanel *panel = segue.destinationViewController;
		panel.delegate = self;
		panel.screenIndex = [self itemIndex];
	}
}

- (void)segueRouteToSidebarItem:(NSString *)key {
	[self performSegueWithIdentifier:key sender:nil];
}

- (void)notificationRouteToSidebarItem:(NSString *)key {
	NSString *target = [NSString stringWithFormat:@"%@#%@", kSidebarRouter, key];
	NSDictionary *info = @{kRouterNotificationTarget: target, kRouterNotificationAnimation: kRouterAnimationFade};
	[NSNotificationCenter.defaultCenter postNotificationName:kRouterNotification object:nil userInfo:info];
}

- (void)directRouteToSidebarItem:(NSString *)key {
	KSRouterNavigationController *router = (KSRouterNavigationController *)self.navigationController;
	[router performRouteWithKey:key animation:[KSRouterNavigationController fadeAnimation]];
}

@end

@implementation SidebarItemFirst

- (NSUInteger)itemIndex {
	return 1;
}

@end

@implementation SidebarItemSecond

- (NSUInteger)itemIndex {
	return 2;
}

@end

@implementation SidebarItemThird

- (NSUInteger)itemIndex {
	return 3;
}

@end
