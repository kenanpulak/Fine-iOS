//
//  SecondViewController.h
//  Fine
//
//  Created by Austin Marusco on 9/8/12.
//  Copyright (c) 2012 Kenan Pulak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController* imagePickerController;
}

@property(strong, nonatomic) IBOutlet UITextView *enterStatus;
@property(strong, nonatomic) IBOutlet UIImageView *imageView;

@property(strong, nonatomic) IBOutlet UIButton *upButton;
@property(strong, nonatomic) IBOutlet UIButton *downButton;

-(IBAction)upButtonPressed:(id)sender;
-(IBAction)downButtonPressed:(id)sender;
-(IBAction)takePhotoButtonPressed:(id)sender;
-(IBAction)doneButtonPressed:(id)sender;

@end
