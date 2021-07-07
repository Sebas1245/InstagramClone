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
    self.cellImage.file = post[@"image"];
    [self.cellImage loadInBackground];
}

@end
