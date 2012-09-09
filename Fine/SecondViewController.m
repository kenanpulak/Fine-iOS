//
//  SecondViewController.m
//  Fine
//
//  Created by Austin Marusco on 9/8/12.
//  Copyright (c) 2012 Kenan Pulak. All rights reserved.
//

#import "SecondViewController.h"


@implementation SecondViewController
@synthesize savePhoto;

@synthesize enterStatus;
@synthesize imageView;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
   self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:242.0f/255.0f green:109.0f/255.0f blue:162.0f/255.0f alpha:1.0f];
    self.navigationController.navigationBar.topItem.title = @"Barto";
    
    self.enterStatus.delegate = self;
    
    [[self.upButton layer] setBorderWidth:2.0f];
    [[self.upButton layer] setBorderColor:[UIColor blackColor].CGColor];
    
    [[self.downButton layer] setBorderWidth:2.0f];
    [[self.downButton layer] setBorderColor:[UIColor blackColor].CGColor];
    
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
}

- (void)viewDidUnload
{
    [self setSavePhoto:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

# pragma mark TextView Methods

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ( [text isEqualToString:@"\n"] ) {
        [textView resignFirstResponder];
    }
    return YES;
}
# pragma mark Button Methods

-(IBAction)upButtonPressed:(id)sender
{
    
}

-(IBAction)downButtonPressed:(id)sender
{
    
}

-(IBAction)doneButtonPressed:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:@"Burrito Rated!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    
    [alertView show];
    
}

-(IBAction)saveButtonPressed:(id)sender{
    
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] linkFromController:self];
    }
    
    NSString *localPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSString *filename = @"Info.plist";
    NSString *destDir = @"/";
    [[self restClient] uploadFile:filename toPath:destDir
                    withParentRev:nil fromPath:localPath];
    
    
}



-(IBAction)takePhotoButtonPressed:(id)sender
{
    [self presentModalViewController:imagePickerController animated:YES];
}

# pragma mark Image Methods

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [picker dismissModalViewControllerAnimated:YES];
    imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];

    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.hidden = NO;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissModalViewControllerAnimated:YES];
}

- (DBRestClient *)restClient {
    if (!restClient) {
        restClient =
        [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
    return restClient;
}



@end
