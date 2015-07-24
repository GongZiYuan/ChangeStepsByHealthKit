//
//  ViewController.m
//  ChangeStepsByHealthKit
//
//  Created by 赵远 on 15/7/24.
//  Copyright (c) 2015年 GongZiYuan. All rights reserved.
//

#import "ViewController.h"
#import "CustomNavBar.h"
#import <HealthKit/HealthKit.h>

@interface ViewController ()<UITextFieldDelegate>{
    UILabel *testLab1;
    UITextField *bushuTextField;
}

@property (nonatomic, strong) HKHealthStore *healthStore;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CustomNavBar *titleBar = [[CustomNavBar alloc] initWithTitle:@"改变步数" withController:self];
    [self.view addSubview:titleBar];
    
    testLab1 = [[UILabel alloc] initWithFrame:CGRectMake(3, titleBar.frame.size.height + 10, 100, 30)];
    testLab1.text = @"请输入步数";
    [self.view addSubview:testLab1];
    
    bushuTextField = [[UITextField alloc] initWithFrame:CGRectMake(108 , testLab1.frame.origin.y, 100, 30)];
    [bushuTextField setFont:[UIFont systemFontOfSize:16]];
    [bushuTextField setBorderStyle:UITextBorderStyleNone];
    [bushuTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [bushuTextField setReturnKeyType:UIReturnKeyDone];
    [bushuTextField setBackgroundColor:[UIColor grayColor]];
    bushuTextField.delegate = self;
    [bushuTextField setPlaceholder:@"步数"];
    [self.view addSubview:bushuTextField];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 160, 80, 40)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 1;
    [btn addTarget:self action:@selector(changeTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    if ([HKHealthStore isHealthDataAvailable]) {
        NSSet *writeDataTypes = [self dataTypesToWrite];
        NSSet *readDataTypes = [self dataTypesToRead];
        
        self.healthStore = [[HKHealthStore alloc] init];
        [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
            if (!success) {
                NSLog(@"fail");
            }
        }];
    }

}

-(void)changeTest{
    if (bushuTextField.text && ![bushuTextField.text isEqualToString:@""]) {
        [self recordWeight:[bushuTextField.text doubleValue]];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入步数" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        [alert show];
    }
}


#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [bushuTextField resignFirstResponder];
}


- (NSSet *)dataTypesToWrite {
    HKQuantityType *stepType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    return [NSSet setWithObject:stepType];
}

- (NSSet *)dataTypesToRead {
    HKQuantityType *stepType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    return [NSSet setWithObjects:stepType , nil];
}


-(void)recordWeight:(double)step{
    HKQuantityType *stepType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    if ([HKHealthStore isHealthDataAvailable] ) {
        HKQuantity *stepQuantity = [HKQuantity quantityWithUnit:[HKUnit countUnit] doubleValue:step];
        HKQuantitySample *stepSample = [HKQuantitySample quantitySampleWithType:stepType quantity:stepQuantity startDate:[NSDate date] endDate:[NSDate date]];
        __block typeof(self) weakSelf = self;
        [self.healthStore saveObject:stepSample withCompletion:^(BOOL success, NSError *error) {
            if (success) {
                __block typeof(weakSelf) strongSelf = weakSelf;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"步数已加上" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
                    [alert show];
                    
                    strongSelf -> bushuTextField.text = @"";
                });
                
                NSLog(@"The data has print");
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加步数失败" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
                [alert show];
                NSLog(@"The error is %@",error);
            }
        }];
    }
}


-(void)healthTest{
    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
    [healthStore requestAuthorizationToShareTypes:nil  readTypes:nil completion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: %@. If you're using a simulator, try it on a device.", error);
            return;
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
        });
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
