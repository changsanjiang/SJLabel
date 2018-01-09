//
//  SJVideoPlayerPreviewCollectionViewCell.m
//  SJVideoPlayerProject
//
//  Created by BlueDancer on 2017/12/4.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import "SJVideoPlayerPreviewCollectionViewCell.h"
#import <SJUIFactory/SJUIFactory.h>
#import "SJVideoPlayerResources.h"
#import <Masonry/Masonry.h>
#import <SJVideoPlayerAssetCarrier/SJVideoPlayerAssetCarrier.h>

@interface SJVideoPlayerPreviewCollectionViewCell ()

@property (nonatomic, strong, readonly) UIImageView *imageView;

@end

@implementation SJVideoPlayerPreviewCollectionViewCell

@synthesize imageView = _imageView;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( !self ) return nil;
    [self _collectionSetupView];
    return self;
}

- (void)setModel:(SJVideoPreviewModel *)model {
    _model = model;
    _imageView.image = model.image;
}

- (void)_collectionSetupView {
    [self.contentView addSubview:self.imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_imageView.superview);
    }];
}

- (UIImageView *)imageView {
    if ( _imageView ) return _imageView;
    _imageView = [SJUIImageViewFactory imageViewWithImageName:@"" viewMode:UIViewContentModeScaleAspectFill];
    return _imageView;
}
@end
