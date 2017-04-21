//
//  LottoryTypeView.m
//  LotteryNews
//
//  Created by 邹壮壮 on 2017/4/19.
//  Copyright © 2017年 邹壮壮. All rights reserved.
//

#import "LottoryTypeView.h"
#import "TriolionNewCenterView.h"
#import "TLottoryTypeViewCell.h"
@interface LottoryTypeView ()<UITableViewDelegate,UITableViewDataSource,TriolionNewCenterViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TriolionNewCenterView *collectionView;
@property (nonatomic, strong) NSArray *shareAry;
@end

NSString *const TLottoryTypeViewCellIdentifier = @"TLottoryTypeViewCellIdentifier";
@implementation LottoryTypeView

- (instancetype)init{
    self = [super init];
    if (self) {
      _shareAry = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"qiu" ofType:@"plist"]];
        [self addSubview:self.tableView];
        
        [self addSubview:self.collectionView];
        [_collectionView initShareAry:_shareAry];
        
    }
    return self;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        [_tableView registerNib:[UINib nibWithNibName:@"TLottoryTypeViewCell" bundle:nil] forCellReuseIdentifier:TLottoryTypeViewCellIdentifier];
    }
    return _tableView;
}
- (TriolionNewCenterView *)collectionView{
    if (_collectionView == nil) {
        _collectionView = [[TriolionNewCenterView alloc]init];
        _collectionView.hidden = YES;
        _collectionView.delegate = self;
    }
    return _collectionView;
}
- (void)setFrame:(CGRect)frame{
   
    if (frame.size.width <= kScreenWidth/2) {
        _tableView.frame = frame;
        _collectionView.hidden= YES;
        _tableView.hidden = NO;
       
    }else{
        _collectionView.frame = frame;
        _collectionView.hidden = NO;
        _tableView.hidden = YES;
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _tableView.frame = self.frame;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _shareAry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TLottoryTypeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TLottoryTypeViewCellIdentifier];
    NSDictionary *dict = [_shareAry objectAtIndex:indexPath.row];
    [cell setdict:dict];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate &&[_delegate respondsToSelector:@selector(clickLottory)]) {
        [_delegate clickLottory];
    }
}
- (void)clickLottory:(NSInteger)didSelectIndex{
    if (_delegate &&[_delegate respondsToSelector:@selector(clickLottory)]) {
        [_delegate clickLottory];
    }
}
@end
