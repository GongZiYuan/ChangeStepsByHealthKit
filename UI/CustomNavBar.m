 //
//  CustomNavBar.m
//  TaoYouHui
//
//  Created by Etouch on 13-3-26.
//
//

#import "CustomNavBar.h"

@interface CustomNavBar(){
    
}

@end
@implementation CustomNavBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        frame.origin.y = 0;
        
        bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, frame.size.height)];
        [bgImageView setBackgroundColor:[CustomNavBar hexChangeFloat:@"3e52b2" AndAlpha:1.0]];
        [self addSubview:bgImageView];
        
        _titleLabel  = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/4, app_y_offset, screenWidth/2, 44)];
        [_titleLabel setContentMode:UIViewContentModeCenter];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setFont:[UIFont fontWithName:@"AWL" size:19]];
        [self addSubview:_titleLabel];

        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setShowsTouchWhenHighlighted:NO];
        [_leftButton setFrame:CGRectMake(0, app_y_offset, 56, 44)];
        [_leftButton setImage:[UIImage imageNamed:@"ic_arrow_back_white"] forState:UIControlStateNormal];
//        _leftButton.showsTouchWhenHighlighted = YES;
        _leftButton.imageEdgeInsets = UIEdgeInsetsMake(6, 12, 6, 12);
        [_leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftButton];
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_rightButton  setShowsTouchWhenHighlighted:YES];
        [_rightButton setFrame:CGRectMake(screenWidth-56, app_y_offset, 56, 44)];
        [self addSubview:_rightButton];
        [_rightButton setHidden:YES];
        
    }
    return self;
}
-(void)setBackGroundColor:(float)red  andGreen:(float)green  andBlue:(float)blue  andAlpa:(float)alpa;{
    [bgImageView setBackgroundColor:[UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpa]];
}

-(void)setBackGroundColor:(UIColor*)color{
    [bgImageView setBackgroundColor:color];
}

-(void)leftButtonClick:(id)sender{
    [refrenceController.navigationController popViewControllerAnimated:YES];
}
-(id)initWithTitle:(NSString *)title withController:(UIViewController *)controller{
    app_y_offset = floor([[UIDevice currentDevice].systemVersion floatValue]) >= 7 ? 20 : 0;
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    self = [self initWithFrame:CGRectMake(0, 0, screenWidth, 44 + app_y_offset)];
    refrenceController = controller;
    if([refrenceController.navigationController.childViewControllers count]>1){
        [_leftButton setHidden:NO];
    }else {
        [_leftButton setHidden:YES];
    }
    [_titleLabel setText:title];
    return self;
}

-(void)setLeftButtonTarget:(id)target Selector:(SEL)selector Title:(NSString *)title{
    [_leftButton setHidden:NO];
    [_leftButton setImage:nil forState:UIControlStateNormal];
    [_leftButton setTitle:title forState:UIControlStateNormal];
    [_leftButton removeTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_leftButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

-(void)setRightButtonTarget:(id)target Selector:(SEL)selector Title:(NSString *)title{
    [_rightButton setHidden:NO];
    [_rightButton setTitle:title forState:UIControlStateNormal];
    [_rightButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}
-(void)setLeftButtonTarget:(id)target Selector:(SEL)selector Image:(UIImage *)image{
    [_leftButton setHidden:NO];
    if(image){
        [_leftButton setImage:image forState:UIControlStateNormal];
        [_leftButton setImage:image forState:UIControlStateHighlighted];
    }
    _leftButton.imageEdgeInsets = UIEdgeInsetsMake(6, 12, 6, 12);
    [_leftButton removeTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_leftButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

-(void)setRightButtonTarget:(id)target Selector:(SEL)selector Image:(UIImage *)image{
    [_rightButton setHidden:NO];
    if(image){
        [_rightButton setImage:image forState:UIControlStateNormal];
        [_rightButton setImage:image forState:UIControlStateHighlighted];
    }
    _rightButton.imageEdgeInsets = UIEdgeInsetsMake(6, 12, 6, 12);
    [_rightButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

-(void)setRightButtonTextColor:(UIColor *)color andFont:(int)font{
     [_rightButton setHidden:NO];
     [_rightButton setTitleColor:color forState:UIControlStateNormal];
     _rightButton.titleLabel.font=[UIFont systemFontOfSize:font];
}
-(void)setTitleLabelText:(NSString*)title{
    _titleLabel.text=title;
}
-(void)setTitleLabelTextColor:(UIColor*)color andFont:(int)font{
//    _titleLabel.font=[UIFont systemFontOfSize:font];
    _titleLabel.textColor=color;
}
-(void)setTitleImage:(UIImage*)image{
    UIImageView *titleImgView=[[UIImageView alloc] initWithFrame:CGRectMake(114, 12+10, 92, 21)];
    [titleImgView setBackgroundColor:[UIColor clearColor]];
    titleImgView.image=image;
    [self addSubview:titleImgView];
}
-(void)setRightButtonHiddOrShow:(BOOL)isShow{
    [_rightButton setHidden:!isShow];
}
-(void)setLeftButtonFrame:(CGRect)frame{
    [_leftButton setFrame:frame];
}
-(void)setRightButtonFrame:(CGRect)frame{
    [_rightButton setFrame:frame];
}


+ (UIColor *)hexChangeFloat:(NSString *)hexColor AndAlpha:(float)alpha{
    unsigned int redInt_, greenInt_, blueInt_;
    NSRange rangeNSRange_;
    rangeNSRange_.length = 2;  // 范围长度为2
    
    // 取红色的值
    rangeNSRange_.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]]
     scanHexInt:&redInt_];
    
    // 取绿色的值
    rangeNSRange_.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]]
     scanHexInt:&greenInt_];
    
    // 取蓝色的值
    rangeNSRange_.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]]
     scanHexInt:&blueInt_];
    if (alpha > 1.0f) {
        alpha = 1;
    }else if (alpha < 0.0f){
        alpha = 0;
    }
    return [UIColor colorWithRed:(float)(redInt_/255.0f)
                           green:(float)(greenInt_/255.0f)
                            blue:(float)(blueInt_/255.0f)
                           alpha:alpha];
}

@end
