//
//  TicketBookingViewController.m
//  Traval100
//
//  Created by admin on 12-12-17.
//  Copyright (c) 2012年 admin. All rights reserved.
//

#import "TicketBookingViewController.h"
#import "OrderListViewController.h"
@interface TicketBookingViewController ()

@end

@implementation TicketBookingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"车票查询";
    UIImage*image=[UIImage imageNamed:@"背景.png"];
    UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    [img setImage:image];
    [self.view addSubview:img];
    [img release];
    _tickcheck=[[UIButton alloc]initWithFrame:CGRectMake(65, 219, 191, 30)];
    [_tickcheck setBackgroundImage:[UIImage imageNamed:@"车票查询.png"] forState:UIControlStateNormal];
    [_tickcheck addTarget:self action:@selector(tickcheck) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_tickcheck];
    [_tickcheck release];
                                                                 
                                                               
//    self.navigationController
////    self.navigationBar.hidden=NO;
//	UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    self.navigationItem.leftBarButtonItem=left;
}
-(void)tickcheck{
    OrderListViewController*order=[[OrderListViewController alloc]init];
    [self.navigationController pushViewController:order animated:YES];
	
//	NSArray *array=self.navigationController.viewControllers;
//	RootViewController *root=[array objectAtIndex:[array count]-2];
	
	
	
//	[self.navigationController popViewControllerAnimated:YES];
	
	
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
