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



@interface SJTableViewCell ()

@property (nonatomic, strong, readonly) SJLabel *label;

@end

@implementation SJTableViewCell
@synthesize label = _label;

+ (CGFloat)heightWithContentH:(CGFloat)contentH {
    return 8 + contentH;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( !self ) return nil;
    [self _cellSetupView];
    return self;
}

- (void)setHelper:(SJLabelHelper *)helper {
    _helper = helper;
    [_label setDrawData:helper.drawData];
}

- (void)_cellSetupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.label];
    
    _label.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(4, 0, 4, 0));
    }];
}

- (SJLabel *)label {
    if ( _label ) return _label;
    _label = [[SJLabel alloc] initWithText:nil font:[UIFont systemFontOfSize:14] textColor:[UIColor whiteColor] lineSpacing:0 userInteractionEnabled:YES];
    _label.numberOfLines = 0;
    return _label;
}
@end
