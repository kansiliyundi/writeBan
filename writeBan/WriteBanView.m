//
//  WriteBanView.m
//  writeBan
//
//  Created by 耿文康 on 15/9/23.
//  Copyright © 2015年 耿文康. All rights reserved.
//

#import "WriteBanView.h"
#import "writeBezierPath.h"

@interface WriteBanView ()
@property(nonatomic,strong) NSMutableArray *paths;
@property(nonatomic,strong) NSMutableArray *images;



@end

@implementation WriteBanView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/


-(NSMutableArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

-(NSMutableArray *)paths{
    if (!_paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

//清屏
- (void)qingPing {
    [self.paths removeAllObjects];
    [self.images removeAllObjects];
    self.backgroundColor = [UIColor whiteColor];
//    self.imageAddBlock = nil;
//    [self removeFromSuperview];
    [self setNeedsDisplay];


    
}
//回退
- (void)huiTui {
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    //获取当前触摸的点
    CGPoint point = [touch locationInView:touch.view];
    writeBezierPath *path = [[writeBezierPath alloc] init];
    //设置线宽
    [path setLineWidth:self.lineWidth];
    [path setLineColor:self.lineColor];
    [path moveToPoint:point];
    
    [self.paths addObject:path];

}



-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = touches.anyObject;
    //获取当前触摸的点
    CGPoint point = [touch locationInView:touch.view];
    
    [[self.paths lastObject] addLineToPoint:point];
    //重绘
    [self setNeedsDisplay];
    
    
    
}


//把图片画在view上


-(UIImage *)nonceDrawingBoard{
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
    //获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //截图
    [self.layer renderInContext:ctx];
    //通过上下文拿图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return image;

    
}





- (void)drawRect:(CGRect)rect {
    
   
        
//    if (self.imageAddBlock) {
//        
//            UIImage *image = self.imageAddBlock();
//            [self.images addObject:image];
//        
//            self.backgroundColor = [UIColor colorWithPatternImage:self.images.lastObject];
//        
    
//        [image drawInRect:rect];
        
        

//    }
//    
    
    if (self.paths.count) {
        for (writeBezierPath *path in self.paths) {
            //设置线样式
            [path setLineCapStyle:kCGLineCapRound];
            //设置线连接处
            [path setLineJoinStyle:kCGLineJoinRound];
            //设置颜色
            [path.lineColor set];
            
            [path stroke];
        }
            }
    
    
    
    //从数组里将所有的线渲染
    
}

@end
