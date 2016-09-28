//
//  ViewController.m
//  LWTableViewController
//
//  Created by 吴狄 on 16/9/28.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "HederView.h"
#import "UILabel+extion.h"
#import "UIView+draw.h"
#import "UIView+GaosutongExtension.h"
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>
#define LW_SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define LW_SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic,retain)UITableView *tbv;
@property (nonatomic,retain)UIView *naviV;
@property (nonatomic,retain)UIImageView *bgImg;

@end

@implementation ViewController

#pragma  mark --LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self loadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
#pragma mark--UI
-(void)initUI{
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.tbv=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, LW_SCREENWIDTH, LW_SCREENHEIGHT-64) style:UITableViewStylePlain];
    [self.view addSubview:self.tbv];
    self.tbv.backgroundColor=[UIColor clearColor];
    self.tbv.delegate=self;
    self.tbv.dataSource=self;
    self.tbv.tableFooterView=[UIView new];
    HederView *headerV=[[HederView alloc]initWithFrame:CGRectMake(0, 0, LW_SCREENWIDTH, 44)];
    self.tbv.tableHeaderView=headerV;
    [self.tbv registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tbv registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TableViewCell"];
    self.tbv.separatorColor=[UIColor clearColor];
    self.naviV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, LW_SCREENWIDTH, 64)];
    [self.view addSubview:self.naviV];
    
    UIImageView *left=[[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 30, 30)];
    left.image=[UIImage imageNamed:@"cm2_act_view_btn_back_prs"];
    left.contentMode=UIViewContentModeCenter;
    [self.naviV addSubview:left];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(70, 20, LW_SCREENWIDTH-140, 40)];
    lab.text=@"歌单";
    lab.textAlignment=NSTextAlignmentCenter;
    lab.textColor=[UIColor whiteColor];
    [self.naviV addSubview:lab];
    
    self.bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, LW_SCREENWIDTH, 170+64+44)];
    self.bgImg.image=[UIImage imageNamed:@"1706442046308356.jpg"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        UIImage*img=[self boxblurImageWithBlur:1 with:self.bgImg.image];
        if (img) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setImgWithFadeAnimationUIImage:img];
            });
        }
        
    });
    [self.view insertSubview:self.bgImg belowSubview:self.tbv];
    
    
    
}
#pragma mark --Data
-(void)loadData{
    
}
#pragma mark --Action


#pragma mark --Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.0;
    }
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.4;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        UIView  *v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, LW_SCREENWIDTH, 40)];
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, LW_SCREENWIDTH-50, 40)];
        lab.text=@"播放全部(共32首)";
        [v addSubview:lab];
        v.backgroundColor=[UIColor whiteColor];
        v.drawBottomLine=YES;
        [v addTopLine];
        return v;
        
        
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 170;
    }else{
        return 44;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return 30;
    }
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text=[NSString stringWithFormat:@"这是第%ld行",indexPath.row+1];
    return cell;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset=scrollView.contentOffset.y;
    if (offset>=0) {
        if (offset>214) {
            self.bgImg.top_gst=-214;
        }else{
        self.bgImg.top_gst=-offset;
        }
    }else{
        CGFloat count=(278-offset)/278;
        
        self.bgImg.frame=CGRectMake(-(LW_SCREENWIDTH *count-LW_SCREENWIDTH)/2, 0, LW_SCREENWIDTH*count, 278*count);
        
    }
    NSLog(@"%lf",offset);
}
#pragma mark --Other
-(UIImage *)boxblurImageWithBlur:(CGFloat)blur  with:(UIImage *)image{
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1); // convert to jpeg
    UIImage* destImage = [UIImage imageWithData:imageData];
    
    
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = destImage.CGImage;
    
    
    vImage_Buffer inBuffer, outBuffer;
    
    vImage_Error error;
    
    void *pixelBuffer;
    
    
    //create vImage_Buffer with data from CGImageRef
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //create vImage_Buffer for output
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    // Create a third buffer for intermediate processing
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //perform convolution
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
}

-(void)setImgWithFadeAnimationUIImage:(UIImage *)image{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 0.5f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.bgImg.layer addAnimation:transition forKey:nil];
    self.bgImg.image=image;
    
}
@end
