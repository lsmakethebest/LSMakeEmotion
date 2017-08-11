//
//  KCRenderLabel.h
//  driver
//
//  Created by 刘松 on 2016/12/20.
//  Copyright © 2016年 driver. All rights reserved.
//

#import <UIKit/UIKit.h>


IB_DESIGNABLE

@interface TGRenderLabel : UILabel

// 注意: 加上IBInspectable就可以可视化显示相关的属性哦

/** 可视化设置边框宽度 */
@property (nonatomic, assign)IBInspectable CGFloat borderWidth;

/** 可视化设置边框颜色 */
@property (nonatomic, strong)IBInspectable UIColor *borderColor;

/** 可视化设置圆角 */
@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;


@end
