//
//  ProfilePostsCell.h
//  InstagramClone
//
//  Created by Sebastian Saldana Cardenas on 09/07/21.
//

#import <UIKit/UIKit.h>
#import <Parse/PFImageView.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfilePostsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postCellImage;
@property (strong,nonatomic) Post *post;
@end

NS_ASSUME_NONNULL_END
