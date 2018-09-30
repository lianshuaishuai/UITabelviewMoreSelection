//
//  MoreSelectCell.m
//  UITabelviewMoreSelection
//
//  Created by 连帅帅 on 2018/9/30.
//  Copyright © 2018年 连帅帅. All rights reserved.
//

#import "MoreSelectCell.h"
#import "Masonry.h"
@implementation MoreSelectCell

+(instancetype)cellWithtableView:(UITableView *)tableview
{
    
    static NSString *ID = @"MoreSelectCell";
    MoreSelectCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        
        cell = [[MoreSelectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        //改变选中状态下的cell的颜色
        cell.selectedBackgroundView = [UIView new];
    }
    return cell;
}
//重写布局
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
        UILabel * titleLabel = [UILabel new];
        _titleLabel = titleLabel;
     
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.bottom.offset(0);
            make.left.offset(20);
        }];
       
    }
    return self;
}

-(void)layoutSubviews{
  
    for (UIControl *control in self.subviews){
        
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            
            for (UIView *v in control.subviews)
                
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    
                    UIImageView *img=(UIImageView *)v;
                    if (self.selected) {
                        
                        img.image=[UIImage imageNamed:@"TDselected"];
                    }else
                    {
                        
                        img.image=[UIImage imageNamed:@"TDnormal"];
                    }
                }
            }
        }
    }
    [super layoutSubviews];
}

//适配第一次图片为空的情况
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    for (UIControl *control in self.subviews){
        
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            
            for (UIView *v in control.subviews)
            {
                
                if ([v isKindOfClass: [UIImageView class]]) {
                    
                    UIImageView *img=(UIImageView *)v;
                    if (!self.selected) {
                        
                        img.image=[UIImage imageNamed:@"TDnormal"];
                    }
                }
            }
        }
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
