//
//  ViewController.m
//  IOSDemo
//
//  Created by 梁开扩 on 2020/1/8.
//  Copyright © 2020 至尊宝. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()<UITextFieldDelegate, UITextViewDelegate>
@property Boolean flag;
@property (strong, nonatomic)UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.flag = true;
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat labelWidth = 180;
    CGFloat labelHeight = 20;
    CGFloat labelTopView = 150;
    CGRect labelFrame =  CGRectMake((screen.size.width - labelWidth) / 2, labelTopView, labelWidth, labelHeight);
    self.label = [[UILabel alloc] initWithFrame:labelFrame];
    self.label.text = @"Caico Leung";
    self.label.textColor = [UIColor greenColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: self.label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"点我啊" forState:UIControlStateNormal];
    [button setTitle:@"我亮了" forState:UIControlStateHighlighted];
    CGFloat buttonWidth = 60;
    CGFloat buttonHeight = 20;
    CGFloat buttonTopView = 240;
    button.frame = CGRectMake((screen.size.width - buttonWidth) / 2, buttonTopView, buttonWidth, buttonHeight);
    [button addTarget:self action:@selector(onButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    CGFloat textFieldWidth = 236;
    CGFloat textFieldheight = 30;
    CGFloat textTopView = 300;
    CGRect textFieldFrame = CGRectMake((screen.size.width - textFieldWidth) / 2, textTopView, textFieldWidth, textFieldheight);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldFrame];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.delegate = self;
    [self.view addSubview:textField];
//    labelName标签与textField之间的距离
    CGFloat labelNameTextFieldSpace = 30;
    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(textField.frame.origin.x, textField.frame.origin.y - labelNameTextFieldSpace, 51, 21)];
    labelName.text = @"Name:";
    [self.view addSubview:labelName];
    
    CGFloat textViewWidth = 236;
    CGFloat textViewHeight = 198;
    CGFloat textViewTopView = 360;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake((screen.size.width - textViewWidth) / 2, textViewTopView, textViewWidth, textViewHeight)];
    textView.layer.borderWidth = 1.0;
    textView.layer.borderColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    textView.layer.cornerRadius = 5.0;
    textView.text = @"按Tab键收起键盘";
    textView.delegate = self;
    [self.view addSubview:textView];
//    labelAbstract标签与textView之间的距离
    CGFloat labelAbstractTextViewSpace = 30;
    UILabel *labelAbstract = [[UILabel alloc] initWithFrame:CGRectMake(textView.frame.origin.x, textView.frame.origin.y - labelAbstractTextViewSpace, 103, 21)];
    labelAbstract.text = @"Abstract:";
    [self.view addSubview:labelAbstract];
}

-(void)onButtonOnclick:(id)sender {
    NSLog(@"\"点我啊\"被点击了!");
    self.label.text = self.flag ? @"我脏了" : @"Caico Leung";
    self.flag = !self.flag;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(nonnull NSString *)text{
    if ([text isEqualToString:@"\t"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

@end
