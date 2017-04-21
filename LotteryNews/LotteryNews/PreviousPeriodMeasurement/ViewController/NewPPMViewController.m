//
//  NewPPMViewController.m
//  LotteryNews
//
//  Created by 邹壮壮 on 2017/4/19.
//  Copyright © 2017年 邹壮壮. All rights reserved.
//

#import "NewPPMViewController.h"
#import "LNScrollerView.h"
#import "PPMNewRankListView.h"
#import "UserStore.h"
#import "TriolionTopAdModel.h"
#import "LottoryTypeView.h"
#import "PPMViewController.h"
#import "PersonalHomePageViewController.h"
#import "LoginViewController.h"
#import "LNLottoryConfig.h"
@interface NewPPMViewController ()<LottoryTypeViewDelegate,LNScrollerViewDelegate,PPMNewRankListViewDelegate>
@property (strong, nonatomic)  LNScrollerView *topAdScrollerView;
@property (strong, nonatomic)  LottoryTypeView *lottoryTypeView;
@property (strong, nonatomic)  PPMNewRankListView *recommendView;

@property (nonatomic, strong)NSMutableArray *topAdArray;
@end

@implementation NewPPMViewController
- (NSMutableArray *)topAdArray{
    if (_topAdArray == nil) {
        _topAdArray = [NSMutableArray array];
    }
    return _topAdArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self getTopAD];
    [self rankList];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initUI{
    _topAdScrollerView = [[LNScrollerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    _topAdScrollerView.delegate = self;
    [self.view addSubview:_topAdScrollerView];
    
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_topAdScrollerView.frame), kScreenWidth, 40)];
    [self.view addSubview:centerView];
    
    UILabel *lable1 = [self create:@"彩票种类"];
    lable1.textAlignment = NSTextAlignmentLeft;
    [centerView addSubview:lable1];
    [lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(centerView.mas_left).with.offset(8);
        make.centerY.mas_equalTo(centerView.mas_centerY);
    }];
    UIView *view1 = [[UIView alloc]init];
    [centerView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(centerView);
        make.width.mas_equalTo(kScreenWidth/2);
        make.height.mas_equalTo(centerView.mas_height);
    }];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction1)];
    [view1 addGestureRecognizer:tap1];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, 5, 1, 30)];
    line.backgroundColor = [UIColor grayColor];
    [centerView addSubview:line];
    
    UILabel *lable2 = [self create:@"推荐专家"];
    lable2.textAlignment = NSTextAlignmentRight;
    [centerView addSubview:lable2];
    [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(centerView.mas_right).with.offset(-8);
        make.centerY.mas_equalTo(centerView.mas_centerY);
    }];
    
    UIView *view2 = [[UIView alloc]init];
    [centerView addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(centerView);
        make.width.mas_equalTo(kScreenWidth/2);
        make.height.mas_equalTo(centerView.mas_height);
    }];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction2)];
    [view2 addGestureRecognizer:tap2];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.tag = 1001;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(centerView.mas_bottom);
    }];
    _lottoryTypeView = [[LottoryTypeView alloc]init];
    _lottoryTypeView.delegate = self;
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [_lottoryTypeView addGestureRecognizer:panGes];
    [bottomView addSubview:_lottoryTypeView];
    [_lottoryTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(bottomView);
        make.width.mas_equalTo(kScreenWidth/2);
        make.height.mas_equalTo(bottomView.mas_height);
    }];
    _recommendView = [[PPMNewRankListView alloc]init];
    _recommendView.rankListViewdelegate = self;
    [bottomView addSubview:_recommendView];
    [_recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(bottomView);
        make.width.mas_equalTo(kScreenWidth/2);
        make.height.mas_equalTo(bottomView.mas_height);
    }];
    
}
- (UILabel *)create:(NSString *)text{
    UILabel *lable = [[UILabel alloc]init];
    lable.text = text;
    lable.textColor = [UIColor grayColor];
    lable.font = [UIFont systemFontOfSize:16];
    [lable sizeToFit];
    return lable;
}

- (void)tapAction1{
    UIView *bottomView = [self.view viewWithTag:1001];
    [bottomView bringSubviewToFront:_lottoryTypeView];
    [UIView animateWithDuration:0.5 animations:^{
        self.lottoryTypeView.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(_lottoryTypeView.frame));
    } completion:^(BOOL finished) {
        
    }];
}
- (void)tapAction2{
    UIView *bottomView = [self.view viewWithTag:1001];
    [bottomView bringSubviewToFront:_lottoryTypeView];
    [UIView animateWithDuration:0.5 animations:^{
        _lottoryTypeView.frame = CGRectMake(0, 0, kScreenWidth/2, CGRectGetHeight(_lottoryTypeView.frame));
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)panAction:(UIPanGestureRecognizer *)panGesture{
   
    
    UIView *bottomView = [self.view viewWithTag:1001];
    [bottomView bringSubviewToFront:_lottoryTypeView];
    CGPoint point = [panGesture translationInView:_lottoryTypeView];
    
   
    CGFloat frame_w;
    CGFloat frame_h = _lottoryTypeView.frame.size.height;
   
    frame_w = _lottoryTypeView.frame.size.width;
   
    frame_w +=point.x;
    panGesture.view.frame = CGRectMake(0, 0, frame_w, frame_h);
    
        if (frame_w>kScreenWidth/4*3) {
            NSLog(@"0");
            frame_w = kScreenWidth;
            [UIView animateWithDuration:0.5 animations:^{
                _lottoryTypeView.frame = CGRectMake(0, 0, frame_w, frame_h);;
            } completion:^(BOOL finished) {
                
            }];
        }
        if(frame_w<=kScreenWidth/2){
            NSLog(@"1");
            frame_w = kScreenWidth/2;
            [UIView animateWithDuration:0.5 animations:^{
                _lottoryTypeView.frame = CGRectMake(0, 0, frame_w, frame_h);
            } completion:^(BOOL finished) {
                
            }];
       
 
    }
    
    
}
- (void)getTopAD{
    [[UserStore sharedInstance]topAdSucess:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *top_ad_arr = [responseObject objectForKey:@"top_ad"];
        if (top_ad_arr.count > 0) {
            if (self.topAdArray.count > 0) {
                [_topAdArray removeAllObjects];
            }
        }
        for (NSDictionary *dict in top_ad_arr) {
            TriolionTopAdModel *model = [[TriolionTopAdModel alloc]initWithDictionary:dict error:nil];
            [self.topAdArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_topAdArray.count>0) {
                _topAdScrollerView.imageArray = _topAdArray;
            }
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)rankList{
    NSDictionary *dict = @{@"playtype":@"1039",@"caipiaoid":@"1001",@"jisu_api_id":@"11"};
    kWeakSelf(self);
    
    [[UserStore sharedInstance]expert_rank:dict sucess:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        NSNumber *codeNum = [responseObject objectForKey:@"code"];
        NSInteger code= [codeNum integerValue];
        NSMutableArray *array = [NSMutableArray array];
        if (code == 1) {
            NSArray *datas = [responseObject objectForKey:@"data"];
            if (datas.count > 0) {
                
                for (NSDictionary *dict in datas) {
                    RankListModel *model = [[RankListModel alloc]initWithDictionary:dict error:nil];
                    [array addObject:model];
                }
            }
            
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (array.count > 0) {
              weakself.recommendView.rankListArr = array;
            }
            
          
        });
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
//LottoryTypeViewDelegate
- (void)clickLottory{
    PPMViewController *pp = [[PPMViewController alloc]init];
    pp.hidesBottomBarWhenPushed = YES;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:pp animated:YES];
}
//LNScrollerViewDelegate
- (void)LNScrollerViewDidClicked:(NSUInteger)index{
    TriolionTopAdModel *model = [_topAdArray objectAtIndex:index];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:model.link]];
}
- (void)selectedImageView:(RankListModel *)model{
    NSString *userID = UserDefaultObjectForKey(LOTTORY_AUTHORIZATION_UID);
    if (userID) {
        PersonalHomePageViewController *personalHomeVC = [[PersonalHomePageViewController alloc]init];
        personalHomeVC.expert_id = model.expert_id;
        personalHomeVC.nickname = model.nickname;
        personalHomeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController pushViewController:personalHomeVC animated:YES];
    }else{
        [self presentViewController:[[LoginViewController alloc]init] animated:YES completion:nil];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
