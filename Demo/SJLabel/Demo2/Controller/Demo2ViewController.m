
//
//  Demo2ViewController.m
//  SJLabel
//
//  Created by BlueDancer on 2017/12/23.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import "Demo2ViewController.h"
#import <SJVideoPlayer.h>
#import <SJUIFactory/SJUIFactory.h>
#import <Masonry.h>
#import "Demo2TableViewCell.h"

static NSString *const Demo2TableViewCellID = @"Demo2TableViewCell";

@interface Demo2ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong, readonly) SJVideoPlayer *player;
@property (nonatomic, strong, readonly) UITableView *tableView;

@end

@implementation Demo2ViewController
@synthesize tableView = _tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setupViews];
    
    [self _settingPlayer];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.player.disableRotation = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.player pause];
    self.player.disableRotation = YES;
}

- (void)dealloc {
    self.player.disableRotation = NO;
    [self.player stop];
}

- (void)_settingPlayer {
    [self.player setPlaceholder:[UIImage imageNamed:@"_placeholder"]];
    self.player.asset = [[SJVideoPlayerAssetCarrier alloc] initWithAssetURL:[NSURL URLWithString:@"http://vod.lanwuzhe.com/d09d3a5f9ba4491fa771cd63294ad349%2F0831eae12c51428fa7aed3825c511370-5287d2089db37e62345123a1be272f8b.mp4"] beginTime:15];
    
    __weak typeof(self) _self = self;
    self.player.clickedBackEvent = ^(SJVideoPlayer * _Nonnull player) {
        __strong typeof(_self) self = _self;
        if ( !self ) return ;
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    self.player.rotatedScreen = ^(SJVideoPlayer * _Nonnull player, BOOL isFullScreen) {
        if ( isFullScreen ) {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        }
        else {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        }
    };
}

- (void)_setupViews {
    [self.view addSubview:self.player.view];
    [self.view addSubview:self.tableView];
    
    [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(SJ_is_iPhoneX() ? 34 : 20);
        make.leading.trailing.offset(0);
        make.height.equalTo(self.player.view.mas_width).multipliedBy(9.0f / 16);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.player.view.mas_bottom);
        make.leading.bottom.trailing.offset(0);
    }];
    
    _tableView.rowHeight = 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 99;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Demo2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Demo2TableViewCellID forIndexPath:indexPath];
    cell.textLabel.text = @"禁止";
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}
- (SJVideoPlayer *)player {
    return [SJVideoPlayer sharedPlayer];
}
- (UITableView *)tableView {
    if ( _tableView ) return _tableView;
    _tableView = [SJUITableViewFactory tableViewWithStyle:UITableViewStylePlain backgroundColor:[UIColor whiteColor] separatorStyle:UITableViewCellSeparatorStyleNone showsVerticalScrollIndicator:YES delegate:self dataSource:self];
    [SJUITableViewFactory settingTableView:_tableView estimatedRowHeight:0 estimatedSectionHeaderHeight:0 estimatedSectionFooterHeight:0];
    [_tableView registerClass:NSClassFromString(Demo2TableViewCellID)
           forCellReuseIdentifier:Demo2TableViewCellID];
    return _tableView;
}
@end
