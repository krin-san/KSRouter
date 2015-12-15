//
//  KSRouterSegue.h
//  Copyright (c) 2015 WeezLabs. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface KSRouterSegue : UIStoryboardSegue

- (void)performWithAnimationKey:(NSString * _Nullable)animationKey;

@end

@interface KSRouterFadeSegue : KSRouterSegue
@end

@interface KSRouterPushSegue : KSRouterSegue
@end

@interface KSRouterPopSegue : KSRouterSegue
@end
