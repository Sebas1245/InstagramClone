//
//  PostCell.m
//  InstagramClone
//
//  Created by Sebastian Saldana Cardenas on 07/07/21.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
    self.cellCaption.text = post[@"caption"];
    self.cellUsername.text = post[@"author"][@"username"];
    self.cellImage.file = post[@"image"];
    [self.cellImage loadInBackground];
    self.cellProfilePicture.layer.cornerRadius = self.cellProfilePicture.frame.size.width/2;
    if(post[@"author"][@"profilePicture"]) {
        self.cellProfilePicture.file = post[@"author"][@"profilePicture"];
        [self.cellProfilePicture loadInBackground];
    } else {
        UIImage *placeHolderImg = [UIImage imageNamed:@"image_placeholder"];
        [self.cellProfilePicture setImage:placeHolderImg];
    }
}

@end
