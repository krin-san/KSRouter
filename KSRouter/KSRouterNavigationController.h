//
//  KSRouterNavigationController.h
//  Copyright (c) 2015 Krin-San. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSRouterItem.h"


extern NSString * _Nonnull const kRouterNotification;
extern NSString * _Nonnull const kRouterNotificationTarget;
extern NSString * _Nonnull const kRouterNotificationAnimation;

extern NSString * _Nonnull const kRouterAnimationFade;
extern NSString * _Nonnull const kRouterAnimationPush;
extern NSString * _Nonnull const kRouterAnimationPop;

extern NSString * _Nonnull const kNextRouteKey;


@class KSRouterNavigationController;
@protocol KSRouterDelegate <NSObject>
- (void)router:(KSRouterNavigationController * _Nonnull)router willRouteToViewController:(UIViewController * _Nonnull)destination;
@end


@interface KSRouterNavigationController: UINavigationController

/// Router will handle only requests with the same routerId
@property (nonatomic, strong, readonly, nonnull) NSString *routerId;
/// All of possible routes from current router controller
@property (nonatomic, strong, readonly, nonnull) NSArray *routes;

@property (nonatomic, weak, nullable) id<KSRouterDelegate> routerDelegate;

// Subclassing API

- (void)configureRouter __attribute__((objc_requires_super));
- (NSString * _Nonnull)initialRouteKey;
- (NSString * _Nullable)nextRouteKey;
/// Default error handler
- (void)unrecognizedRoute:(NSString * _Nonnull)routeKey;

// API

- (void)performRouteWithKey:(NSString * _Nonnull)key;
- (void)performRouteWithKey:(NSString * _Nonnull)key animation:(CAAnimation * _Nullable)animation;
- (void)performRouteWithKey:(NSString * _Nonnull)key animation:(CAAnimation * _Nullable)animation segueDestination:(UIViewController * _Nullable)segueVC;
- (void)performRoute:(KSRouterItem * _Nonnull)route withAnimation:(CAAnimation * _Nullable)animation;
- (void)performRoute:(KSRouterItem * _Nonnull)route withAnimation:(CAAnimation * _Nullable)animation segueDestination:(UIViewController * _Nullable)segueVC;

- (NSString * _Nonnull)currentRouteKey;
- (KSRouterItem * _Nullable)routeByKey:(NSString * _Nonnull)key;

// Animations

+ (void)setAnimationDuration:(CFTimeInterval)duration;
+ (CAAnimation * _Nullable)animationByKey:(NSString * _Nonnull)key;

+ (CATransition * _Nonnull)fadeAnimation;
+ (CATransition * _Nonnull)pushAnimation;
+ (CATransition * _Nonnull)popAnimation;

@end
