//
//  DetailViewController.h
//  InstagramClone
//
//  Created by Sebastian Saldana Cardenas on 07/07/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (weak,nonatomic) Post *post;
@end

NS_ASSUME_NONNULL_END
