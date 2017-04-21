//
//  TLottoryTypeViewCell.m
//  LotteryNews
//
//  Created by 邹壮壮 on 2017/4/19.
//  Copyright © 2017年 邹壮壮. All rights reserved.
//

#import "TLottoryTypeViewCell.h"

@interface TLottoryTypeViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UIImageView *lottoryImageView;

@end
@implementation TLottoryTypeViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setdict:(NSDictionary *)dict{
    NSString *imageName = [dict objectForKey:@"image"];
    NSString *title = [dict objectForKey:@"title"];
    _lottoryImageView.image = [UIImage imageNamed:imageName];
    _nameLable.text = title;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
