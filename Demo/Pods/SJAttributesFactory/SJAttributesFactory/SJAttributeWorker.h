//
//  SJAttributeWorker.h
//  SJAttributeWorker
//
//  Created by 畅三江 on 2017/11/12.
//  Copyright © 2017年 畅三江. All rights reserved.
//
//  Project Address: https://github.com/changsanjiang/SJAttributesFactory
//  Email:  changsanjiange@gmail.com
//

#import <UIKit/UIKit.h>
#import "SJAttributesRecorder.h"

typedef NSString * NSAttributedStringKey NS_EXTENSIBLE_STRING_ENUM;

@class SJBorderAttribute, SJUnderlineAttribute, SJAttributeWorker;

NS_ASSUME_NONNULL_BEGIN

/*!
 *
 *  make attributed string:
 *   NSAttributedString *attrStr = sj_makeAttributesString(^(SJAttributeWorker * _Nonnull make) {
 *
 *       // set font , text color.
 *       make.font([UIFont boldSystemFontOfSize:14]).textColor([UIColor blueColor]);
 *
 *       // insert text.
 *       make.insert(@"叶秋笑了笑，抬手取下了衔在嘴角的烟头。银白的烟灰已经结成了长长一串，但在叶秋挥舞着鼠标敲打着键盘施展操作的过程中却没有被震落分毫.", 0);
 *
 *       // regexp matching
 *       make.regexp(@"叶秋", ^(SJAttributesRangeOperator * _Nonnull matched) {
 *
 *           // set matched text textColor.
 *           matched.textColor([UIColor redColor]);
 *
 *           // add underLine
 *           matched.underLine([SJUnderlineAttribute underLineWithStyle:NSUnderlineStyleSingle | NSUnderlinePatternSolid color:[UIColor orangeColor]]);
 *       });
 *   });
 **/
extern NSMutableAttributedString *sj_makeAttributesString(void(^block)(SJAttributeWorker *make));

#pragma mark -
@interface SJAttributesRangeOperator: NSObject
@property (nonatomic, strong, readonly) SJAttributesRecorder *recorder;
@end


#pragma mark -

@interface SJAttributeWorker : SJAttributesRangeOperator

- (instancetype)init NS_DESIGNATED_INITIALIZER;

@property (nonatomic, assign, readonly) NSRange range;

- (NSMutableAttributedString *)endTask;

- (NSMutableAttributedString *)endTaskAndComplete:(void(^)(SJAttributeWorker *worker))block;

/*!
 *  default font.
 *
 *  default is UIFont.systemFont(ofSize: 14)
 **/
@property (nonatomic, strong) UIFont *defaultFont;

/*!
 *  default textColor.
 *
 *  default is UIColor.black
 **/
@property (nonatomic, strong) UIColor *defaultTextColor;

/*!
 *  range editing. can be used it with `regexp` method.
 *
 *  范围编辑, 可以配合正则使用.
 **/
@property (nonatomic, copy, readonly) SJAttributeWorker *(^rangeEdit)(NSRange range, void (^task)(SJAttributesRangeOperator *rangeOperator));

/*!
 *  get sub attributedString by `range`.
 *
 *  按照范围获取文本
 **/
@property (nonatomic, copy, readonly) NSAttributedString *(^subAttrStr)(NSRange subRange);

@end




#pragma mark - 正则 - regexp
@interface SJAttributeWorker(Regexp)
/*!
 *  regular expression.
 *
 *  正则匹配
 **/
@property (nonatomic, copy, readonly) SJAttributeWorker *(^regexp)(NSString *regStr, void(^matchedTask)(SJAttributesRangeOperator *matched));
/*!
 *  regular expression. value is [NSRange].
 *
 *  正则匹配
 **/
@property (nonatomic, copy, readonly) SJAttributeWorker *(^regexp_r)(NSString *regStr, void(^matchedTask)(NSArray<NSValue *> *matchedRanges), BOOL reverse);

@end




#pragma mark - 大小 - size
@interface SJAttributeWorker(Size)
@property (nonatomic, copy, readonly) CGSize(^size)(void);
@property (nonatomic, copy, readonly) CGSize(^sizeByRange)(NSRange range);
@property (nonatomic, copy, readonly) CGSize(^sizeByWidth)(double maxWidth);
@property (nonatomic, copy, readonly) CGSize(^sizeByHeight)(double maxHeight);
@end




#pragma mark - 插入 - insert
@interface SJAttributeWorker(Insert)
/*!
 *  the range of the last inserted text.
 *
 *  最近一次插入的文本的范围.
 **/
@property (nonatomic, assign, readonly) NSRange lastInsertedRange;
/*!
 *  editing the latest text.
 *
 *  编辑最后插入的文本.
 **/
@property (nonatomic, copy, readonly) SJAttributeWorker *(^lastInserted)(void(^task)(SJAttributesRangeOperator *lastOperator));
/*!
 *  add attribute of `key, value, range`.
 *
 *  添加
 **/
@property (nonatomic, copy, readonly) SJAttributeWorker *(^add)(NSAttributedStringKey key, id value, NSRange range);
/*!
 *  insert text, `-1` indicates the insertion to the end.
 *
 *  插入文本, `-1` 表示插入到最后
 **/
@property (nonatomic, copy, readonly) SJAttributeWorker *(^insertText)(NSString *text, NSInteger index);
/*!
 *  insert image, `-1` indicates the insertion to the end.
 *
 *  插入图片, `-1` 表示插入到最后
 **/
@property (nonatomic, copy, readonly) SJAttributeWorker *(^insertImage)(UIImage *image, NSInteger index, CGPoint offset, CGSize size);
/*!
 *  inset text, `-1` indicates the insertion to the end.
 *
 *  插入文本, `-1` 表示插入到最后
 **/
@property (nonatomic, copy, readonly) SJAttributeWorker *(^insertAttrStr)(NSAttributedString *text, NSInteger index);

/*!
 *  inset text or image, `-1` indicates the insertion to the end.
 *
 *  插入, `-1` 表示插入到最后
 **/
@property (nonatomic, copy, readonly) SJAttributeWorker *(^insert)(id strOrAttrStrOrImg, NSInteger index, ...);

@end



#pragma mark - 替换 - replace
@interface SJAttributeWorker(Replace)
@property (nonatomic, copy, readonly) void(^replace)(NSRange range, id strOrAttrStrOrImg, ...);
@end



#pragma mark - 删除 - remove
@interface SJAttributeWorker(Delete)
@property (nonatomic, copy, readonly) void(^removeText)(NSRange range);
@property (nonatomic, copy, readonly) void(^removeAttribute)(NSAttributedStringKey key, NSRange range);
@property (nonatomic, copy, readonly) void(^removeAttributes)(NSRange range);
@end



#pragma mark - 属性 - property
@interface SJAttributesRangeOperator(Property)

/// 字体
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^font)(UIFont *font);
/// 文本颜色
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^textColor)(UIColor *color);
/// 放大, 扩大
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^expansion)(double expansion);
/// 阴影
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^shadow)(NSShadow *shadow);
/// 背景颜色
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^backgroundColor)(UIColor *color);
/// 下划线
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^underLine)(NSUnderlineStyle style, UIColor *color);
/// 删除线
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^strikethrough)(NSUnderlineStyle style, UIColor *color);
/// 边界`border`
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^border)(SJBorderAttribute *border);
/// 倾斜(-1 ... 1)
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^obliqueness)(double obliqueness);
/// 字间隔
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^letterSpacing)(double letterSpacing);
/// 上下偏移
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^offset)(double offset);
/// 链接
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^isLink)(void);
/// 段落 style
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^paragraphStyle)(NSParagraphStyle *style);
/// 行间隔
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^lineSpacing)(double lineSpacing);
/// 段后间隔(\n)
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^paragraphSpacing)(double paragraphSpacing);
/// 段前间隔(\n)
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^paragraphSpacingBefore)(double paragraphSpacingBefore);
/// 首行头缩进
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^firstLineHeadIndent)(double firstLineHeadIndent);
/// 左缩进
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^headIndent)(double headIndent);
/// 右缩进(正值从左算起, 负值从右算起)
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^tailIndent)(double tailIndent);
/// 对齐方式
@property (nonatomic, copy, readonly) SJAttributesRangeOperator *(^alignment)(NSTextAlignment alignment);

@end

NS_ASSUME_NONNULL_END
