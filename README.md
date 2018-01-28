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
- (void)addAction {
    // add `attributedString` some action
    attrStr.actionDelegate = self;
    
    // regular matching action
    attrStr.addAction(@"[@][^\\s]+\\s");
    attrStr.addAction(@"[\[][^\]]+\]");
}

/// Delegate Method
- (void)attributedString:(NSAttributedString *)attrStr action:(NSAttributedString *)action {
    NSLog(@"%@", action.string);
}
```
