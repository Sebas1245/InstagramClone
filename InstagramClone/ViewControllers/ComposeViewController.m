//
//  ComposeViewController.m
//  InstagramClone
//
//  Created by Sebastian Saldana Cardenas on 06/07/21.
//

#import "ComposeViewController.h"
#include "Post.h"

@interface ComposeViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ComposeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.delegate = self;
    self.textView.text = @"Write a caption";
    self.textView.textColor = [UIColor lightGrayColor]; //optional
    
}

- (IBAction)tappedOnImage:(id)sender {
    [self renderImagePicker];
}

-(void)renderImagePicker {
    // set up image picker
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = true;
    
    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"Write a caption"]) {
         textView.text = @"";
         textView.textColor = [UIColor labelColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Write a caption";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    if(editedImage) {
        [self.imageView setImage:editedImage];
    } else {
        [self.imageView setImage:originalImage];
    }
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)cancelCompose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)shareImage:(id)sender {
    if (![self.textView.text isEqualToString:@""]) {
        CGSize size = CGSizeMake(300, 300);
        UIImage *uploadImage = [self resizeImage:self.imageView.image withSize:size];
        [Post postUserImage:uploadImage withCaption:self.textView.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                // show home timeline again and reload table data
                [self.delegate didPost];
                NSLog(@"Image uploaded succesfully!");
                [self dismissViewControllerAnimated:true completion:nil];
            } else {
                // alert the error
                NSLog(@"Error uploading image");
            }
        }];
    } else {
        // throw an alert
        NSLog(@"Caption cannot be empty");
    }
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
