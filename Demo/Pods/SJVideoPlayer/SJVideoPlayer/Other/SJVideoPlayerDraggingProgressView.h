//
//  SJVideoPlayerDraggingProgressView.h
//  SJVideoPlayerProject
//
//  Created by 畅三江 on 2017/12/4.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import "SJVideoPlayerBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@class SJVideoPlayerAssetCarrier;

@interface SJVideoPlayerDraggingProgressView : SJVideoPlayerBaseView

@property (nonatomic, assign) float progress;

@property (nonatomic, weak, readwrite, nullable) SJVideoPlayerAssetCarrier *asset;

@property (nonatomic, assign) BOOL hiddenProgressSlider;

@property (nonatomic, assign) CGSize size;

@end

NS_ASSUME_NONNULL_END
