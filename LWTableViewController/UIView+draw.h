//
//  UIView+draw.h
//  ZheJiang
//
//  Created by URoad on 16/1/26.
//  Copyright © 2016年 URoad. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIView (draw)
@property (nonatomic,copy)NSString* drawRadius;
@property (nonatomic,copy)NSString* drawLayer;
@property (nonatomic,assign)BOOL drawBottomLine;
@property (nonatomic,assign)BOOL themeColor;

-(void)addBottomLine;
-(void)addTopLine;
-(void)addleftLine;
-(void)addRightLine;
-(void)addNaviBottomLine;
-(void)drawBoardLayer;
-(void)addDisableLayer;
-(void)removeDisableLayer;
-(void)addBottomShadow:(BOOL)re;
@end
