//
//  AccountViewController.m
//  Traval100
//
//  Created by admin on 12-12-17.
//  Copyright (c) 2012年 admin. All rights reserved.
//

#import "AccountViewController.h"
#import "BackpasswordViewController.h"
#import "registerViewController.h"
@interface AccountViewController ()

@end

@implementation AccountViewController

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
    self.title=@"用户登陆";
    UIImage*image=[UIImage imageNamed:@"背景.png"];
    UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    [img setImage:image];
    [self.view addSubview:img];
    [img release];
    [self initframe];
	// Do any additional setup after loading the view.
}
-(void)initframe{
    UIImage*image=[UIImage imageNamed:@"选择框中部.png"];
    UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(20, 70, 275, 112)];
    [img setImage:image];
    [self.view addSubview:img];
    [img release];
    UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(22, 40, 120, 30)];
    [lab setText:@"用户登陆"];
    [lab setBackgroundColor:[UIColor clearColor]];
    [lab setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:lab];
    [lab release];
    for (int i=0; i<2; i++) {
        UILabel*la=[[UILabel alloc]initWithFrame:CGRectMake(i==1?35:35, i==1?90:138, i==1?37:37, i==1?21:21)];
        [la setText:i==1?@"手机":@"密码"];
        [self.view addSubview:la];
        [la release];
        UITextField*txt=[[UITextField alloc]initWithFrame:CGRectMake(i==1?78:78, i==1?90:138, i==1?200:200, i==1?26:26)];
        txt.tag=10+i;
        [txt setBorderStyle:UITextBorderStyleRoundedRect];
        [self.view addSubview:txt];
        [txt release];
    }
    for(int j=0;j<4;j++){
        UIButton* bt=[[UIButton alloc]initWithFrame:CGRectMake(j==1?106:j==2?46:46, j==1?222:j==2?285:325, j==1?90:j==2?213:213, j==1?28:j==2?28:28)];
        [bt setBackgroundImage:[UIImage imageNamed:j==1?@"登录.png":j==2?@"忘记密码.png":@"没有账号.png"] forState:UIControlStateNormal];
        bt.tag=20+j;
        [bt addTarget:self action:@selector(btclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bt];
        [bt release];
        
    }

}
-(void)btclick:(id)sender{
    UIButton *btt=(UIButton*)sender;
    switch (btt.tag) {
        case 21:{
            NSLog(@"11");
        }
            break;
        case 22:{
            NSLog(@"22");
            BackpasswordViewController*back=[[BackpasswordViewController alloc]init];
            [self.navigationController pushViewController:back animated:YES];
            [back release];
        }
            break;
        case 23:{
            //            NSLog(@"33");
            registerViewController*regist=[[registerViewController alloc]init];
            [self.navigationController pushViewController:regist animated:YES];
            [regist release];
            
        }
            break;
        default:
            break;
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITextField*tf=(UITextField*)[self.view viewwithtag:11];
    [tf resignFirstResponder];
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
