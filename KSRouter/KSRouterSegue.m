//
//  KSRouterSegue.m
//  Copyright (c) 2015 WeezLabs. All rights reserved.
//

#import "KSRouterSegue.h"
#import "KSRouterNavigationController.h"


@implementation KSRouterSegue

- (void)perform {
	[self performWithAnimationKey:nil];
}

- (void)performWithAnimationKey:(NSString *)animationKey {
	UIViewController *sender = self.sourceViewController;
	NSCParameterAssert([sender.navigationController isKindOfClass:[KSRouterNavigationController class]]);
	KSRouterNavigationController *router = (KSRouterNavigationController *)sender.navigationController;
	CAAnimation *animation = [router.class animationByKey:animationKey];
	[router performRouteWithKey:self.identifier animation:animation segueDestination:self.destinationViewController];
}

@end

@implementation KSRouterFadeSegue : KSRouterSegue

- (void)perform {
	[super performWithAnimationKey:kRouterAnimationFade];
}

@end

@implementation KSRouterPushSegue : KSRouterSegue

- (void)perform {
	[super performWithAnimationKey:kRouterAnimationPush];
}

@end

@implementation KSRouterPopSegue : KSRouterSegue

- (void)perform {
	[super performWithAnimationKey:kRouterAnimationPop];
}

@end
