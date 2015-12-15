//
//  KSRouterItem.m
//  Copyright (c) 2015 Krin-San. All rights reserved.
//

#import "KSRouterItem.h"


@implementation KSRouterItem

+ (instancetype)itemWithStoryboardID:(NSString *)storyboardID {
	return [self itemWithKey:nil storyboardID:storyboardID];
}

+ (instancetype)itemWithKey:(NSString *)key storyboardID:(NSString *)storyboardID {
	return [self itemWithKey:key storyboardID:storyboardID aliases:nil dependencies:nil attributes:nil];
}

+ (instancetype)itemWithKey:(NSString *)key storyboardID:(NSString *)storyboardID aliases:(NSArray *)aliases {
	return [self itemWithKey:key storyboardID:storyboardID aliases:aliases dependencies:nil attributes:nil];
}

+ (instancetype)itemWithKey:(NSString *)key storyboardID:(NSString *)storyboardID dependencies:(NSArray *)dependencies {
	return [self itemWithKey:key storyboardID:storyboardID aliases:nil dependencies:dependencies attributes:nil];
}

+ (instancetype)itemWithKey:(NSString *)key storyboardID:(NSString *)storyboardID aliases:(NSArray *)aliases dependencies:(NSArray *)dependencies {
	return [self itemWithKey:key storyboardID:storyboardID aliases:aliases dependencies:dependencies attributes:nil];
}

+ (instancetype)itemWithKey:(NSString *)key storyboardID:(NSString *)storyboardID attributes:(NSDictionary *)attributes {
	return [self itemWithKey:key storyboardID:storyboardID aliases:nil dependencies:nil attributes:attributes];
}

+ (instancetype)itemWithKey:(NSString *)key storyboardID:(NSString *)storyboardID aliases:(NSArray *)aliases attributes:(NSDictionary *)attributes {
	return [self itemWithKey:key storyboardID:storyboardID aliases:aliases dependencies:nil attributes:attributes];
}

+ (instancetype)itemWithKey:(NSString *)key storyboardID:(NSString *)storyboardID dependencies:(NSArray *)dependencies attributes:(NSDictionary *)attributes {
	return [self itemWithKey:key storyboardID:storyboardID aliases:nil dependencies:dependencies attributes:attributes];
}

+ (instancetype)itemWithKey:(NSString *)key storyboardID:(NSString *)storyboardID aliases:(NSArray *)aliases dependencies:(NSArray *)dependencies attributes:(NSDictionary *)attributes {
	return [[KSRouterItem alloc] initWithKey:key storyboardID:storyboardID aliases:aliases dependencies:dependencies attributes:attributes];
}

- (instancetype)initWithKey:(NSString *)key storyboardID:(NSString *)storyboardID aliases:(NSArray *)aliases dependencies:(NSArray *)dependencies attributes:(NSDictionary *)attributes {
	if (self = [super init]) {
		if (key == nil) {
			key = storyboardID;
		}

		NSCParameterAssert(key != nil && ((NSString *)key).length > 0);
		NSCParameterAssert(storyboardID != nil && storyboardID.length > 0);
		
		_key           = [key copy];
		_storyboardID  = [storyboardID copy];
		_aliases       = [aliases copy];
		_dependencies  = [dependencies copy];
		_attributes    = [attributes copy];
	}
	return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"{%@, sid:%@, alias:%@, dep:%@, attr:%@}", self.key, self.storyboardID, self.aliases, self.dependencies, self.attributes];
}

@end
