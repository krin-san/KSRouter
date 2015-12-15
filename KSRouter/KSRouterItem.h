//
//  KSRouterItem.h
//  Copyright (c) 2015 Krin-San. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KSRouterItem : NSObject

/// Main key to handle routing
@property (nonatomic, strong, readonly, nonnull) NSString *key;
/// Different string aliases that could point on this route
@property (nonatomic, strong, readonly, nullable) NSArray *aliases;
/**
 Identifier to instantiate target view controller
 @note You must check `Use Storyboard ID` below `Restoration ID` field for proper `nextRoute` feature working
 */
@property (nonatomic, strong, readonly, nonnull) NSString *storyboardID;
/// Main keys of all target controller dependencies. All of them will lie before target controller in navigation stack
@property (nonatomic, strong, readonly, nullable) NSArray *dependencies;
/// KVO-attributes with required values to be set
@property (nonatomic, strong, readonly, nullable) NSDictionary *attributes;

+ (instancetype _Nonnull)itemWithStoryboardID:(NSString * _Nonnull)storyboardID;
+ (instancetype _Nonnull)itemWithKey:(NSString * _Nullable)key storyboardID:(NSString * _Nonnull)storyboardID;
+ (instancetype _Nonnull)itemWithKey:(NSString * _Nullable)key storyboardID:(NSString * _Nonnull)storyboardID aliases:(NSArray * _Nullable)aliases;
+ (instancetype _Nonnull)itemWithKey:(NSString * _Nullable)key storyboardID:(NSString * _Nonnull)storyboardID dependencies:(NSArray * _Nullable)dependencies;
+ (instancetype _Nonnull)itemWithKey:(NSString * _Nullable)key storyboardID:(NSString * _Nonnull)storyboardID aliases:(NSArray * _Nullable)aliases dependencies:(NSArray * _Nullable)dependencies;
+ (instancetype _Nonnull)itemWithKey:(NSString * _Nullable)key storyboardID:(NSString * _Nonnull)storyboardID attributes:(NSDictionary * _Nullable)attributes;
+ (instancetype _Nonnull)itemWithKey:(NSString * _Nullable)key storyboardID:(NSString * _Nonnull)storyboardID aliases:(NSArray * _Nullable)aliases attributes:(NSDictionary * _Nullable)attributes;
+ (instancetype _Nonnull)itemWithKey:(NSString * _Nullable)key storyboardID:(NSString * _Nonnull)storyboardID dependencies:(NSArray * _Nullable)dependencies attributes:(NSDictionary * _Nullable)attributes;
+ (instancetype _Nonnull)itemWithKey:(NSString * _Nullable)key storyboardID:(NSString * _Nonnull)storyboardID aliases:(NSArray * _Nullable)aliases dependencies:(NSArray * _Nullable)dependencies attributes:(NSDictionary * _Nullable)attributes;

- (instancetype _Nonnull)initWithKey:(NSString * _Nullable)key storyboardID:(NSString * _Nonnull)storyboardID aliases:(NSArray * _Nullable)aliases dependencies:(NSArray * _Nullable)dependencies attributes:(NSDictionary * _Nullable)attributes;

@end
