//
//  Alert.h
//  InstagramClone
//
//  Created by Sebastian Saldana Cardenas on 08/07/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Alert : NSObject
-(void) showAlertWithMessage:(NSString*) message viewController:(UIViewController*)viewController;
@end

NS_ASSUME_NONNULL_END
