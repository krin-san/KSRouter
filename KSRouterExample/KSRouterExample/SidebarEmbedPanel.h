//
//  SidebarEmbedPanel.h
//  KSRouterExample
//
//  Created by Krin-San on 15.12.15.
//  Copyright © 2015 Krin-San. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SidebarEmbedPanelDelegate <NSObject>
- (void)segueRouteToSidebarItem:(NSString *)key;
- (void)notificationRouteToSidebarItem:(NSString *)key;
- (void)directRouteToSidebarItem:(NSString *)key;
@end


@interface SidebarEmbedPanel : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *segueButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *notificationButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *directButtons;

@property (nonatomic, weak) id<SidebarEmbedPanelDelegate> delegate;
@property (nonatomic, assign) NSUInteger screenIndex;

@end
