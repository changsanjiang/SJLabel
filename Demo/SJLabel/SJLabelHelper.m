//
//  SJLabelHelper.m
//  SJLabel
//
//  Created by BlueDancer on 2017/12/20.
//  Copyright © 2017年 SanJiang. All rights reserved.
//

#import "SJLabelHelper.h"
#import "SJCTFrameParser.h"

@implementation SJLabelHelper

+ (instancetype)helperWithAttributedStr:(NSAttributedString *)attributedStr
                               maxWidth:(float)maxWidth
                          numberOfLines:(NSUInteger)numberOfLines {
    return [[self alloc] initWithAttributedStr:attributedStr maxWidth:maxWidth numberOfLines:numberOfLines];
}

- (instancetype)initWithAttributedStr:(NSAttributedString *)attributedStr
                             maxWidth:(float)maxWidth
                        numberOfLines:(NSUInteger)numberOfLines {
    self = [super init];
    if ( !self ) return nil;
    SJCTFrameParserConfig *config = [SJCTFrameParserConfig defaultConfig];
    config.numberOfLines = numberOfLines;
    config.maxWidth = maxWidth;
    _drawData = [SJCTFrameParser parserAttributedStr:attributedStr config:config];
    return self;
}

@end
