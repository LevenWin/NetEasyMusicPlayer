//
//  UILabel+extion.m
//  LWTableViewController
//
//  Created by 吴狄 on 16/9/28.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "UILabel+extion.h"

@implementation UILabel (extion)
-(void)setTextColor:(UIColor *)color range:(NSRange)range{
    NSMutableAttributedString *attr=[[NSMutableAttributedString alloc]initWithString:self.text];
    [attr addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, self.text.length)];
    self.attributedText=attr;
    
}
-(void)setTextFont:(UIFont *)font range:(NSRange)range{
    NSMutableAttributedString *attr=[[NSMutableAttributedString alloc]initWithString:self.text];
    [attr addAttribute:NSFontAttributeName value:font range:range];
    [attr addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, self.text.length)];
    self.attributedText=attr;
    
}
@end
