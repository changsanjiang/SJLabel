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
#import "SJAttributesFactoryHeader.h"
#import "SJCTFrameParserConfig.h"
#import "SJCTData.h"
#import "SJLabelHelper.h"
#import <SJUIFactory/SJUIFactory.h>

static NSString *const __TestString =  @"我被班主任😆杨老师叫#dsf$AXXBC$S#SFS到办公室，当时上课铃刚响，杨老师S#SFS过来找我，我挺奇怪的，什么事(ˇˍˇ) 想～啊，可以连课都不上？当时办公室里就我S#SFS们两个人S#SFS。杨老师拿出😓手机，让我看她拍的一张照片，是S#SFS我们班最近一次ASdsdsa班级活动时照的。我们仨S#SFS坐在一张椅子上，我坐在中间，皱着个眉头，小喵托着腮帮子，小桐则靠着椅背坐着。";

static NSString *SJTableViewCellID = @"SJTableViewCell";

@interface SJLabelViewController ()

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
            __weak typeof(self) _self = self;
            // create helper
            SJLabelHelper *helper = [SJLabelHelper helperWithAttributedStr:[SJAttributesFactory producingWithTask:^(SJAttributeWorker * _Nonnull worker) {
                
//                 insert Text String
                worker.insertText([__TestString substringToIndex:arc4random() % __TestString.length], 0).font([UIFont boldSystemFontOfSize:22]).lineSpacing(0);

                worker.insertImage([UIImage imageNamed:@"sample2"], 10, CGPointZero, CGSizeMake(30, 30));
                worker.insertImage([UIImage imageNamed:@"sample2"], 30, CGPointZero, CGSizeMake(10, 10));
                worker.insertImage([UIImage imageNamed:@"sample2"], 60, CGPointZero, CGSizeMake(20, 20));
                worker.insertImage([UIImage imageNamed:@"sample2"], 70, CGPointMake(0, 0), CGSizeMake(50, 50));
                
                // 匹配所有 `我们`
                worker.regexp(@"我们", ^(SJAttributeWorker * _Nonnull regexp) {
                    regexp.nextFontColor([UIColor orangeColor]);
                    regexp.nextUnderline(NSUnderlineStyleSingle, [UIColor orangeColor]);

                    // add action
                    regexp.nextAction(^(NSRange range, NSAttributedString * _Nonnull matched) {
                        NSLog(@"`%@` 被点击了", matched.string);
                        __strong typeof(_self) self = _self;
                        if ( !self ) return ;
                        UIViewController *vc = [UIViewController new];
                        vc.title = matched.string;
                        vc.view.backgroundColor = [UIColor whiteColor];
                        [self.navigationController pushViewController:vc animated:YES];
                    });
                });
                
                // insert
                worker.insert(@"[活动链接]", -1);
                worker.lastInserted(^(SJAttributeWorker * _Nonnull worker) {
                    worker
                    .nextFontColor([UIColor blueColor])
                    .nextUnderline(NSUnderlineStyleSingle, [UIColor colorWithWhite:0.6 alpha:1]);
                    worker.nextAction(^(NSRange range, NSAttributedString * _Nonnull matched) {
                        NSLog(@"`%@` 被点击了", matched.string);
                        __strong typeof(_self) self = _self;
                        if ( !self ) return ;
                        UIViewController *vc = [UIViewController new];
                        vc.title = matched.string;
                        vc.view.backgroundColor = [UIColor whiteColor];
                        [self.navigationController pushViewController:vc animated:YES];
                    });
                });
                
            }] maxWidth:[SJTableViewCell ContentMaxWidth] numberOfLines:0 lineSpacing:8];
            
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
