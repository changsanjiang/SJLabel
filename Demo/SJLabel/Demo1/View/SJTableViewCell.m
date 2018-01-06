//
//  SJTableViewCell.m
//  SJAttributesFactory
//
//  Created by BlueDancer on 2017/12/15.
//  Copyright © 2017年 畅三江. All rights reserved.
//

#import "SJTableViewCell.h"
#import <Masonry.h>
#import "SJLabel.h"
#import "SJLabelHelper.h"
#import "SJDemoModel.h"
#import <SJUIFactory.h>

@interface SJTableViewCell ()

@property (nonatomic, strong, readonly) UIImageView *avatarImageView;
@property (nonatomic, strong, readonly) SJLabel *nameLabel;
@property (nonatomic, strong, readonly) SJLabel *timeLabel;
@property (nonatomic, strong, readonly) SJLabel *contentLabel;
@property (nonatomic, strong, readonly) UIButton *commentBtn;

@end

@implementation SJTableViewCell

@synthesize avatarImageView = _avatarImageView;
@synthesize nameLabel = _nameLabel;
@synthesize timeLabel = _timeLabel;
@synthesize contentLabel = _contentLabel;
@synthesize commentBtn = _commentBtn;

+ (CGFloat)heightWithContentH:(CGFloat)contentH {
    return 8 + 50 + 8 + contentH + 40 + 8;
}

+ (CGFloat)ContentMaxWidth {
    return [UIScreen mainScreen].bounds.size.width - 22 * 2;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( !self ) return nil;
    [self _cellSetupView];
    return self;
}

- (void)setHelper:(SJLabelHelper *)helper {
    _helper = helper;
    [_contentLabel setDrawData:helper.drawData];
}

- (void)setModel:(SJDemoModel *)model {
    _model = model;
    _nameLabel.text = model.name;
    _avatarImageView.image = [UIImage imageNamed:model.avatar];
}

- (void)_cellSetupView {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.commentBtn];
    
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(8);
        make.leading.offset(14);
        make.size.offset(50);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_avatarImageView.mas_centerY);
        make.leading.equalTo(_avatarImageView.mas_trailing).offset(10);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom);
        make.leading.equalTo(_nameLabel);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_avatarImageView.mas_bottom).offset(8);
        make.leading.offset(22);
        make.trailing.offset(-22);
    }];
    
    [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(60);
        make.bottom.offset(-8);
        make.trailing.offset(0);
    }];
}

- (UIImageView *)avatarImageView {
    if ( _avatarImageView ) return _avatarImageView;
    _avatarImageView = [SJShapeImageViewFactory imageViewWithCornerRadius:25 imageName:@"avatar"];
    _avatarImageView.layer.borderColor = [[UIColor redColor] colorWithAlphaComponent:0.6].CGColor;
    _avatarImageView.layer.borderWidth = 0.6;
    return _avatarImageView;
}

- (SJLabel *)nameLabel {
    if ( _nameLabel ) return _nameLabel;
    _nameLabel = [[SJLabel alloc] initWithText:@"今朝醉" font:[UIFont boldSystemFontOfSize:14] textColor:[UIColor colorWithWhite:0.2 alpha:1] lineSpacing:0 userInteractionEnabled:NO];
    return _nameLabel;
}

- (SJLabel *)timeLabel {
    if ( _timeLabel ) return _timeLabel;
    _timeLabel = [[SJLabel alloc] initWithText:@"2017/12/21" font:[UIFont systemFontOfSize:12] textColor:[UIColor colorWithWhite:0.6 alpha:1] lineSpacing:0 userInteractionEnabled:NO];
    return _timeLabel;
}

- (SJLabel *)contentLabel {
    if ( _contentLabel ) return _contentLabel;
    _contentLabel = [SJLabel new];
    _contentLabel.userInteractionEnabled = YES;
    _contentLabel.text = @"测试测试测测试测试测测试测试测测试测试测测试测试测测试测试测";
    return _contentLabel;
}

- (UIButton *)commentBtn {
    if ( _commentBtn ) return _commentBtn;
    _commentBtn = [SJUIButtonFactory buttonWithImageName:@"comment"];
    return _commentBtn;
}

@end
