//
//  ViewController.m
//  writeBan
//
//  Created by 耿文康 on 15/9/21.
//  Copyright © 2015年 耿文康. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Tint.h"
#import "WriteBanView.h"
#import "UMSocial.h"

typedef enum {
    oneDa,
    twoDa,
    treeDa,
} myLine;

#define penBtnCount 3
@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet WriteBanView *paintView;

@property (weak, nonatomic) IBOutlet UIButton *blackBtn;
@property (weak, nonatomic) IBOutlet UIButton *blueBtn;
@property (weak, nonatomic) IBOutlet UIButton *redsbtn;
@property (weak, nonatomic) IBOutlet UIButton *xiangpica;
@property (weak, nonatomic) IBOutlet UIButton *oneDaBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoDaBtn;
@property (weak, nonatomic) IBOutlet UIButton *treeDaBtn;

@property(nonatomic,strong) NSMutableArray *colorArray;
@property(nonatomic,strong) NSMutableArray *btnArray;
@property(nonatomic,strong) NSMutableArray *daXiaoArray;


@end

@implementation ViewController

#pragma mark - 初始化颜色,画笔按钮,线宽按钮
-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray arrayWithObjects:self.blackBtn,self.blueBtn,self.redsbtn,self.xiangpica,nil];
    }
    return _btnArray;
}

-(NSMutableArray *)colorArray{
    if (!_colorArray) {
        _colorArray = [NSMutableArray arrayWithObjects:[UIColor blackColor],[UIColor blueColor],[UIColor redColor],[UIColor redColor],[UIColor redColor],[UIColor redColor],nil];
    }
    return _colorArray;
}

-(NSMutableArray *)daXiaoArray{
    if (!_daXiaoArray) {
        _daXiaoArray = [NSMutableArray arrayWithObjects:self.oneDaBtn,self.twoDaBtn,self.treeDaBtn, nil];
    }
    return _daXiaoArray;
}


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    //隐藏顽固的status bar
    [self setNeedsStatusBarAppearanceUpdate];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    
    //循环设置不同颜色的笔,不同状态下的渲染颜色.
    for(int i = 0;i<penBtnCount;i++){
        
        for (UIColor *color in self.colorArray) {
            
            if (color == self.colorArray[i]) {
                UIImage *blackPenGai =[[UIImage imageNamed:@"bi_gai.png"] imageWithGradientTintColor:color];
                UIImage *blackPenJian = [[UIImage imageNamed:@"bi_jian.png"] imageWithGradientTintColor:color];
                
                [self.btnArray[i] setImage:blackPenGai forState:UIControlStateNormal];
                    
                [self.btnArray[i] setImage:blackPenJian forState:UIControlStateSelected];
                
                }
                
            }
        }
    
    [self blackBtnClick:self];
    [self oneDa:self];
    self.blackBtn.selected = YES;
    self.oneDaBtn.selected = YES;
    self.paintView.lineWidth = 1;
    
    }
    



#pragma mark - 画笔点击
 //黑笔
- (IBAction)blackBtnClick:(id)sender {
    [self btnColor:self.colorArray[0] btnIndex:0];
}
//蓝笔
- (IBAction)blueBtnClick:(id)sender {
    [self btnColor:self.colorArray[1] btnIndex:1];
}
//红笔
- (IBAction)redsBtnClick:(id)sender {
    [self btnColor:self.colorArray[2] btnIndex:2];
}

//线宽1
- (IBAction)oneDa:(id)sender {
    [self line:oneDa];
    
    
}
//线宽2
- (IBAction)twoDa:(id)sender {
    [self line:twoDa];
    
    
}
//线宽3
- (IBAction)treeDa:(id)sender {
    [self line:treeDa];
}



#pragma mark - 清屏
- (IBAction)qingPing:(id)sender {
    [self.paintView qingPing];
}


#pragma mark - 回退
- (IBAction)huiTui:(id)sender {
    [self.paintView huiTui];
}


#pragma mark - 保存
- (IBAction)baoCun:(id)sender {
    
    
    //获得当前画板的图片
    UIImage *image = [self.paintView nonceDrawingBoard];
    //保存在相册
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

#pragma mark - 橡皮
- (IBAction)xiangpiClick:(id)sender {
    
    for (UIButton *btn in self.btnArray) {
        if (btn == self.btnArray[3]) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    
    self.paintView.lineColor = [UIColor whiteColor];
}


#pragma mark - 批量设置画笔颜色
- (void)btnColor:(UIColor *)arrayColor btnIndex:(NSInteger)x {
    
    
    
    if(arrayColor == self.colorArray[x]){
        self.paintView.lineColor = arrayColor;
        
        
        for(UIButton *btn in self.btnArray){
            if(btn == self.btnArray[x]){
                btn.selected = YES;
                self.xiangpica.selected = NO;
            }else{
                btn.selected = NO;
            }
        }
    }
}



#pragma mark - 批量设置线宽
- (void)line:(myLine)myLine{
    
    for (UIButton *btn in self.daXiaoArray) {
        if (btn == self.daXiaoArray[myLine]) {
            self.paintView.lineWidth = myLine + 1;
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
      
    
}





#pragma mark - 点击相册;
- (IBAction)pickPhoto:(id)sender {
     UIImagePickerController *pkVc = [[UIImagePickerController alloc] init];
    pkVc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
     pkVc.delegate = self;
    [self presentViewController:pkVc animated:YES completion:nil];
    
}

#pragma mark - 打开相册 选择图片 添加;

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 查看字典中的内容
    //NSLog(@"%@", info);
    
    // 获取选择的图片
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    
    CGFloat width = self.paintView.frame.size.width;
    CGFloat height = self.paintView.frame.size.height;
    
    
    UIImage *img2 = [UIImage new];
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    [img drawInRect:CGRectMake(0, 0, width, height)];
    img2 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
     self.paintView.backgroundColor = [UIColor colorWithPatternImage:img2];

    [self dismissViewControllerAnimated:YES completion:nil];
}



//点击分享
- (IBAction)fenXiang:(id)sender {
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5600fa1a67e58e9d9c0002aa"
                                      shareText:@"这是我的大作,你也要来一发吗?"
                                     shareImage:[self.paintView nonceDrawingBoard]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
                                       delegate:nil];

}


@end
