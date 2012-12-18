//
//  RootViewController.m
//  Traval100
//
//  Created by admin on 12-12-17.
//  Copyright (c) 2012年 admin. All rights reserved.
//

#import "RootViewController.h"
#import "TicketBookingViewController.h"
#import "AccountViewController.h"
#import "AnnountcementViewController.h"
#import "SuggestionViewController.h"
#import "AboutUsViewController.h"
#import "RegistrationViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

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
	[self initframe];
}
-(void)initframe{
    _backimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    UIImage*image=[UIImage imageNamed:@"首页面背景.png"];
    _backimage.image=image;
    [self.view addSubview:_backimage];
    //    [_backimage release];
    // 123
    // 456
    for (int i=1; i<7; i++) {
        UIButton*bt=[[UIButton alloc]initWithFrame:CGRectMake(i==1?25:i==2?25:i==3?157:i==4?27:i==5?160:160, i==1?64:i==2?181:i==3?181:i==4?293:i==5?293:347, i==1?260:i==2?128:i==3?128:i==4?128:i==5?128:128, i==1?104:i==2?104:i==3?104:i==4?104:i==5?49:49)];
        [bt setBackgroundImage:[UIImage imageNamed:i==1?@"汽车票预定.png":i==2?@"帐户.png":i==3?@"公告.png":i==4?@"建议.png":i==5?@"关于我们.png":@"注册登录.png"] forState:UIControlStateNormal];
        bt.tag=10+i;
        [bt addTarget:self action:@selector(enterthenextinterface:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bt];
        [bt release];
        
    }
    
}
-(void)enterthenextinterface:(id)sender{
//    NSLog(@"111");
    UIButton*bu=(UIButton*)sender;
    switch (bu.tag) {
        case 11:{
           TicketBookingViewController*ticketbook=[[TicketBookingViewController alloc]init];
           [self.navigationController pushViewController:ticketbook animated:YES];
            [ticketbook release];
        }
            break;
        case 12:{
            AccountViewController*account=[[AccountViewController alloc]init];
            [self.navigationController pushViewController:account animated:YES];
        }
            break;
        case 13:{
            AnnountcementViewController*ann=[[AnnountcementViewController alloc]init];
            [self.navigationController pushViewController:ann animated:YES];
            
        }
            break;
        case 14:{
            SuggestionViewController*suggest=[[SuggestionViewController alloc]init];
            [self.navigationController pushViewController:suggest animated:YES];
        }
            break;
        case 15:{
            AboutUsViewController*aboutus=[[AboutUsViewController alloc]init];
            [self.navigationController pushViewController:aboutus animated:YES];
        }
            break;
        case 16:{
            RegistrationViewController*regist=[[RegistrationViewController alloc]init];
            [self.navigationController pushViewController:regist animated:YES];
        }
            break;
            
            
        default:
            break;
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)delloc{
    
    [_backimage release];
    [super delloc];
}
@end
