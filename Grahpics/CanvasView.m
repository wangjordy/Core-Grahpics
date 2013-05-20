//
//  CanvasView.m
//  Grahpics
//
//  Created by 王兴朝 on 13-5-17.
//  Copyright (c) 2013年 bitcar. All rights reserved.
//

#import "CanvasView.h"

@implementation CanvasView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code    
    //绘制矩形
    [self drawRectangle:CGRectMake(10, 10, 300, 300)];
    //绘制圆角矩形
    [self drawRectangle:CGRectMake(15, 15, 290, 290) withRadius:20];
    //绘制多边形
    NSArray *points= @[[NSValue valueWithCGPoint:CGPointMake(70, 30)],
                       [NSValue valueWithCGPoint:CGPointMake(80, 70)],
                       [NSValue valueWithCGPoint:CGPointMake(120, 80)],
                       [NSValue valueWithCGPoint:CGPointMake(80, 90)],
                       [NSValue valueWithCGPoint:CGPointMake(70, 130)],
                       [NSValue valueWithCGPoint:CGPointMake(60, 90)],
                       [NSValue valueWithCGPoint:CGPointMake(20, 80)],
                       [NSValue valueWithCGPoint:CGPointMake(60, 70)],
                       [NSValue valueWithCGPoint:CGPointMake(70, 30)]];
    [self drawPolygon:points];
    
    //绘制波浪线
    [self drawCurveFrom:CGPointMake(120, 50)
                     to:CGPointMake(200, 50)
          controlPoint1:CGPointMake(130, 0)
          controlPoint2:CGPointMake(190, 100)];
    
    //绘制大圆
    [self drawCircleWithCenter:CGPointMake(160, 160) radius:50];
    
    //绘制眼睛
    [self drawFillCircleWithCenter:CGPointMake(135, 145)
                        radius:6];
    [self drawFillCircleWithCenter:CGPointMake(185, 145)
                        radius:6];
    
    //绘制嘴巴
    [self drawArcWithCenter:CGPointMake(160, 160) radius:30 startAngle:0 endAngle:3.14 clockwise:NO];
    //绘制三道直线
    [self drawLineFrom:CGPointMake(110, 260)
                    to:CGPointMake(210, 260)];
    [self drawLineFrom:CGPointMake(120, 265)
                    to:CGPointMake(200, 265)];
    [self drawLineFrom:CGPointMake(130, 270)
                    to:CGPointMake(190, 270)];
    
    //绘制扇形
    [self drawSectorFromCenter:CGPointMake(60, 400)
                        radius:30
                    startAngle:-3.14/2
                      endAngle:0
                     clockwise:YES
     withFillColor:[UIColor blueColor]];
    
    
}


//绘矩形
- (void)drawRectangle:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorRef blueColor = [UIColor colorWithRed:80.0f/255.0f green:150.0f/255.0f blue:225.f/255.f alpha:1].CGColor;

    CGContextSetStrokeColorWithColor(context, blueColor);
    
    CGContextSetLineWidth(context, 1.0);
    
    CGContextStrokeRect(context, rect);
    
}
//绘制圆角矩形
- (void)drawRectangle:(CGRect)rect  withRadius:(CGFloat)radius
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorRef blueColor = [UIColor colorWithRed:80.0f/255.0f green:150.0f/255.0f blue:225.f/255.f alpha:1].CGColor;
    
    CGContextSetStrokeColorWithColor(context, blueColor);
                                                     
    CGContextSetLineWidth(context, 1.0);
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMinY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMidX(rect), CGRectGetMinY(rect), radius);
    CGPathCloseSubpath(path);
    
    CGContextAddPath(context, path);
    CGContextStrokePath(context);

    CFRelease(path);
}
//绘制多边形
- (void)drawPolygon:(NSArray *)points
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef blueColor = [UIColor colorWithRed:80.0f/255.0f green:150.0f/255.0f blue:225.f/255.f alpha:1].CGColor;
    
    
    CGContextSetStrokeColorWithColor(context, blueColor);
    
    CGContextSetLineWidth(context, 1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    if (points.count>0) {
        CGPoint startPoint = [[points objectAtIndex:0] CGPointValue];
        CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    }
    
    for (int i=1; i<points.count; i++) {
        CGPoint point = [[points objectAtIndex:i] CGPointValue];
        CGPathAddLineToPoint(path, NULL, point.x, point.y);
        
    }
    
    CGPathCloseSubpath(path);
    CGContextAddPath(context, path);
    
    
    //设置填充色，填充该多边形
    CGColorRef greenColor = [UIColor colorWithRed:41.f/255.f green:199.f/255.f blue:165.f/255.f alpha:1].CGColor;
    CGContextSetFillColorWithColor(context, greenColor);
    CGContextFillPath(context);
    
    CGContextStrokePath(context);
    CFRelease(path);
}

//绘制波浪线
-(void)drawCurveFrom:(CGPoint)startPoint
                  to:(CGPoint)endPoint
       controlPoint1:(CGPoint)controlPoint1
       controlPoint2:(CGPoint)controlPoint2
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef blueColor = [UIColor colorWithRed:80.0f/255.0f green:150.0f/255.0f blue:225.f/255.f alpha:1].CGColor;
    
    
    CGContextSetStrokeColorWithColor(context, blueColor);
    
    CGContextSetLineWidth(context, 1.0);
    
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddCurveToPoint(context, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, endPoint.x, endPoint.y);
    
    CGContextStrokePath(context);
    
}

//圆形
-(void)drawCircleWithCenter:(CGPoint)center
                     radius:(float)radius
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef blueColor = [UIColor colorWithRed:80.0f/255.0f green:150.0f/255.0f blue:225.f/255.f alpha:1].CGColor;
    
    
    CGContextSetStrokeColorWithColor(context, blueColor);
    
    CGContextSetLineWidth(context, 1.0);

    CGContextAddArc(context, center.x, center.y, radius, 0, 2 * M_PI * radius, 0);
    
    CGContextStrokePath(context);
}

- (void)drawFillCircleWithCenter:(CGPoint)center radius:(float)radius
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef blueColor = [UIColor colorWithRed:80.0f/255.0f green:150.0f/255.0f blue:225.f/255.f alpha:1].CGColor;
    
    
    CGContextSetStrokeColorWithColor(context, blueColor);
    
    CGContextSetLineWidth(context, 1.0);
    
    CGContextAddArc(context, center.x, center.y, radius, 0, 2 * M_PI * radius, 0);
    CGContextSetFillColorWithColor(context, blueColor);
    CGContextFillPath(context);
    CGContextStrokePath(context);

}

//绘制弧线
-(void)drawArcWithCenter:(CGPoint)center
                  radius:(float)radius
              startAngle:(float)startAngle
                endAngle:(float)endAngle
               clockwise:(BOOL)clockwise
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef blueColor = [UIColor colorWithRed:80.0f/255.0f green:150.0f/255.0f blue:225.f/255.f alpha:1].CGColor;
    
    
    CGContextSetStrokeColorWithColor(context, blueColor);
    
    CGContextSetLineWidth(context, 1.0);
    CGContextAddArc(context, center.x, center.y, radius, startAngle, endAngle, clockwise);
    CGContextStrokePath(context);

    
}

//绘制直线
-(void)drawLineFrom:(CGPoint)startPoint
                 to:(CGPoint)endPoint
{
    CGContextRef     context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x,endPoint.y);
    
    CGContextStrokePath(context);
}
//绘制扇形
-(void)drawSectorFromCenter:(CGPoint)center
                     radius:(float)radius
                 startAngle:(float)startAngle
                   endAngle:(float)endAngle
                  clockwise:(BOOL)clockwise
              withFillColor:(UIColor *)fillColor
{
    CGContextRef     context = UIGraphicsGetCurrentContext();
    
    
    CGContextMoveToPoint(context, center.x, center.y);
    
    CGContextAddArc(context,
                    center.x,
                    center.y,
                    radius,
                    startAngle,
                    endAngle,
                    clockwise?0:1);
    CGContextClosePath(context);
    CGContextDrawPath(context,kCGPathFillStroke);
    
    
    CGContextSetFillColorWithColor(context, (CGColorRef)fillColor.CGColor);
    CGContextFillPath(context);
    
}
@end
