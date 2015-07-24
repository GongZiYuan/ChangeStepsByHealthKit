//
//  CustomNavBar.h
//  TaoYouHui
//
//  Created by Etouch on 13-3-26.
//
//

#import <UIKit/UIKit.h>

@interface CustomNavBar : UIView{
    
 @public
    UIImageView      *bgImageView;            //navigationView 的背景
    __weak UIViewController *refrenceController;     //当前使用该navigationView的controller，调用的话一般为self
    float app_y_offset;
    float screenWidth;
    
}
@property(nonatomic,strong) UILabel *titleLabel; //navigationView 的标题
@property(nonatomic,strong) UIButton *leftButton; //navigationView 的左边按钮（大多数情况下是返回按钮）
@property(nonatomic,strong) UIButton *rightButton;  //navigationView 的右边按钮


/**
 *  初始化navigationView
 *
 *  @param title      标题（titleLabel.text）
 *  @param controller 当前的controller
 *
 *  @return id（navigationView）
 */
-(id)initWithTitle:(NSString *)title withController:(UIViewController *)controller;
/**
 *  设置LeftButton的点击事件,图片等属性
 *
 *  @param target   target
 *  @param selector selector
 *  @param image    image
 */
-(void)setLeftButtonTarget:(id)target Selector:(SEL)selector Image:(UIImage *)image;
/**
 *  设置RightButton的点击事件,图片等属性
 *
 *  @param target   target
 *  @param selector selector
 *  @param image    image
 */
-(void)setRightButtonTarget:(id)target Selector:(SEL)selector Image:(UIImage *)image;
/**
 *  设置LeftButton的标题，点击事件等属性
 *
 *  @param target   target
 *  @param selector selector
 *  @param title    title
 */
-(void)setLeftButtonTarget:(id)target Selector:(SEL)selector Title:(NSString *)title;
/**
 *  设置RightButton的标题，点击事件等属性
 *
 *  @param target   target
 *  @param selector selector
 *  @param title    title
 */
-(void)setRightButtonTarget:(id)target Selector:(SEL)selector Title:(NSString *)title;
/**
 *  设置右边按钮的title的颜色字体
 *
 *  @param color color
 *  @param font  font
 */
-(void)setRightButtonTextColor:(UIColor *)color andFont:(int)font;
/**
 *  设置titleLabel的text
 *
 *  @param title title
 */
-(void)setTitleLabelText:(NSString*)title;
/**
 *  设置titleLabel的背景图片（一般是logo）
 *
 *  @param image 背景图片
 */
-(void)setTitleImage:(UIImage*)image;
/**
 *  是否显示RightButton
 *
 *  @param isShow isShow
 */
-(void)setRightButtonHiddOrShow:(BOOL)isShow;
/**
 *  设置LeftButton的frame
 *
 *  @param frame frame
 */
-(void)setLeftButtonFrame:(CGRect)frame;
/**
 *  设置LeftButton的frame
 *
 *  @param frame frame
 */
-(void)setRightButtonFrame:(CGRect)frame;
/**
 *  设置titleLabel的text的颜色字体
 *
 *  @param color color
 *  @param font  font
 */
-(void)setTitleLabelTextColor:(UIColor*)color andFont:(int)font;
/**
 *  设置背景图片的颜色
 *
 *  @param red   red
 *  @param green green
 *  @param blue  blue
 *  @param alpa  alpa 
 */
-(void)setBackGroundColor:(float)red  andGreen:(float)green  andBlue:(float)blue  andAlpa:(float)alpa;

-(void)setBackGroundColor:(UIColor*)color;

@end
