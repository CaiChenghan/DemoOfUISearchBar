//
//  ViewController.m
//  DemoOfUISearchBar
//
//  Created by 蔡成汉 on 15/2/26.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    UISearchBar *mySearchBar;
    UITableView *myTableView;
    NSMutableArray *dataArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UISearchBar";
    
    if ([[UIDevice currentDevice] systemVersion].floatValue>=7.0)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    dataArray = [NSMutableArray arrayWithObjects:@"123",@"41231",@"41341",@"3214235",@"1241235",@"152341",@"52441",@"5123414",@"34564",@"45672",@"41415345",@"52464134",@"412341543",@"124135", nil];
    
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    [self.view addSubview:myTableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[dataArray objectAtIndex:indexPath.row]];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]init];
    if (mySearchBar == nil)
    {
        mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    }
    mySearchBar.delegate = self;
    mySearchBar.placeholder = @"搜索";
    [headerView addSubview:mySearchBar];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //进行处理，
    mySearchBar.showsCancelButton = YES;
    for(id cc in [searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
            NSLog(@"替换完成");
        }
    }
    [dataArray removeAllObjects];
    [myTableView reloadData];
    [mySearchBar becomeFirstResponder];
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    if (mySearchBar.text.length == 0)
    {
        //加载原有数据
        mySearchBar.showsCancelButton = NO;
        dataArray = [NSMutableArray arrayWithObjects:@"123",@"41231",@"41341",@"3214235",@"1241235",@"152341",@"52441",@"5123414",@"34564",@"45672",@"41415345",@"52464134",@"412341543",@"124135", nil];
        [myTableView reloadData];
    }
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0)
{
    if ([text isEqualToString:@"\n"])
    {
        [mySearchBar resignFirstResponder];
        
        //执行搜索
        mySearchBar.showsCancelButton = NO;
        mySearchBar.text = @"";
        
        dataArray = [NSMutableArray arrayWithObjects:@"123",@"41231",@"41341",@"3214235",@"1241235",@"152341",@"52441",@"5123414",@"34564",@"45672",@"41415345",@"52464134",@"412341543",@"124135", nil];
        [myTableView reloadData];
    }
    return YES;
}

/**
 *  键盘的搜索按钮被点击 -- 执行搜索
 *
 *  @param searchBar 键盘的搜索按钮被点击
 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    dataArray = [NSMutableArray arrayWithObjects:@"123",@"41231",@"41341",@"3214235",@"1241235",@"152341",@"52441",@"5123414",@"34564",@"45672",@"41415345",@"52464134",@"412341543",@"124135", nil];
    [myTableView reloadData];
    mySearchBar.showsCancelButton = NO;
    [mySearchBar resignFirstResponder];
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2)
{
    
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope NS_AVAILABLE_IOS(3_0)
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
