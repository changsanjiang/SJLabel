# SJLabel

### 可匹配点击的Label:
<img src="https://github.com/changsanjiang/SJAttributesFactory/blob/master/Demo/SJAttributesFactory/action.gif" />

___

### Use

```ruby
pod 'SJLabel'
```
___

### Sample
```Objective-C
- (void)test {
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"@迷你世界联机 :@江叔 用小淘气耍赖野人#迷你世界#. #精选#看到最后!! [点赞]!![评论]!!"];
    
    // 1. add `attributedString` some action
    attrStr.actionDelegate = self;
    
    // 2. regular matching action
    attrStr.addAction(@"([@][^\\s]+\\s)|([#][^#]+#)|([\\[][^\\]]+\\])");
    
    // 3. set str
    sjLabel.attributedText = attrStr;
}

/// Delegate Method
- (void)attributedString:(NSAttributedString *)attrStr action:(NSAttributedString *)action {
    NSLog(@"%@", action.string);
}
```
