//
//  OTSCollectionViewCell.m
//  autolayout fun
//
//  Created by otiose on 7/13/14.
//  Copyright (c) 2014 otiose. All rights reserved.
//

#import "OTSCollectionViewCell.h"

@implementation OTSCollectionViewCell

- (void)configureWithTitle:(NSString *)title text:(NSString *)text {
    self.titleLabel.text = title;
    self.textLabel.text = text;

    self.titleLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.bounds) - 20;
    self.textLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.bounds) - 20;

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];

    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
