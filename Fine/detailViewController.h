//
//  detailViewController.h
//  Fine
//
//  Created by Kenan Pulak on 9/8/12.
//  Copyright (c) 2012 Kenan Pulak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *price;

@property (strong, nonatomic) IBOutlet UILabel *restaurantName;
@property (strong, nonatomic) IBOutlet UILabel *numLikes;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end
