//
//  NSAttributedString+ActionDelegate.m
//  SJLabel
//
//  Created by BlueDancer on 2018/1/27.
//  Copyright © 2018年 SanJiang. All rights reserved.
//

#import "NSAttributedString+ActionDelegate.h"
#import <objc/message.h>

@implementation NSAttributedString (ActionDelegate)

- (void)setActionDelegate:(id<NSAttributedStringActionDelegate>)actionDelegate {
    objc_setAssociatedObject(self, @selector(actionDelegate), actionDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<NSAttributedStringActionDelegate>)actionDelegate {
    return objc_getAssociatedObject(self, _cmd);
}

@end
