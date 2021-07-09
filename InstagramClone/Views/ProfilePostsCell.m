//
//  ProfilePostsCell.m
//  InstagramClone
//
//  Created by Sebastian Saldana Cardenas on 09/07/21.
//

#import "ProfilePostsCell.h"

@implementation ProfilePostsCell

- (void)setPost:(Post *)post {
    _post = post;
    self.postCellImage.file = post[@"image"];
    [self.postCellImage loadInBackground];
}

@end
