//
//  BackpasswordViewController.m
//  Traval100
//
//  Created by admin on 12-12-26.
//  Copyright (c) 2012年 admin. All rights reserved.
//

#import "BackpasswordViewController.h"

@interface BackpasswordViewController ()

@end

@implementation BackpasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"找回密码";
    UIImage*image=[UIImage imageNamed:@"背景.png"];
    UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    [img setImage:image];
    [self.view addSubview:img];
    [img release];
    [self frame];
    // Do any additional setup after loading the view from its nib.
}
-(void)frame{
    UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(30, 82, 120, 20)];
    [lab setText:@"找回我的密码"];
    [lab setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:lab];
    [lab release];
    UITextField*tf=[[UITextField alloc] initWithFrame:CGRectMake(30, 110, 256, 35)];
    [tf setText:@"登陆手机号"];
    [tf setTextColor:[UIColor grayColor]];
    [tf setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:tf];
    [tf release];
    UIButton*bt=[[UIButton alloc]initWithFrame:CGRectMake(110, 166, 110, 30)];
    [bt setBackgroundImage:[UIImage imageNamed:@"找回密码.png"] forState:UIControlStateNormal];
    [self.view addSubview:bt];
    [bt release];
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
