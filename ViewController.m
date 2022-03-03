//
//  ViewController.m
//  YKModelGenerator
//
//  Created by mac on 2022/1/21.
//

#import "ViewController.h"
@interface ViewController()
@property (unsafe_unretained) IBOutlet NSTextView *textView;
@property (unsafe_unretained) IBOutlet NSTextView *codeTextView;
@property (weak) IBOutlet NSTextField *tipsLabel;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    NSString *text = [[NSUserDefaults standardUserDefaults] valueForKey:@"YKUserLastTextKey"];
    if (text) {
        _textView.string = text;
    }
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}
- (IBAction)generateCodeText:(NSButton *)sender {
    
    NSString *text = _textView.string;
    NSMutableString *destText =  [NSMutableString string];
    if (text.length) {
        NSArray *elements =  [text componentsSeparatedByString:@"\n"];
        for (NSString *ets in elements)
        {
            NSMutableArray *rowObjArr =  [[ets componentsSeparatedByString:@" "] mutableCopy];
            if (rowObjArr.count>0) {
                NSString *head = rowObjArr[0];
                head = [NSString stringWithFormat:@"@property (nonatomic,copy)  NSString *%@;//",head];
                [rowObjArr removeObjectAtIndex:0];
                NSString *tail = [rowObjArr componentsJoinedByString:@" "];
                NSString *property = [NSString stringWithFormat:@"%@%@\n",head,tail];
                [destText appendString:property];
            }
        }
    }
    _codeTextView.string = destText;
    if (!destText.length) {
        [self showMessage:@"内容为空" isSuccess:NO];
    }else
    {
        [[NSUserDefaults standardUserDefaults] setValue:text forKey:@"YKUserLastTextKey"];
    }
   
}

-(void)showMessage:(NSString *)msg isSuccess:(BOOL)isSuccess
{
    _tipsLabel.stringValue = msg;
    _tipsLabel.textColor = isSuccess?NSColor.greenColor:NSColor.redColor;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _tipsLabel.stringValue = @"";
    });
}
- (IBAction)clickCopyBtn:(NSButton *)sender {
    
    NSString *text = _codeTextView.string ;
    [[NSPasteboard generalPasteboard] setString:text forType:( NSPasteboardTypeString)];
    BOOL isSuccess = text.length;
    NSString *msg = isSuccess?@"已拷贝":@"内容为空";
    [self showMessage:msg isSuccess:isSuccess];
}
@end
