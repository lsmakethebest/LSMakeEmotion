
//
//  LSAddImageView.m
//  transparentExpression
//
//  Created by togo on 2017/6/8.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import "LSAddImageView.h"
#import "ColorAndFont.h"
#import "UIView+LSExtension.h"
#import "Masonry.h"
#import "LSAddLabel.h"
@interface LSAddImageView ()

@property (nonatomic,weak) UIImageView *move;

@end

@implementation LSAddImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        self.backgroundColor=[UIColor clearColor];
        //        self.layer.borderWidth=0.5;
        //        self.layer.borderColor=[UIColor orangeColor].CGColor;
    }
    return self;
}

-(void)setupViews
{
    
    UIImageView *imageView=[[UIImageView alloc]init];

    imageView.backgroundColor=[UIColor clearColor];
    //    label.textAlignment=NSTextAlignmentCenter;
    //    label.borderStyle=UITextBorderStyleNone;
    imageView.layer.borderWidth=0.5;
    imageView.layer.borderColor= RGB(0x6FDBF1).CGColor;
    
    self.imageView=imageView;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).inset(14);
        
    }];
    
    
    UIImageView *move=[[UIImageView alloc]init];
    move.userInteractionEnabled=YES;
    UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    [move addGestureRecognizer:panGesture];
    
    [move setImage:[UIImage imageNamed:@"yidong"]];
    [self addSubview:move];
    self.move=move;
    
    [move mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(2*LSMargin);
        make.right.and.bottom.mas_equalTo(0);
    }];
    
    
    UIPanGestureRecognizer *moveGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveGesture:)];
    [self addGestureRecognizer:moveGesture];
    
}

-(void)moveGesture:(UIPanGestureRecognizer*)gesture
{
    
    CGPoint point= [gesture translationInView:gesture.view];
    NSLog(@"%@",NSStringFromCGPoint(point));
    [gesture setTranslation:CGPointZero inView:gesture.view];
    
    CGFloat x=self.x+point.x;
    if (x<=-LSMargin) {
        x=-LSMargin;
    }
    
    if (x+self.width-LSMargin>self.superview.width) {
        x=self.superview.width-self.width+LSMargin;
    }
    
    CGFloat y=self.y+point.y;
    if (y<=-LSMargin) {
        y=-LSMargin;
    }
    
    if (y+self.height-LSMargin>self.superview.height) {
        y=self.superview.height-self.height+LSMargin;
    }
    NSLog(@"x=%lf   y==%lf",x,y);
    self.x=x;
    self.y=y;
}


-(void)handlePanGesture:(UIPanGestureRecognizer*)gesture
{
    CGPoint point= [gesture translationInView:gesture.view];
    NSLog(@"%@",NSStringFromCGPoint(point));
    [gesture setTranslation:CGPointZero inView:gesture.view];
    
    CGFloat width=self.width+point.x;
    if (width<=50+2*LSMargin) {
        width=50+2*LSMargin;
    }
    
    if (self.x+width>self.superview.width) {
        width=self.superview.width-self.x;
    }
    
    CGFloat height=self.height+point.y;
    if (height<=40+2*LSMargin) {
        height=40+2*LSMargin;
    }
    
    if (self.y+height>self.superview.height) {
        height=self.superview.height-self.y;
    }
    
    
    NSLog(@"width=%lf   height==%lf",width,self.superview.height);
    self.width=width;
    self.height=height;
    
}


-(void)hideBorderAndButtons
{
    self.imageView.layer.borderWidth=0;
    self.move.hidden=YES;
    self.userInteractionEnabled=NO;
}



@end
