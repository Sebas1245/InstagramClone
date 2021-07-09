//
//  ProfileViewController.m
//  InstagramClone
//
//  Created by Sebastian Saldana Cardenas on 09/07/21.
//

#import "ProfileViewController.h"
#import <Parse/PFImageView.h>
#import "ProfilePostsCell.h"
#import "Post.h"
#import "Alert.h"
#import <QuartzCore/QuartzCore.h>

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet PFImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileUsernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *profileEditButton;
@property (weak, nonatomic) IBOutlet UICollectionView *postsCollectionView;
@property (strong, nonatomic) NSArray *posts;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.postsCollectionView.delegate = self;
    self.postsCollectionView.dataSource = self;
    [self styleUIElements];
    [self fetchPosts];
    [self setDataForProfile];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.postsCollectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 2;
    CGFloat postsPerLine = 3;
    CGFloat itemWidth = (self.postsCollectionView.frame.size.width - layout.minimumInteritemSpacing * (postsPerLine-1)) / postsPerLine;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProfilePostsCell *cell = [self.postsCollectionView dequeueReusableCellWithReuseIdentifier:@"ProfilePostsCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.item];
    cell.post = post;
    return cell;
}

-(void)fetchPosts {
    [Post getPostsFromDBWithCompletion:^(NSArray * _Nonnull posts, NSError * _Nonnull error) {
        if(error) {
            NSString *errorMsg = [NSString stringWithFormat:@"There was an error fetching posts: %@", error.localizedDescription];
            [[Alert new] showAlertWithMessage:errorMsg viewController:self];
        } else {
            self.posts = posts;
            [self.postsCollectionView reloadData];
        }
    }];
}

-(void)setDataForProfile {
    PFUser *currentUser = [PFUser currentUser];
    self.profileUsernameLabel.text = currentUser.username;
    NSLog(@"%@", currentUser);
    self.profileImageView.file = currentUser[@"profilePicture"];
    [self.profileImageView loadInBackground];
}

-(void)styleUIElements {
    self.profileEditButton.layer.borderWidth = 1.0f;
    self.profileEditButton.layer.borderColor = [[UIColor labelColor] CGColor];
    self.profileEditButton.layer.cornerRadius = 12;
    self.profileImageView.layer.cornerRadius  = self.profileImageView.frame.size.width/2;
    
}


- (IBAction)editProfile:(id)sender {
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
    } else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    if (editedImage) {
        [self.profileImageView setImage:editedImage];
    } else {
        [self.profileImageView setImage:originalImage];
    }
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        CGSize size = CGSizeMake(300, 300);
        UIImage *uploadImage = [self resizeImage:self.profileImageView.image withSize:size];
        currentUser[@"profilePicture"] = [Post getPFFileFromImage:uploadImage];
        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if(succeeded) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                NSString *errorMsg = [NSString stringWithFormat:@"Error updating profile image: %@", error.localizedDescription];
                [[Alert new] showAlertWithMessage:errorMsg viewController:self];
            }
        }];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
