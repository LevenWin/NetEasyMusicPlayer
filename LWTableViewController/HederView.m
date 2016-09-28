//
//  HederView.m
//  LWTableViewController
//
//  Created by 吴狄 on 16/9/28.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "HederView.h"

@interface HederView(){
    UISearchBar *searchBar;
}

@end
@implementation HederView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
-(void)setup{
    searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width-50, 30)];
    searchBar.searchBarStyle=UISearchBarStyleMinimal;
    searchBar.barStyle=UIBarStyleDefault;
    [self addSubview:searchBar];
    searchBar.placeholder=@"搜索歌单内歌曲";
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"排序" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:15];
    btn.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-40,3, 35, 35);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:btn];
}
@end
