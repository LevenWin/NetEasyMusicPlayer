//
//  UIView+draw.m
//  ZheJiang
//
//  Created by URoad on 16/1/26.
//  Copyright © 2016年 URoad. All rights reserved.
//

#import "UIView+draw.h"
#define LineColor [UIColor colorWithRed:0.7806 green:0.7806 blue:0.7806 alpha:1.0]
@implementation UIView (draw)
@dynamic drawLayer,drawRadius;
-(void)addBottomLine{
    UIView*v=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    v.userInteractionEnabled=false;
    v.backgroundColor=LineColor;
    
    v.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    
    [self addSubview:v];
    [self insertSubview:v atIndex:0];

}
-(void)addTopLine{
    UIView*v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    v.userInteractionEnabled=false;
    v.backgroundColor=LineColor;
    v.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:v];

}
-(void)addNaviBottomLine{
    UIView*v=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    v.userInteractionEnabled=false;
    v.backgroundColor=[UIColor colorWithWhite:0.307 alpha:1.000];
    v.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    
    [self addSubview:v];
    [self insertSubview:v atIndex:0];

}
-(void)addleftLine{
    UIView*v=[[UIView alloc]initWithFrame:CGRectMake(0,0,0.5, self.frame.size.height)];
    v.userInteractionEnabled=false;
    v.backgroundColor=LineColor;
    v.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin;
    
    [self addSubview:v];
    [self insertSubview:v atIndex:0];

}
-(void)addRightLine{
    UIView*v=[[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width-0.5,0 ,0.5, self.frame.size.height)];
    v.userInteractionEnabled=false;
    v.backgroundColor=LineColor;
    v.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    
    [self addSubview:v];
    [self insertSubview:v atIndex:0];

}
/**
 *  draw
 */
-(void)drawBoardLayer{
    self.layer.borderColor=[UIColor clearColor].CGColor;
    self.layer.borderWidth=1;
    self.layer.cornerRadius=4;
    self.layer.masksToBounds=YES;
}
-(void)setDrawRadius:(NSString *)drawRadius{
    [self drawBoardLayer];
    self.layer.cornerRadius=drawRadius.integerValue;
}
-(void)setDrawLayer:(NSString *)drawLayer{
    self.layer.borderColor=[UIColor colorWithWhite:0.823 alpha:1.000].CGColor;
    self.layer.borderWidth=0.5;
    
}
-(void)addDisableLayer{

    UIView *cover=[[UIView alloc]initWithFrame:self.bounds];
    cover.backgroundColor=[UIColor lightGrayColor];
    cover.alpha=0.3;
    [self addSubview:cover];
    self.layer.masksToBounds=YES;
    self.userInteractionEnabled=NO;
}
-(void)removeDisableLayer{
    UIView *cover=self.subviews.lastObject;
    [cover removeFromSuperview];
    self.userInteractionEnabled=YES;
}
-(void)setDrawBottomLine:(BOOL)drawBottomLine{
    if (drawBottomLine) {
        [self addBottomLine];
    }else{
        [self addTopLine];
    }
}
-(void)addBottomShadow:(BOOL)re{
    if (re) {
        self.layer.shadowColor=[UIColor colorWithRed:0.734 green:0.734 blue:0.734 alpha:1.0].CGColor;
        self.layer.shadowOffset=CGSizeMake(-4, 4);
        self.layer.shadowOpacity=0.9;
        self.layer.shadowRadius=3;
    }else{
        self.layer.shadowColor=[UIColor colorWithRed:0.734 green:0.734 blue:0.734 alpha:1.0].CGColor;
        self.layer.shadowOffset=CGSizeMake(-4, 4);
        self.layer.shadowOpacity=0.9;
        self.layer.shadowRadius=3;


    }
}

@end
