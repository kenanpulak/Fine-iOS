//
//  SecondViewController.h
//  Fine
//
//  Created by Austin Marusco on 9/8/12.
//  Copyright (c) 2012 Kenan Pulak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SecondViewController : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController* imagePickerController;
    DBRestClient *restClient;
}

@property(strong, nonatomic) IBOutlet UITextView *enterStatus;
@property(strong, nonatomic) IBOutlet UIImageView *imageView;

@property(strong, nonatomic) IBOutlet UIButton *upButton;
@property(strong, nonatomic) IBOutlet UIButton *downButton;
@property (weak, nonatomic) IBOutlet UIButton *savePhoto;

-(IBAction)upButtonPressed:(id)sender;
-(IBAction)downButtonPressed:(id)sender;
-(IBAction)takePhotoButtonPressed:(id)sender;
-(IBAction)doneButtonPressed:(id)sender;
-(IBAction)saveButtonPressed:(id)sender;

@end
