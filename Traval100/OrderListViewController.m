//
//  OrderListViewController.m
//  Traval100
//
//  Created by sun zhe on 12-12-17.
//  Copyright (c) 2012年 admin. All rights reserved.
//

#import "OrderListViewController.h"
#import "PassengerInfoViewController.h"
@interface OrderListViewController ()

@end

@implementation OrderListViewController

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
    self.title=@"班次列表";
    [self initinface];
	
}
-(void)initinface{
    UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    [img setImage:[UIImage imageNamed:@"背景.png"]];
    _table=[[UITableView alloc]initWithFrame:CGRectMake(0, 45, 320, 300)];
    _table.delegate=self;
    _table.dataSource=self;
    [self.view addSubview:_table];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *	cell;
    cell = [_table dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"] autorelease];
        assert(cell != nil);
    }

    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *row=indexPath;
    if (row) {
        PassengerInfoViewController*info=[[PassengerInfoViewController alloc]init];
        [self.navigationController pushViewController:info animated:YES];
    }
    
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
