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
    NSString *imageName;
    NSString *restaurantName;
    NSString *price;
    NSString *numLikes;
    
}

@property (nonatomic, copy) NSString *type, *name, *imageName, *restaurantName, *price, *numLikes;

+ (id)productWithType:(NSString *)type name:(NSString *)name imageName:(NSString *)imageName restaurantName:(NSString*)restaurantName price:(NSString*)price numLikes:(NSString*)numLikes;

@end
