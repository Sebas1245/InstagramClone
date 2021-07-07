//
//  ComposeViewController.h
//  InstagramClone
//
//  Created by Sebastian Saldana Cardenas on 06/07/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol  ComposeViewControllerDelegate <NSObject>

-(void)didPost; // add a post parameter later to add it in HomeFeedVC to not make another network call

@end

@interface ComposeViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak,nonatomic) id<ComposeViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
