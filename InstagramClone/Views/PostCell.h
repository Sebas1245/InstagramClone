//
//  PostCell.h
//  InstagramClone
//
//  Created by Sebastian Saldana Cardenas on 07/07/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *cellCaption;

@end

NS_ASSUME_NONNULL_END
