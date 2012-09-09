//
//  Product.h
//  Fine
//
//  Created by Kenan Pulak on 9/8/12.
//  Copyright (c) 2012 Kenan Pulak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject {
	NSString *type;
	NSString *name;
}

@property (nonatomic, copy) NSString *type, *name;

+ (id)productWithType:(NSString *)type name:(NSString *)name;

@end
