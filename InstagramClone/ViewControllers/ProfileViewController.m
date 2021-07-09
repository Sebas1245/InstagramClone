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
    self.profileImageView.layer.cornerRadius  = (self.profileImageView.frame.size.width/2);
    
}


- (IBAction)editProfile:(id)sender {
    
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
