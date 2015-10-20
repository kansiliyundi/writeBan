//
//  WriteBanView.h
//  writeBan
//
//  Created by 耿文康 on 15/9/23.
//  Copyright © 2015年 耿文康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WriteBanView : UIView

@property(nonatomic,assign) CGFloat lineWidth;
@property(nonatomic,strong) UIColor *lineColor;
@property(nonatomic,strong) UIImage *(^imageAddBlock)();

//清屏
- (void)qingPing;
//回退
- (void)huiTui;
//获得当前画板图片
-(UIImage *)nonceDrawingBoard;

@end
