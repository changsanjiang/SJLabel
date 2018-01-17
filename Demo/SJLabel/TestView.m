//
//  TestView.m
//  SJLabel
//
//  Created by BlueDancer on 2018/1/16.
//  Copyright © 2018年 SanJiang. All rights reserved.
//

#import "TestView.h"
#import <CoreText/CoreText.h>
#import <SJAttributesFactoryHeader.h>

@implementation TestView

- (void)drawRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(contextRef, CGAffineTransformIdentity);
    CGContextTranslateCTM(contextRef, 0, rect.size.height);
    CGContextScaleCTM(contextRef, 1.0, -1.0);
    
    UIFont *font = [UIFont systemFontOfSize:14];
    
    NSAttributedString *attrStr = [SJAttributesFactory producingWithTask:^(SJAttributeWorker * _Nonnull worker) {
        worker.insertText(@"🐻AA我j的人AAAA\n🐻🐻A我🐻🐻🐻\nAAAJjgAAAAA\nxxvvvvvvv\n我的jGgpp鸡\nAA我AgggGG", 0)
        .font(font).fontColor([UIColor blackColor]);
    }];
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrStr);
    CGPathRef pathRef = CGPathCreateWithRect(rect, NULL);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, 0), pathRef, NULL);
    
    
    CFArrayRef lines = CTFrameGetLines(frameRef);
    CFIndex linesCount = CFArrayGetCount(lines);
    CGPoint origins[linesCount];
    CTFrameGetLineOrigins(frameRef, CFRangeMake(0, 0), origins);
    
    // 行高 = 每行的asent + 每行的descent + 行数 * 行间距
    CGFloat frameY = 0;
    CGFloat lineSpacing = 0;
    
    CGFloat rowH = font.ascender - font.descender + font.leading;
    for ( CFIndex i = 0 ; i < linesCount ; ++ i ) {
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines, i);
        CGPoint origin = origins[i];
        frameY = rect.size.height - (rowH + lineSpacing) * i - font.ascender;
        origin.y = frameY;
        CGContextSetTextPosition(contextRef, origin.x, origin.y);
        CTLineDraw(lineRef, contextRef);
    }
    
    CFRelease(pathRef);
    CFRelease(frameRef);
    CFRelease(framesetterRef);
}

@end
