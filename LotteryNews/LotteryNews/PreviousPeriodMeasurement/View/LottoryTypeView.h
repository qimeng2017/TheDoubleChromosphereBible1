//
//  LottoryTypeView.h
//  LotteryNews
//
//  Created by 邹壮壮 on 2017/4/19.
//  Copyright © 2017年 邹壮壮. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LottoryTypeViewDelegate <NSObject>

- (void)clickLottory;

@end
@interface LottoryTypeView : UIView
@property (nonatomic, weak)id<LottoryTypeViewDelegate>delegate;
@end
