//
//  Product.m
//  Fine
//
//  Created by Kenan Pulak on 9/8/12.
//  Copyright (c) 2012 Kenan Pulak. All rights reserved.
//

#import "Product.h"

#import "Product.h"

@implementation Product

@synthesize type, name;


+ (id)productWithType:(NSString *)type name:(NSString *)name
{
	Product *newProduct = [[self alloc] init];
	newProduct.type = type;
	newProduct.name = name;
	return newProduct;
}


@end
