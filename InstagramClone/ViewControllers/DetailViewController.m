//
//  DetailViewController.m
//  InstagramClone
//
//  Created by Sebastian Saldana Cardenas on 07/07/21.
//

#import "DetailViewController.h"
#import <Parse/PFImageView.h>

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *detailAuthorLabel;
@property (weak, nonatomic) IBOutlet PFImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailCaptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailDateLabel;
@property (weak, nonatomic) IBOutlet PFImageView *detailProfileImageView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.detailProfileImageView.layer.cornerRadius = self.detailProfileImageView.frame.size.width/2;
    if(self.post[@"author"][@"profilePicture"]) {
        self.detailProfileImageView.file = self.post[@"author"][@"profilePicture"];
        [self.detailProfileImageView loadInBackground];
    } else {
        NSLog(@"%@", self.post[@"author"][@"username"]);
        UIImage *placeHolderImg = [UIImage imageNamed:@"image_placeholder"];
        [self.detailProfileImageView setImage:placeHolderImg];
    }
    self.detailAuthorLabel.text = self.post[@"author"][@"username"];
    self.detailCaptionLabel.text = self.post[@"caption"];
    self.detailImageView.file = self.post[@"image"];
    [self.detailImageView loadInBackground];
    NSDate *createdAt = self.post.createdAt;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEE, MMM d, h:mm a"];
    self.detailDateLabel.text = [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:createdAt]];
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
