//
//  OTSCollectionViewCell.h
//  autolayout fun
//
//  Created by otiose on 7/13/14.
//  Copyright (c) 2014 otiose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTSCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

- (void)configureWithTitle:(NSString *)title text:(NSString *)text;

@end
