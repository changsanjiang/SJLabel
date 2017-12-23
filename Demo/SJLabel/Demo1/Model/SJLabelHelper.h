//
//  SJLabelHelper.h
//  SJLabel
//
//  Created by BlueDancer on 2017/12/20.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SJCTData.h"

@interface SJLabelHelper : NSObject

+ (instancetype)helperWithAttributedStr:(NSAttributedString *)attributedStr
                               maxWidth:(float)maxWidth
                          numberOfLines:(NSUInteger)numberOfLines;

@property (nonatomic, strong, readonly) SJCTData *drawData;

@end
