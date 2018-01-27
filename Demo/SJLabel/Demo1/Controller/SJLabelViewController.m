//
//  SJLabelViewController.m
//  SJAttributesFactory
//
//  Created by BlueDancer on 2017/12/14.
//  Copyright © 2017年 畅三江. All rights reserved.
//

#import "SJLabelViewController.h"
#import "SJTableViewCell.h"
#import <Masonry.h>
#import "SJCTFrameParserConfig.h"
#import "SJCTData.h"
#import "SJLabelHelper.h"
#import <SJUIFactory/SJUIFactory.h>
#import <SJAttributesFactory/SJAttributeWorker.h>
#import "SJLabel.h"
#import "NSMutableAttributedString+ActionDelegate.h"

static NSString *const __TestString =  @"我被班主任😆杨老师叫#dsf$AXXBC$S#SFS到办公室，当时上课铃刚响，杨老师S#SFS过来找我，我挺奇怪的，什么事(ˇˍˇ) 想～啊，可以连课都不上？当时办公室里就我S#SFS们两个人S#SFS。杨老师拿出😓手机，让我看她拍的一张照片，是S#SFS我们班最近一次ASdsdsa班级活动时照的。我们仨S#SFS坐在一张椅子上，我坐在中间，皱着个眉头，小喵托着腮帮子，小桐则靠着椅背坐着。";

static NSString *SJTableViewCellID = @"SJTableViewCell";

@interface SJLabelViewController ()<NSAttributedStringActionDelegate>

@property (nonatomic, strong, readonly) NSArray<SJLabelHelper *> *helpers;

@end

@implementation SJLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:NSClassFromString(SJTableViewCellID) forCellReuseIdentifier:SJTableViewCellID];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSMutableArray<SJLabelHelper *> *helpersM = [NSMutableArray array];
        for ( int i = 0 ; i < 99 ; i ++ ) {
            
            // create attributes
            NSMutableAttributedString *attrStr = sj_makeAttributesString(^(SJAttributeWorker * _Nonnull make) {
                make.font([UIFont boldSystemFontOfSize:22]).lineSpacing(0);
                make.insertText([__TestString substringToIndex:arc4random() % __TestString.length], 0);
                make.regexp(@"我们", ^(SJAttributesRangeOperator * _Nonnull matched) {
                    // 将匹配到的`我们`高亮显示
                    matched.textColor([UIColor orangeColor]);
                    matched.underLine(NSUnderlineStyleSingle, [UIColor orangeColor]);
                });
                make.insert(@"[活动链接]", -1);
                make.lastInserted(^(SJAttributesRangeOperator * _Nonnull lastOperator) {
                    lastOperator.textColor([UIColor blueColor]).underLine(NSUnderlineStyleSingle, [UIColor colorWithWhite:0.6 alpha:1]);
                });
            });
            
            
            // add action
            attrStr.actionDelegate = self;
            attrStr.addAction(@"我们");    // 所有的`我们`添加点击事件, 回调将在代理方法中回调.
            attrStr.addAction(@"[活动链接]"); // 所有的`[活动链接]`添加点击事件, 回调将在代理方法中回调.
            
            
            SJLabelHelper *helper = [SJLabelHelper helperWithAttributedStr:attrStr maxWidth:[SJTableViewCell ContentMaxWidth] numberOfLines:0 lineSpacing:8];
            // add to container
            [helpersM addObject:helper];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // set helpers
            _helpers = helpersM;

            // update UI
            [self.tableView reloadData];
        });

    });
    
    
    // Do any additional setup after loading the view.
}

#pragma mark - NSAttributedStringActionDelegate

- (void)attributedString:(NSAttributedString *)attrStr action:(NSAttributedString *)action {
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor =  [UIColor colorWithRed:arc4random() % 256 / 255.0
                                               green:arc4random() % 256 / 255.0
                                                blue:arc4random() % 256 / 255.0
                                               alpha:1];
    vc.title = action.string;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _helpers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SJTableViewCell *cell = (SJTableViewCell *)[tableView dequeueReusableCellWithIdentifier:SJTableViewCellID forIndexPath:indexPath];
    cell.helper = _helpers[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = _helpers[indexPath.row].drawData.height;
    
    return [SJTableViewCell heightWithContentH:height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%zd - %s", __LINE__, __func__);
}

@end
