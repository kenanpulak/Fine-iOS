//
//  Product.m
//  Fine
//
//  Created by Kenan Pulak on 9/8/12.
//  Copyright (c) 2012 Kenan Pulak. All rights reserved.
//

#import "Product.h"

@implementation Product

@synthesize type, name, imageName, restaurantName, price, numLikes;


+ (id)productWithType:(NSString *)type name:(NSString *)name imageName:(NSString *)imageName restaurantName:(NSString*)restaurantName price:(NSString*)price numLikes:(NSString*)numLikes
{
	Product *newProduct = [[self alloc] init];
	newProduct.type = type;
	newProduct.name = name;
    newProduct.imageName = imageName;
    newProduct.restaurantName = restaurantName;
    newProduct.price = price;
    newProduct.numLikes = numLikes;
    
	return newProduct;
}


@end
