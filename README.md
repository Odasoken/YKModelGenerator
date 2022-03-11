# YKModelGenerator
 Mac属性代码生成工具，帮助您根据文档属性列表生成属性代码
  * 例如
        *属性
```objc
age    年龄    number
dogId    用户ID    integer
dogNo    身份编号    string
color    颜色1    string
```
        *代码
```objc
@property (nonatomic,copy)  NSString *age;//   年龄    number
@property (nonatomic,copy)  NSString *dogId;//   用户ID    integer
@property (nonatomic,copy)  NSString *dogNo;//   身份编号    string
@property (nonatomic,copy)  NSString *color;//   颜色1    string
```
