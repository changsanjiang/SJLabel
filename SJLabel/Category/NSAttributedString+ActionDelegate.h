//
//  NSAttributedString+ActionDelegate.h
//  SJLabel
//
//  Created by BlueDancer on 2018/1/27.
//  Copyright © 2018年 SanJiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NSAttributedStringActionDelegate<NSObject>

@optional
- (void)attributedString:(NSAttributedString *)attrStr action:(NSAttributedString *)action;

@end

@interface NSAttributedString (ActionDelegate)

@property (nonatomic, weak, readwrite, nullable) id<NSAttributedStringActionDelegate> actionDelegate;

@end

NS_ASSUME_NONNULL_END
