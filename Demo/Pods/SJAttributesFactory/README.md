# SJAttributesFactory

```ruby
  // v2.0
  pod 'SJAttributesFactory'
  
  // v1.0. 抱歉各位, 由于结构调整, `v1`和`v2`版本差距较大, 大家可以如下方式, 继续使用`v1`版本的.
  pod 'SJAttributesFactory', '1.1.14'

```
### 最新动态:
- 发布v2版本, 优化了v1版本的操作不便之处, 移除了多余代码.

附 富文本属性:
http://www.jianshu.com/p/ebbcfc24f9cb

___

### [可匹配点击的Label](https://github.com/changsanjiang/SJLabel):
<img src="https://github.com/changsanjiang/SJAttributesFactory/blob/master/Demo/SJAttributesFactory/action.gif" />

___

### regular expression
<img src="https://github.com/changsanjiang/SJAttributesFactory/blob/master/Demo/SJAttributesFactory/regular.jpeg" />

```Objective-C
    sj_makeAttributesString(^(SJAttributeWorker * _Nonnull make) {
        make.insert(@"@迷你世界联机 :@江叔 用小淘气耍赖野人#迷你世界#", 0);
        
        make.regexp(@"[@][^@]+\\s", ^(SJAttributesRangeOperator * _Nonnull matched) {
            matched.textColor([UIColor purpleColor]);
        });
        make.regexp(@"[#][^#]+#", ^(SJAttributesRangeOperator * _Nonnull matched) {
            matched.textColor([UIColor orangeColor]);
        });
    });

```
___

### common method
<img src="https://github.com/changsanjiang/SJAttributesFactory/blob/master/Demo/SJAttributesFactory/common.jpeg" />

```Objective-C
    sj_makeAttributesString(^(SJAttributeWorker * _Nonnull make) {
        make.insert(@"叶秋笑了笑，抬手取下了衔在嘴角的烟头。", 0);
        
        make
        .font([UIFont boldSystemFontOfSize:40])                       // 设置字体
        .textColor([UIColor blackColor])                              // 设置文本颜色
        .underLine(NSUnderlineStyleSingle, [UIColor orangeColor])     // 设置下划线
        .strikethrough(NSUnderlineStyleSingle, [UIColor orangeColor]) // 设置删除线
//        .shadow(CGSizeMake(0.5, 0.5), 0, [UIColor redColor])        // 设置阴影
//        .backgroundColor([UIColor whiteColor])                      // 设置文本背景颜色
        .stroke([UIColor greenColor], 1)                              // 字体边缘的颜色, 设置后, 字体会镂空
//        .offset(-10)                                                // 上下偏移
        .obliqueness(0.3)                                             //  倾斜
        .letterSpacing(4)                                             // 字体间隔
        .lineSpacing(4)                                               // 行间隔
        .alignment(NSTextAlignmentCenter)                             // 对其方式
        ;
        
        [self updateConstraintsWithSize:make.sizeByWidth(self.view.bounds.size.width - 80)];
    });
```
___

### size
```Objective-C
@interface SJAttributeWorker(Size)
@property (nonatomic, copy, readonly) CGSize(^size)(void);
@property (nonatomic, copy, readonly) CGSize(^sizeByRange)(NSRange range);
@property (nonatomic, copy, readonly) CGSize(^sizeByWidth)(double maxWidth);
@property (nonatomic, copy, readonly) CGSize(^sizeByHeight)(double maxHeight);
@end
```
___

### insert
```Objective-C
@interface SJAttributeWorker(Insert)

@property (nonatomic, assign, readonly) NSRange lastInsertedRange;

@property (nonatomic, copy, readonly) SJAttributeWorker *(^lastInserted)(void(^task)(SJAttributesRangeOperator *lastOperator));

@property (nonatomic, copy, readonly) SJAttributeWorker *(^add)(NSAttributedStringKey key, id value, NSRange range);

@property (nonatomic, copy, readonly) SJAttributeWorker *(^insertText)(NSString *text, NSInteger index);

@property (nonatomic, copy, readonly) SJAttributeWorker *(^insertImage)(UIImage *image, NSInteger index, CGPoint offset, CGSize size);

@property (nonatomic, copy, readonly) SJAttributeWorker *(^insertAttrStr)(NSAttributedString *text, NSInteger index);

@property (nonatomic, copy, readonly) SJAttributeWorker *(^insert)(id strOrAttrStrOrImg, NSInteger index, ...);

@end
```
___

### replace
```Objective-C
@interface SJAttributeWorker(Replace)
@property (nonatomic, copy, readonly) void(^replace)(NSRange range, id strOrAttrStrOrImg, ...);
@end
```
___

### remove
```Objective-C
@interface SJAttributeWorker(Delete)
@property (nonatomic, copy, readonly) void(^removeText)(NSRange range);
@property (nonatomic, copy, readonly) void(^removeAttribute)(NSAttributedStringKey key, NSRange range);
@property (nonatomic, copy, readonly) void(^removeAttributes)(NSRange range);
@end
```
___

### 最近更新:
- [增加了一个可以匹配点击动作的 Label](https://github.com/changsanjiang/SJLabel).
- 添加了一个编辑最近(lastInserted)插入的文本的方法.
- 完善参数错误的相关提示
- 修复了insert方法插入-1时的Bug
- 增加了正则相关的方法
- 新增了一个替换方法
- 新增了一个范围获取AttrStr的方法
- 添加了HeaderFile, 方便导入头文件
- 添加了第二种范围编辑Method
- 修复了Size方法的Bug
- 增加了对范围段落Style编辑的方法
- 改变了项目结构, 使其更合逻辑(变更较大)
- 新增可变参(insert)插入方法
