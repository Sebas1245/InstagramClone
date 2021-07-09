//
//  HomeFeedViewController.m
//  InstagramClone
//
//  Created by Sebastian Saldana Cardenas on 06/07/21.
//

#import "HomeFeedViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "SceneDelegate.h"
#import "PostCell.h"
#import "Post.h"
#import "ComposeViewController.h"
#import "DetailViewController.h"
#import "Alert.h"

@interface HomeFeedViewController () <UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *posts;
@property (strong,nonatomic)  UIRefreshControl *refreshControl;

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.refreshControl = [[UIRefreshControl alloc] init];
    // fetch posts from Parse backend
    [self fetchPosts];
    // begin animation for refresh control
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    // place refresh control into table view
    [self.tableView addSubview:self.refreshControl];
}
- (IBAction)handleLogout:(id)sender {
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    myDelegate.window.rootViewController = loginViewController;
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        [self dismissViewControllerAnimated:false completion:nil];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.row];
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
            [self.tableView reloadData];
        }
        [self.refreshControl endRefreshing];
    }];
}

-(void)didPost {
    [self fetchPosts];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"DetailSegue"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *detailPost = self.posts[indexPath.row];
        DetailViewController *postDetailVC = [segue destinationViewController];
        postDetailVC.post = detailPost;
        
    } else {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController  *composeController = (ComposeViewController*) navigationController.topViewController;
        composeController.delegate = self;
    }
    
}



@end
