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

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.detailAuthorLabel.text = self.post[@"author"][@"username"];
    self.detailCaptionLabel.text = self.post[@"caption"];
    self.detailImageView.file = self.post[@"image"];
    [self.detailImageView loadInBackground];
    NSLog(@"%@", self.post.createdAt);
    NSDate *createdAt = self.post.createdAt;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEE, MMM d, h:mm a"];
    self.detailDateLabel.text = [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:createdAt]];
}

//- (void)setPost:(Post *)post {
//    _post = post;
//    self.detailAuthorLabel.text = post[@"author"];
//    self.detailCaptionLabel.text = post[@"caption"];
//    self.detailDateLabel.text = post[@"createdAt"];
//    self.detailImageView.file = post[@"image"];
//    [self.detailImageView loadInBackground];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
