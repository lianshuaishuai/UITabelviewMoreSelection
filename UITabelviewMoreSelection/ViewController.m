//
//  ViewController.m
//  UITabelviewMoreSelection
//
//  Created by 连帅帅 on 2018/9/30.
//  Copyright © 2018年 连帅帅. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "MoreSelectCell.h"
#import "model.h"
@interface ViewController ()<UITableViewDelegate ,UITableViewDataSource>

@property(nonatomic,strong)UITableView
*tableView;
@property(nonatomic,strong)NSMutableArray<model *>
*dataArray;
@property(nonatomic,strong)NSMutableArray<model *>
*selectArray;//选中的按钮 
@end

@implementation ViewController

#pragma mark--lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    //添加导航栏 编辑按钮
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarItemClick:)];
   
     UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(delete)];
    self.navigationItem.rightBarButtonItems = @[item1,item2];
    //添加tabelview
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
    //下载数据
    for (int i = 0; i < 10; i++) {
        
        model * m = [[model alloc]init];
        m.text = [NSString stringWithFormat:@"%d",i];
        [self.dataArray addObject:m];
    }
    
    [self.tableView reloadData];
}

#pragma mark-- private

#pragma mark-- even response
//编辑按钮点击事件
- (void)rightBarItemClick:(UIBarButtonItem *)item{
    if ([item.title isEqualToString:@"编辑"]) {
       
        item.title = @"取消";
        [self.tableView setEditing:YES animated:YES];
       
    }else{
        item.title = @"编辑";
        [self.tableView setEditing:NO animated:YES];
       
    }
    
}
//删除按钮点击事件
-(void)delete{
    
    if (!self.selectArray) {
        
        return;
    }
    [self.dataArray removeObjectsInArray:self.selectArray];
   
    [self.selectArray removeAllObjects];
    [self.tableView deleteRowsAtIndexPaths:[self.tableView indexPathsForSelectedRows] withRowAnimation:UITableViewRowAnimationFade];
    
    /** 数据清空情况下取消编辑状态*/
    if (self.dataArray.count == 0) {
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        [self.tableView setEditing:NO animated:YES];
    }
}

#pragma mark--UITableViewDelegate ,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoreSelectCell *cell =[MoreSelectCell cellWithtableView:tableView];
    cell.titleLabel.text = self.dataArray[indexPath.row].text;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    model * m = self.dataArray[indexPath.row];
    m.isSelect = !m.isSelect;
    if (m.isSelect) {
        
        [self.selectArray addObject:m];
    }else{
        
        [self.selectArray removeObject:m];
    }
    if (tableView.isEditing) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}


#pragma mark--getters and stters
//懒加载tabelview
-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableView.estimatedRowHeight           = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.delegate                     = self;
        _tableView.dataSource                   = self;
        _tableView.allowsSelection              = YES;//允许多选
        _tableView.allowsMultipleSelectionDuringEditing = YES;//允许编辑的时候选中
        _tableView.separatorInset = UIEdgeInsetsZero;//分割线距离左右距离
    }
    return _tableView;
}
//懒加载数组
-(NSMutableArray<model *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

-(NSMutableArray<model *> *)selectArray{
  
    if (!_selectArray) {
        
        _selectArray = [NSMutableArray new];
    }
    return _selectArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
