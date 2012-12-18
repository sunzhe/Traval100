//
//  AboutUsViewController.m
//  Traval100
//
//  Created by admin on 12-12-17.
//  Copyright (c) 2012年 admin. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

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
    self.title=@"关于我们";
    for (int i=1; i<3; i++) {
        UIImage*image=[UIImage imageNamed:i==1?@"背景.png":@"关于我们logo.png"];
        UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(i==1?0:22, i==1?0:32,i==1? 320:237,i==1?480:66)];
        [img setImage:image];
        [self.view addSubview:img];
        [img release];

    }
        

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
