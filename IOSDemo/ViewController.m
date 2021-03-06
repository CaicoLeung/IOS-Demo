//
//  ViewController.m
//  IOSDemo
//
//  Created by 梁开扩 on 2020/1/8.
//  Copyright © 2020 至尊宝. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController () <UITextFieldDelegate, UITextViewDelegate>

@property Boolean flag;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UISwitch *leftSwitch;
@property (strong, nonatomic) UISwitch *rightSwitch;
@property (strong, nonatomic) UILabel *switchStatusLabel;
@property (strong, nonatomic) UILabel *labelSliderValue;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    NSLog(@"键盘打开");
}

- (void)keyboardDidHide:(NSNotification *)notification {
    NSLog(@"键盘关闭");
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"placeholder text here..."]) {
        textView.text = @"";
        textView.textColor = [UIColor grayColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView {
    textView.textColor = [UIColor blackColor];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"placeholder text here...";
        textView.textColor = [UIColor grayColor];
    }
    [textView resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.flag = true;
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat labelWidth = 180;
    CGFloat labelHeight = 20;
    CGFloat labelTopView = 150;
    CGRect labelFrame = CGRectMake((screen.size.width - labelWidth) / 2, labelTopView, labelWidth, labelHeight);
    self.label = [[UILabel alloc] initWithFrame:labelFrame];
    self.label.text = @"Caico Leung";
    self.label.textColor = [UIColor greenColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];

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
    textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    textField.returnKeyType = UIReturnKeyNext;
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
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake((screen.size.width - textViewWidth) / 2, textViewTopView, textViewWidth, textViewHeight)];
    self.textView.layer.borderWidth = 1.0;
    self.textView.layer.borderColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1].CGColor;
    self.textView.layer.cornerRadius = 5.0;
    self.textView.text = @"按回车键收起键盘";
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.keyboardType = UIKeyboardTypeDefault;
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    //    labelAbstract标签与textView之间的距离
    CGFloat labelAbstractTextViewSpace = 30;
    UILabel *labelAbstract = [[UILabel alloc] initWithFrame:CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y - labelAbstractTextViewSpace, 103, 21)];
    labelAbstract.text = @"Abstract:";
    [self.view addSubview:labelAbstract];

    CGFloat switchScreenSpace = 35;
    self.leftSwitch = [[UISwitch alloc] init];
    self.rightSwitch = [[UISwitch alloc] init];
    CGRect frame = self.leftSwitch.frame;
    frame.origin = CGPointMake(switchScreenSpace, 50);
    self.leftSwitch.frame = frame;
    self.leftSwitch.on = TRUE;
    [self.leftSwitch addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
    frame.origin = CGPointMake(screen.size.width - self.rightSwitch.frame.size.width - switchScreenSpace, 50);
    self.rightSwitch.frame = frame;
    self.rightSwitch.on = FALSE;
    [self.rightSwitch addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.leftSwitch];
    [self.view addSubview:self.rightSwitch];

    CGFloat switchStatusLabelSwitchSpace = 20;
    self.switchStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(switchScreenSpace + self.leftSwitch.frame.size.width + switchStatusLabelSwitchSpace, 50, screen.size.width - (switchScreenSpace + self.leftSwitch.frame.size.width + switchStatusLabelSwitchSpace) * 2, 20)];
    self.switchStatusLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.switchStatusLabel];

    NSArray *segments = @[ @"Left", @"Right" ];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segments];
    CGFloat scWidth = 220;
    CGFloat scHeight = 29;
    CGFloat scTopView = 80;
    CGRect scFrame = CGRectMake((screen.size.width - scWidth) / 2, scTopView, scWidth, scHeight);
    segmentedControl.frame = scFrame;
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];

    CGFloat slideWidth = 300;
    CGFloat slideHeight = 31;
    CGFloat slideTopView = 175;
    CGRect sliderFrame = CGRectMake((screen.size.width - slideWidth) / 2, slideTopView, slideWidth, slideHeight);
    UISlider *slider = [[UISlider alloc] initWithFrame:sliderFrame];
    slider.minimumValue = 0.0f;
    slider.maximumValue = 100.0f;
    slider.value = 50.00f;
    [slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];

    CGFloat labelSliderValueSliderSpace = 30;
    CGRect labelSliderFrame = CGRectMake(slider.frame.origin.x + slider.value / slider.maximumValue * slider.frame.size.width - 10, slider.frame.origin.y - labelSliderValueSliderSpace, 103, 21);
    self.labelSliderValue = [[UILabel alloc] initWithFrame:labelSliderFrame];
    self.labelSliderValue.font = [UIFont systemFontOfSize:20];
    self.labelSliderValue.text = [[NSString alloc] initWithFormat:@"%d", (int)slider.value];
    [self.view addSubview:self.labelSliderValue];
}

- (void)onButtonOnclick:(id)sender {
    NSLog(@"\"点我啊\"被点击了!");
    self.label.text = self.flag ? @"我脏了" : @"Caico Leung";
    self.flag = !self.flag;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"输入的文本为: %@", textField.text);
    [textField resignFirstResponder];
    [self.textView becomeFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(nonnull NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

- (void)switchValueChange:(id)sender {
    UISwitch *witchSwitch = (UISwitch *)sender;
    BOOL setting = [witchSwitch isOn];
    self.switchStatusLabel.text = [witchSwitch isOn] == TRUE ? @"开启" : @"关闭";
    [self.leftSwitch setOn:setting animated:TRUE];
    [self.rightSwitch setOn:setting animated:TRUE];
}

- (void)touchDown:(UISegmentedControl *)sender {
    NSLog(@"选择的段: %li", sender.selectedSegmentIndex);
    if (sender.selectedSegmentIndex == 0) {
        self.rightSwitch.hidden = TRUE;
        self.leftSwitch.hidden = FALSE;
    } else {
        self.leftSwitch.hidden = TRUE;
        self.rightSwitch.hidden = FALSE;
    }
}

-(void)sliderValueChange:(UISlider *)sender {
    NSLog(@"当前值: %f", sender.value);
    self.labelSliderValue.text = [[NSString alloc] initWithFormat:@"%d", (int)sender.value];
    CGRect labelSliderFrame = CGRectMake(sender.frame.origin.x + sender.value / sender.maximumValue * sender.frame.size.width, sender.frame.origin.y - 30, 103, 21);
    self.labelSliderValue.frame = labelSliderFrame;
}

@end
