//
//  MoreSelectCell.h
//  UITabelviewMoreSelection
//
//  Created by 连帅帅 on 2018/9/30.
//  Copyright © 2018年 连帅帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreSelectCell : UITableViewCell
@property(nonatomic,weak)UILabel * titleLabel;
/**
 cell初始化
 */
+(instancetype)cellWithtableView:(UITableView *)tableview;
@end
