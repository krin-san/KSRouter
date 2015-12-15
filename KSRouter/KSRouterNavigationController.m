//
//  KSRouterNavigationController.m
//  Copyright (c) 2015 Krin-San. All rights reserved.
//

#import "KSRouterNavigationController.h"
#import "UIViewController+Router.h"


#define STRINGIFY(x) @#x

#ifdef DEBUG
#define Key(class, key) ([(class *)nil key] ? STRINGIFY(key) : STRINGIFY(key))
#else
#define Key(class, key) STRINGIFY(key)
#endif


NSString * const kRouterNotification          = @"RouterNotification";
NSString * const kRouterNotificationTarget    = @"target";
NSString * const kRouterNotificationAnimation = @"animation";

NSString * const kRouterAnimationFade = @"fadeAnimation";
NSString * const kRouterAnimationPush = @"pushAnimation";
NSString * const kRouterAnimationPop  = @"popAnimation";

NSString * const kNextRouteKey = @">";


@interface KSRouterNavigationController () <UINavigationControllerDelegate>
@property (nonatomic, weak) KSRouterItem *currentRoute;
@end


@implementation KSRouterNavigationController

#pragma mark - Init

- (id)init {
	if (self = [super init]) {
		[self initialize];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		[self initialize];
	}
	return self;
}

- (void)initialize {
	super.delegate = self;
	[self configureRouter];
}

- (void)viewDidLoad {
	[super viewDidLoad];

	// Black background for better transitions
	self.view.backgroundColor = [UIColor blackColor];

	// Show initial/default page
	[self performRouteWithKey:[self initialRouteKey] animation:nil segueDestination:[self.viewControllers firstObject]];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(performRouteByNotification:) name:kRouterNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];

	[NSNotificationCenter.defaultCenter removeObserver:self name:kRouterNotification object:nil];
}

- (void)dealloc {
	super.delegate = nil;
	[NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate {
	NSCAssert(NO, @"Router.delegate is a Router itself");
}

#pragma mark - Subclassing methods

- (void)configureRouter {
}

- (NSString *)initialRouteKey {
	return nil;
}

- (NSString *)nextRouteKey {
	NSString *key = nil;

	if (self.currentRoute) {
		NSInteger index = [self.routes indexOfObject:self.currentRoute];
		index++; // Pick next route
		key = (index < self.routes.count) ? [self.routes[index] key] : nil;
	}

	return key;
}

- (void)unrecognizedRoute:(NSString *)routeKey {
	NSCAssert2(NO, @"Router item not found: %@#%@", self.routerId, routeKey);
}

#pragma mark - API

- (void)performRouteWithKey:(NSString *)key {
	[self performRouteWithKey:key animation:nil];
}

- (void)performRouteWithKey:(NSString *)key animation:(CAAnimation *)animation {
	[self performRouteWithKey:key animation:animation segueDestination:nil];
}

- (void)performRouteWithKey:(NSString *)key animation:(CAAnimation *)animation segueDestination:(UIViewController *)segueVC {
	NSCParameterAssert(key != nil);

	// `NextRoute` feature
	if ([key isEqual:kNextRouteKey]) {
		NSString *nextKey = [self nextRouteKey];
		if (nextKey != nil) {
			[self performRouteWithKey:nextKey animation:animation segueDestination:segueVC];
		} else {
			NSLog(@"Can't perform `next` route from current route key: %@", self.currentRouteKey);
		}
		return;
	}

	// Don't allow to perform current route again
	if ([self.currentRouteKey isEqual:key]) {
		NSLog(@"Route <%@> is already active! Ignore routing request", key);
		return;
	}

	KSRouterItem *route = [self routeByKey:key];
	if (route == nil) {
		[self unrecognizedRoute:key];
		return;
	}

	[self performRoute:route withAnimation:animation segueDestination:segueVC];
}

- (void)performRoute:(KSRouterItem *)route withAnimation:(CAAnimation *)animation {
	[self performRoute:route withAnimation:animation segueDestination:nil];
}

- (void)performRoute:(KSRouterItem *)route withAnimation:(CAAnimation *)animation segueDestination:(UIViewController *)segueVC {
	self.currentRoute = route;

	NSMutableArray *viewControllers = [NSMutableArray array];

	// Instantiate dependencies
	[self instantiateDependenciesForRoute:route toContainer:viewControllers];

	// Instantiate route's target controller
	UIViewController *destination = ([segueVC.restorationIdentifier isEqualToString:route.storyboardID]) ? segueVC : [self instantiateViewControllerWithIdentifier:route.storyboardID];
	[destination fillRouterAttributes:route.attributes];
	[viewControllers addObject:destination];

	// Allow delegate to do something with destination viewController
	if ([self.routerDelegate respondsToSelector:@selector(router:willRouteToViewController:)]) {
		[self.routerDelegate router:self willRouteToViewController:destination];
	}

	// Apply animations
	if (animation != nil) {
		[self.view.layer addAnimation:animation forKey:kCATransition];
	}

	// Set this controller as root
	[self setViewControllers:[viewControllers copy] animated:NO];
}

- (void)instantiateDependenciesForRoute:(KSRouterItem *)route toContainer:(NSMutableArray *)viewControllers {
	NSCParameterAssert(route != nil);
	NSCParameterAssert(viewControllers != nil);

	for (id key in route.dependencies) {
		KSRouterItem *route = [self routeByKey:key];
		if (route == nil) {
			[self unrecognizedRoute:key];
			return;
		}

		// Initialize dependency with it's own dependencies
		[self instantiateDependenciesForRoute:route toContainer:viewControllers];

		UIViewController *dependency = [self instantiateViewControllerWithIdentifier:route.storyboardID];
		[dependency fillRouterAttributes:route.attributes];
		[viewControllers addObject:dependency];
	}
}

- (NSString *)currentRouteKey {
	return self.currentRoute.key;
}

#pragma mark Notification handling

- (void)performRouteByNotification:(NSNotification *)notification {
	NSString *target = notification.userInfo[kRouterNotificationTarget];
	NSArray *parts = [target componentsSeparatedByString:@"#"];
	NSCAssert1(parts.count == 2, @"Failed to parse router target: %@", target);
	NSString *routerId = parts[0];
	NSString *routeKey = parts[1];

	if ([routerId isEqualToString:self.routerId]) {
		id animationKey = notification.userInfo[kRouterNotificationAnimation];
		CAAnimation *animation = [self.class animationByKey:animationKey];
		[self performRouteWithKey:routeKey animation:animation];
	}
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	KSRouterItem *route = [self routeForViewController:viewController];
	if (route && self.currentRoute != route) {
		self.currentRoute = route;
	}
}

#pragma mark - Private

- (KSRouterItem *)routeByKey:(NSString *)key {
	NSPredicate *predicate = [[NSPredicate predicateWithFormat:@"%K == $key OR $key IN %K", Key(KSRouterItem, key), Key(KSRouterItem, aliases)] predicateWithSubstitutionVariables:@{@"key": key}];
	NSArray *routes = [self.routes filteredArrayUsingPredicate:predicate];
	NSCParameterAssert(routes.count <= 1);
	return [routes firstObject];
}

- (KSRouterItem *)routeForViewController:(UIViewController *)viewController {
	// Interpret restorationID as storyboardID. Anyway, storyboardID is unaccessible through public API
	NSString *storyboardID = viewController.restorationIdentifier;
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", Key(KSRouterItem, storyboardID), storyboardID];
	NSPredicate *attributeFilter = [NSPredicate predicateWithBlock:^BOOL(KSRouterItem *  _Nonnull route, NSDictionary<NSString *,id> * _Nullable bindings) {
		BOOL match = YES;
		for (NSString *key in route.attributes) {
			@try {
				if (![[viewController valueForKey:key] isEqual:route.attributes[key]]) {
					match = NO;
					break;
				}
			}
			@catch (NSException *exception) {
				match = NO;
				break;
			}
		}
		return match;
	}];
	NSArray *routes = [[self.routes filteredArrayUsingPredicate: predicate] filteredArrayUsingPredicate:attributeFilter];

	NSCParameterAssert(routes.count <= 1);
	return [routes firstObject];
}

- (UIViewController *)instantiateViewControllerWithIdentifier:(NSString *)identifier {
	UIStoryboard *storyboard;
	NSString *targetIdentifier;

	NSArray *components = [identifier componentsSeparatedByString:@"@"];
	NSCParameterAssert(components.count > 0 && components.count <= 2);
	if (components.count == 2) {
		storyboard = [UIStoryboard storyboardWithName:components[0] bundle:nil];
		targetIdentifier = components[1];
	}
	else {
		storyboard = self.storyboard;
		targetIdentifier = identifier;
	}

	return [storyboard instantiateViewControllerWithIdentifier:targetIdentifier];
}

#pragma mark - Animations

static CFTimeInterval animationDuration = 0.3;

+ (void)setAnimationDuration:(CFTimeInterval)duration {
	animationDuration = duration;
}

+ (CAAnimation *)animationByKey:(NSString *)key {
	CAAnimation *animation = nil;

	if ([key isKindOfClass:[CAAnimation class]]) {
		animation = (CAAnimation *)key;
	}
	else if ([key isKindOfClass:[NSString class]]) {
		@try {
			animation = [[self class] valueForKey:key];
		}
		@catch (NSException *exception) {
			animation = nil;
		}
	}

	return animation;
}

+ (CATransition *)fadeAnimation {
	CATransition *transition  = [CATransition animation];
	transition.duration       = animationDuration;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	transition.type           = kCATransitionFade;
	return transition;
}

+ (CATransition *)pushAnimation {
	CATransition *transition  = [CATransition animation];
	transition.duration       = animationDuration;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type           = kCATransitionPush;
	transition.subtype        = kCATransitionFromRight;
	return transition;
}

+ (CATransition *)popAnimation {
	CATransition *transition  = [CATransition animation];
	transition.duration       = animationDuration;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type           = kCATransitionReveal;
	transition.subtype        = kCATransitionFromLeft;
	return transition;
}

@end
