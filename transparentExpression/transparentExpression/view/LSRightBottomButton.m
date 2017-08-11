

//
//  LSRightBottomButton.m
//  transparentExpression
//
//  Created by togo on 2017/6/8.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import "LSRightBottomButton.h"

#import "ColorAndFont.h"
@implementation LSRightBottomButton


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
//        self.layer.borderColor= RGB(0x6FDBF1).CGColor;
//        self.layer.borderWidth=1;
        self.layer.cornerRadius=5;
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.backgroundColor=[UIColor whiteColor];
//     [self bringSubviewToFront:self.imageView];   
    }
    return self;
}


-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    return CGRectMake(contentRect.size.width-17+5, contentRect.size.height-17+5, 17, 17);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return contentRect;
}

@end
