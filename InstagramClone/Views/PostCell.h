//
//  PostCell.h
//  InstagramClone
//
//  Created by Sebastian Saldana Cardenas on 07/07/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/PFImageView.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *cellCaption;
@property (weak, nonatomic) IBOutlet UILabel *cellUsername;
@property (weak, nonatomic) IBOutlet PFImageView *cellProfilePicture;
@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
