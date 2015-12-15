//
//  SidebarItems.h
//  KSRouterExample
//
//  Created by Krin-San on 15.12.15.
//  Copyright © 2015 Krin-San. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SidebarRouter.h"

@interface SidebarItem : UIViewController

@property (nonatomic, weak) KSRouterNavigationController *router;

@end

@interface SidebarItemFirst : SidebarItem
@end

@interface SidebarItemSecond : SidebarItem
@end

@interface SidebarItemThird : SidebarItem
@end
