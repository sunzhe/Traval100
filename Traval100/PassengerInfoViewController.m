//
//  PassengerInfoViewController.m
//  Traval100
//
//  Created by sun zhe on 12-12-17.
//  Copyright (c) 2012年 admin. All rights reserved.
//

#import "PassengerInfoViewController.h"

@interface PassengerInfoViewController ()

@end

@implementation PassengerInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title=@"乘客信息";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
