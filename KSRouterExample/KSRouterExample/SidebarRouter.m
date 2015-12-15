//
//  SidebarRouter.m
//  KSRouterExample
//
//  Created by Krin-San on 15.12.15.
//  Copyright © 2015 Krin-San. All rights reserved.
//

#import "SidebarRouter.h"
#import "SidebarItems.h"

@implementation SidebarRouter

@synthesize routerId = _routerId;
@synthesize routes = _routes;

- (void)configureRouter {
	_routerId = kSidebarRouter;

	NSMutableArray *routes = [NSMutableArray array];
	[routes addObject:[KSRouterItem itemWithStoryboardID:NSStringFromClass([SidebarItemFirst class])]];
	[routes addObject:[KSRouterItem itemWithStoryboardID:NSStringFromClass([SidebarItemSecond class])]];
	[routes addObject:[KSRouterItem itemWithStoryboardID:NSStringFromClass([SidebarItemThird class])]];
	_routes = [routes copy];

	[super configureRouter];
}

- (NSString *)initialRouteKey {
	return ((KSRouterItem *)_routes.firstObject).key;
}

@end
