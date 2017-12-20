//
//  SJTableViewCell.h
//  SJAttributesFactory
//
//  Created by BlueDancer on 2017/12/15.
//  Copyright © 2017年 畅三江. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SJLabelHelper;

@interface SJTableViewCell : UITableViewCell

+ (CGFloat)heightWithContentH:(CGFloat)contentH;

@property (nonatomic, strong, nullable) SJLabelHelper *helper;

@end

NS_ASSUME_NONNULL_END
