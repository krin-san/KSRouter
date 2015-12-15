//
//  UIViewController+Router.m
//  Copyright (c) 2015 Krin-San. All rights reserved.
//

#import "UIViewController+Router.h"


@implementation UIViewController (Router)

- (void)fillRouterAttributes:(NSDictionary *)attributes {
	for (NSString *key in [attributes allKeys]) {
		[self setValue:attributes[key] forKeyPath:key];
	}
}

@end
