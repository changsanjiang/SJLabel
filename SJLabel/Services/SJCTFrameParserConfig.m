//
//  SJCTFrameParserConfig.m
//  Test
//
//  Created by BlueDancer on 2017/12/13.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import "SJCTFrameParserConfig.h"

@implementation SJCTFrameParserConfig

+ (SJCTFrameParserConfig *)defaultConfig {
    SJCTFrameParserConfig *defaultConfig = [SJCTFrameParserConfig new];
    defaultConfig.maxWidth = [UIScreen mainScreen].bounds.size.width;
    defaultConfig.font = [UIFont systemFontOfSize:14];
    defaultConfig.textColor = [UIColor blackColor];
    defaultConfig.lineSpacing = 0;
    defaultConfig.textAlignment = NSTextAlignmentLeft;
    defaultConfig.numberOfLines = 1;
//    defaultConfig.lineBreakMode = NSLineBreakByTruncatingTail;
    return defaultConfig;
}

+ (CGFloat)fontSize:(UIFont *)font {
    return [[font.fontDescriptor objectForKey:UIFontDescriptorSizeAttribute] doubleValue];
} 

@end
