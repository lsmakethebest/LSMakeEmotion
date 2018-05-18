//
//  ViewController.m
//  transparentExpression
//
//  Created by togo on 2017/6/7.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import "ViewController.h"
#import "CommonMacro.h"
#import "Masonry.h"
#import "LSAddLabel.h"
#import "ColorAndFont.h"
#import "UIView+LSExtension.h"
#import "UIToast.h"
#import "WSColorImageView.h"
#import "LSRightBottomButton.h"
#import "UploadImageView.h"
#import "LSAddImageView.h"

@interface ViewController ()

@property (nonatomic,weak) UIView *contentView;
@property (nonatomic,weak) UIView *backgroundView;
@property (nonatomic,weak) LSAddLabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIView *aligmentView;

@property (weak, nonatomic) IBOutlet UIView *fontView;

@property (weak, nonatomic) IBOutlet UIView *colorView;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *functionBtns;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *aligmentBtns;

@property (nonatomic,weak) UIImageView *move;
@property (weak, nonatomic) IBOutlet UILabel *fontTipLabel;

@property (weak, nonatomic) IBOutlet UIButton *boldButton;
@property (weak, nonatomic) IBOutlet UISlider *fontSlider;

@property (weak, nonatomic) IBOutlet WSColorImageView *colorPickView;

@property (weak, nonatomic) IBOutlet UIView *fontNameView;
@property (nonatomic,copy) NSString *fontName;

@property (nonatomic,weak) UIButton *selectedFontBtn;
@property (weak, nonatomic) IBOutlet LSRightBottomButton *firstFontBtn;

@property (nonatomic,weak) LSAddImageView *contentImageView;
@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   NSString *s =[self strUTF8Encoding:@"https://download.fir.im/apps/5ae5de8dca87a86ebcce1edc/install?download_token=7a45bad43e3f479947b2c18059b32172"];
    
    
    
    [[UIApplication sharedApplication]openURL: [NSURL URLWithString:@"itms-services:///?action=download-manifest&url=https://download.mytogo.com/ground/ios/togoGround.plist"]] ;
    NSString *version=[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"];
#ifdef  DEBUG
    
    [UIToast showMessageToCenter: [NSString stringWithFormat:@"0:%@",version]];
#else
    [UIToast showMessageToCenter: [NSString stringWithFormat:@"1:%@",version]];
#endif
    
   
}
    
#pragma mark - url 中文格式化
- (NSString *)strUTF8Encoding:(NSString *)str
    {
        //ios9适配的话 打开第一个
        if ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0){
            return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        }
        else{
            return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }
- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    self.title=@"透明表情制作";
    UIView *contentView=[[UIView alloc]init];
//    contentView.backgroundColor=[UIColor clearColor];
    contentView.layer.borderColor= RGB(0x6FDBF1).CGColor;
    contentView.layer.borderWidth=1;
    contentView.frame=CGRectMake(20,15+64,(SCREEN_W-20*2),230);
    [self.view addSubview:contentView];
    self.contentView=contentView;
    
    
    
    UIView *backgroundView=[[UIView alloc]init];
    backgroundView.backgroundColor=[UIColor clearColor];
    [contentView addSubview:backgroundView];
    
    
//    UIPinchGestureRecognizer *pin=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePin:)];
//    [contentView addGestureRecognizer:pin];
    
    UIPanGestureRecognizer *moveGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveGesture:)];
    [contentView addGestureRecognizer:moveGesture];
    
    
    //背景拖拽手势
    UIImageView *move=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yidong"]];
    move.userInteractionEnabled=YES;
    UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    
    [move addGestureRecognizer:panGesture];
    [contentView addSubview:move];
    move.x=self.contentView.width-2*LSMargin;
    move.y=self.contentView.height-2*LSMargin;
//    [move mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.and.height.mas_equalTo(2*LSMargin);
//        make.right.and.bottom.mas_equalTo(-LSMargin);
//    }];
    
    self.move=move;
    
    
    self.backgroundView=backgroundView;
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(contentView);
    }];
    typeof(self) weakSelf= self;
    self.colorPickView.currentColorBlock = ^(UIColor *color) {
        weakSelf.contentLabel.textView.textColor=color;
    };
    self.fontName=@".SFUIDisplay";
    
    self.selectedFontBtn=self.firstFontBtn;
    [self createNewTextView];
    
    
}


-(void)createNewTextView
{

    LSAddLabel *label=[[LSAddLabel alloc]init];
    label.frame=self.contentView.bounds;
    label.width-=40;
    label.x=20;
    label.y=20;
    label.height=60+2*LSMargin;
    [self.backgroundView  addSubview:label];
    self.contentLabel=label;
}

- (IBAction)aligmentClick:(id)sender {

    self.aligmentView.hidden=NO;
    self.fontView.hidden=YES;
    self.colorView.hidden=YES;
    self.fontNameView.hidden=YES;
    for (UIButton *btn in self.functionBtns) {
        if (btn==sender) {
            btn.selected=YES;
        }else{
            btn.selected=NO;
        }
        
    }

}

- (IBAction)fontClick:(id)sender {
    self.aligmentView.hidden=YES;
    self.fontView.hidden=NO;
    self.colorView.hidden=YES;
    self.fontNameView.hidden=YES;
    for (UIButton *btn in self.functionBtns) {
        if (btn==sender) {
            btn.selected=YES;
        }else{
            btn.selected=NO;
        }
        
    }
}

- (IBAction)colorClick:(id)sender
{
    self.aligmentView.hidden=YES;
    self.fontView.hidden=YES;
    self.colorView.hidden=NO;
    self.fontNameView.hidden=YES;
    for (UIButton *btn in self.functionBtns) {
        if (btn==sender) {
            btn.selected=YES;
        }else{
            btn.selected=NO;
        }
    }
}


- (IBAction)fontNameClick:(UIButton *)sender {
    self.aligmentView.hidden=YES;
    self.fontView.hidden=YES;
    self.colorView.hidden=YES;
    self.fontNameView.hidden=NO;
    [self setSelectedWithBtn:sender array:self.functionBtns];
    
}

- (IBAction)leftAligmentClick:(id)sender {
    self.contentLabel.textView.textAlignment=NSTextAlignmentLeft;
    for (UIButton *btn in self.aligmentBtns) {
        if (btn==sender) {
            btn.selected=YES;
        }else{
            btn.selected=NO;
        }
    }
}
- (IBAction)centerAligmentClick:(id)sender {
    self.contentLabel.textView.textAlignment=NSTextAlignmentCenter;
    for (UIButton *btn in self.aligmentBtns) {
        if (btn==sender) {
            btn.selected=YES;
        }else{
            btn.selected=NO;
        }
        
    }
}
- (IBAction)rightAligmentClick:(id)sender {
    self.contentLabel.textView.textAlignment=NSTextAlignmentRight;
    for (UIButton *btn in self.aligmentBtns) {
        if (btn==sender) {
            btn.selected=YES;
        }else{
            btn.selected=NO;
        }
        
    }
}

- (IBAction)fontSizeChange:(UISlider*)sender {
    self.contentLabel.textView.font=[UIFont fontWithName:self.fontName size:sender.value];
    self.fontTipLabel.text=[NSString stringWithFormat:@"字号:%.0lf",sender.value];
}
- (IBAction)addText:(id)sender
{
    [self.contentLabel hideBorderAndButtons];
    [self initSetting];
    [self createNewTextView];
}

- (IBAction)save:(id)sender
{
    [self.contentLabel hideBorderAndButtons];
    [self.contentImageView hideBorderAndButtons];
    [self captureView:self.backgroundView];
    
    
}

-(IBAction)changeFont:(UIButton*)sender
{
    
    self.selectedFontBtn.selected=NO;
    sender.selected=YES;
    self.selectedFontBtn=sender;
    NSString *name= sender.titleLabel.font.fontName;
    self.fontName=name;
    self.contentLabel.textView.font=[UIFont fontWithName:name size:self.contentLabel.textView.font.pointSize];
    
}
-(void)setSelectedWithBtn:(UIButton*)button array:(NSArray*)array
{
    for (UIButton *btn in array) {
        if (btn==button) {
            btn.selected=YES;
        }else{
            btn.selected=NO;
        }
        
    }
}

- (IBAction)reset:(id)sender {
    self.contentView.frame=CGRectMake(20,15+64,(SCREEN_W-20*2),250);
    self.move.x=self.contentView.width-2*LSMargin;
    self.move.y=self.contentView.height-2*LSMargin;
    [self.backgroundView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self initSetting];
    [self createNewTextView];
    

}

//底部设置初始化
-(void)initSetting
{
    self.boldButton.titleLabel.font=[UIFont systemFontOfSize:30];
    self.boldButton.selected=NO;
    [self setSelectedWithBtn:self.aligmentBtns.firstObject array:self.aligmentBtns];
    self.fontTipLabel.text=@"字号:30";
    self.fontSlider.value=30;
    self.selectedFontBtn.selected=NO;
    self.firstFontBtn.selected=YES;
    self.selectedFontBtn=self.firstFontBtn;
    self.fontName=self.firstFontBtn.titleLabel.font.fontName;
    
}
-(void)moveGesture:(UIPanGestureRecognizer*)gesture
{
    
    CGPoint point= [gesture translationInView:gesture.view];
//    NSLog(@"%@",NSStringFromCGPoint(point));
    [gesture setTranslation:CGPointZero inView:gesture.view];
    
    CGFloat x=self.contentView. x+point.x;
    if (x<=0) {
        x=0;
    }
    
    if (x+self.contentView.width>self.contentView.superview.width) {
        x=self.contentView.superview.width-self.contentView.width;
    }
    
    CGFloat y=self.contentView.y+point.y;
    if (y<=0) {
        y=0;
    }
    
    if (y+self.contentView.height>self.contentView.superview.height) {
        y=self.contentView.superview.height-self.contentView.height;
    }
//    NSLog(@"x=%lf   y==%lf",x,y);
    self.contentView.x=x;
    self.contentView.y=y;
}

-(void)handlePanGesture:(UIPanGestureRecognizer*)gesture
{
    CGPoint point= [gesture translationInView:gesture.view];
    NSLog(@"%@",NSStringFromCGPoint(point));
    [gesture setTranslation:CGPointZero inView:gesture.view];
    
    CGFloat width=self.contentView.width+point.x;
    if (width<=50) {
        width=50;
    }
    
    if (self.contentView.x+width>self.contentView.superview.width) {
        width=self.contentView.superview.width-self.contentView.x;
    }
    
    CGFloat height=self.contentView.height+point.y;
    if (height<=50) {
        height=50;
    }
    
    if (self.contentView.y+height>self.contentView.superview.height) {
        height=self.contentView.superview.height-self.contentView.y;
    }
    
    
//    NSLog(@"width=%lf   height==%lf",width,self.superview.height);
    self.contentView.width=width;
    self.contentView.height=height;
    

    self.move.x=self.contentView.width-2*LSMargin;
    self.move.y=self.contentView.height-2*LSMargin;
    
}

-(void)captureView:(UIView*)view1
{
    
    //获得某个window的某个subView
    UIView *view = view1;
    //支持retina高分的关键
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    //获取图像
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //保存图像
    UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:  UIImagePNGRepresentation(image)], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    
}

- (IBAction)boldBtn:(UIButton *)sender {
    sender.selected=!sender.selected;
    
    if (sender.selected) {
        self.contentLabel.textView.font=[UIFont boldSystemFontOfSize:self.contentLabel.textView.font.pointSize];
        sender.titleLabel.font=[UIFont boldSystemFontOfSize:30];
    }else{
        sender.titleLabel.font=[UIFont systemFontOfSize:30];
        self.contentLabel.textView.font=[UIFont systemFontOfSize:self.contentLabel.textView.font.pointSize];
    }
    
}
- (IBAction)addPIcture:(id)sender {
    
    [self.contentImageView hideBorderAndButtons];
    [UploadImageView showUpUploadImageViewWithBlockImage:^(UIImage *newImage) {
        LSAddImageView *imageView=[[LSAddImageView alloc]init];
        imageView.frame=self.contentView.bounds;
        imageView.width=140;
        imageView.x=20;
        imageView.y=20;
        imageView.height=imageView.width;
        imageView.imageView.image=newImage;
        [self.backgroundView addSubview:imageView];
        self.contentImageView=imageView;
    }];
    
}

//只能调用这个方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    if (error) {
        [UIToast showMessageToCenter:@"保存失败，请检查相册权限"];
    }else{
        [UIToast showMessageToCenter:@"保存成功"];
        [self reset:nil];
    }
}


@end
