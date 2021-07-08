//
//  Alert.m
//  InstagramClone
//
//  Created by Sebastian Saldana Cardenas on 08/07/21.
//

#import "Alert.h"

@implementation Alert

-(void) showAlertWithMessage:(NSString*)message viewController:(UIViewController*)viewController {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Try again" style:UIAlertActionStyleDefault handler:nil];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    // show alert
    [viewController presentViewController:alert animated:true completion:nil];
}

@end
