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
                
                make.insert(@"@迷你世界联机 :@江叔 用小淘气耍赖野人#迷你世界#. #精选#看到最后!! [点赞][评论][转发]", 0);
                
                make.font([UIFont boldSystemFontOfSize:17]);
                make.regexp(@"[@][^\\s]+\\s", ^(SJAttributesRangeOperator * _Nonnull matched) {
                    matched.textColor([UIColor purpleColor]);
                });
                make.regexp(@"[#][^#]+#", ^(SJAttributesRangeOperator * _Nonnull matched) {
                    matched.textColor([UIColor orangeColor]);
                });
                make.regexp(@"[\\[][^\\]]+\\]", ^(SJAttributesRangeOperator * _Nonnull matched) {
                    matched.textColor([UIColor greenColor]);
                });

            });
            
            
            // add action
            attrStr.actionDelegate = self;

            // action
            attrStr.addAction(@"([@][^\\s]+\\s)|([#][^#]+#)|([\\[][^\\]]+\\])");

            SJLabelHelper *helper = [SJLabelHelper helperWithAttributedStr:attrStr maxWidth:[SJTableViewCell ContentMaxWidth] numberOfLines:0];
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
