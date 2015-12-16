KSRouter
============
UINavigationController wrapper with more logical way of viewControllers routing

# Requirements
KSRouter works with iOS8+ versions with ARC.

# Installation

## Cocoapods
Add the next line info your *Podfile*:
```
pod 'KSRouter', :git => 'https://github.com/krin-san/KSRouter.git'
```
Include the main header file where you need:
```objective-c
#include <KSRouter/KSRouter.h>
```

## Manual
Copy a *KSRouter* folder into your project and include the main header file where you need
```objective-c
#include "KSRouter.h"
```

# Usage
Subclass your NavigationController (which is supposed to be a router) from *KSRouterNavigationController*:
```objective-c
@interface SidebarRouter : KSRouterNavigationController
@end

@implementation SidebarRouter

@synthesize routerId = _routerId;
@synthesize routes = _routes;

- (void)configureRouter {
	_routerId = @"sidebar";

	NSMutableArray *routes = [NSMutableArray array];
	[routes addObject:[KSRouterItem itemWithStoryboardID:NSStringFromClass([SidebarItemFirst class])]];
	[routes addObject:[KSRouterItem itemWithStoryboardID:NSStringFromClass([SidebarItemSecond class])]];
	...
	_routes = [routes copy];

	[super configureRouter];
}

- (NSString *)initialRouteKey {
	return ((KSRouterItem *)_routes.firstObject).key;
}

@end
```


# Who use
_Three closed-source projects with the names I can't tell_

# License
This code is distributed under the terms and conditions of the [MIT license](LICENSE).
