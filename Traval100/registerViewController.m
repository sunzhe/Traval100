//
//  registerViewController.m
//  Traval100
//
//  Created by admin on 12-12-26.
//  Copyright (c) 2012年 admin. All rights reserved.
//

#import "registerViewController.h"
#import "DDURLConnection.h"
@interface registerViewController ()

@end

@implementation registerViewController

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
    self.title=@"用户注册";
    UIImage*image=[UIImage imageNamed:@"背景.png"];
    UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    [img setImage:image];
    [self.view addSubview:img];
    [img release];
    [self initframe];
    // Do any additional setup after loading the view from its nib.
}
-(void)initframe{
    UIImage*image=[UIImage imageNamed:@"选择框中部.png"];
    UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(20, 70, 275, 250)];
    [img setImage:image];
    [self.view addSubview:img];
    [img release];
    UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(22, 40, 120, 30)];
    [lab setText:@"用户注册"];
    [lab setBackgroundColor:[UIColor clearColor]];
    [lab setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:lab];
    [lab release];
    for (int i=0; i<5; i++) {
        UILabel*la=[[UILabel alloc]initWithFrame:CGRectMake(i==1?20:i==2?35:i==3?6:35, i==1?21:i==2?68:i==3?110:201,i==1?55:i==2?45:i==3?68:36, i==1?17:i==2?17:i==3?17:17)];
        [la setText:i==1?@"手机号":i==2?@"密 码":i==3?@"确认密码":@"姓名"];
        [img addSubview:la];
        [la release];
    }
    for (int j=0; j<5; j++) {
        UITextField*tf=[[UITextField alloc]initWithFrame:CGRectMake(j==1?74:j==2?74:j==3?74:74,j==1?17:j==2?62:j==3?106:198, j==1?181:j==2?181:j==3?181:181, j==1?30:j==2?30:j==3?30:30)];
        [tf setBorderStyle:UITextBorderStyleRoundedRect];
        tf.tag=10+j;
//        [tf setEnabled:YES];
        [img addSubview:tf];
        [tf release];
    }
    UIButton*btton=[[UIButton alloc]initWithFrame:CGRectMake(107, 356, 92, 27)];
    [btton setBackgroundImage:[UIImage imageNamed:@"注册.png"] forState:UIControlStateNormal];
    [btton addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btton];
    [btton release];
}
-(void)regist{
    NSLog(@"1");

//   NSString*url=@"http://mobileservice.lvtu100.com/UserJsonService/AddUser?phone=13917097452&password=123456&repassword=123456&sex=1&username=房书雨";
    NSString*url=@"http://mobileservice.lvtu100.com/ScheduleJsonService/GetCorpList";
    DDURLConnection*connect=[[DDURLConnection alloc]init];
    connect.delegate=self;
    [connect connectToURL:url ];
    
}
- (void)dURLConnection:(DDURLConnection *)connection didFinishLoadingJSONValue:(NSDictionary *)json {
    NSDictionary*dic=json;
	
	NSLog(@"dic%@",dic);
    
}

// When request failed
- (void)dURLConnection:(DDURLConnection *)connection didFailWithError:(NSError *)error {
    NSError*err=error;
	NSLog(@"errerr%@",err);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
