//
//  DIYPaintView.m
//  IT恤
//
//  Created by 荣刚 on 16/4/2.
//  Copyright © 2016年 rg. All rights reserved.
//

#import "DIYPaintView.h"

@interface DIYPaintView ()

@property (nonatomic, strong) NSMutableArray *pasteImageArray;
@property (nonatomic, strong) NSMutableArray *pathsArray;
@property (nonatomic, strong) UIBezierPath *bezier;
@property (nonatomic, assign) CGFloat lineWidth;

@end

@implementation DIYPaintView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineWidth = 1.0f;
    }
    return self;
}

- (void)awakeFromNib
{
    _lineWidth = 1.0f;
}

- (NSMutableArray *)pasteImageArray
{
    if (!_pasteImageArray) {
        _pasteImageArray = [NSMutableArray array];
    }
    return _pasteImageArray;
}

- (NSMutableArray *)pathsArray
{
    if (!_pathsArray) {
        _pathsArray = [NSMutableArray array];
    }
    return _pathsArray;
}


- (void)setTShirtImage:(UIImage *)tShirtImage
{
    NSAssert(tShirtImage != nil, @"tShirtImage 不能为空");
    _tShirtImage = tShirtImage;
    [self.pathsArray addObject:tShirtImage];
    [self setNeedsDisplay];
}

- (void)addPasteImage:(UIImage *)pasteImage
{
    NSAssert(pasteImage != nil, @"pasteImage 不能为空");
    if (self.pasteImageArray.count) {
        UIImageView *lastImage = self.pasteImageArray.lastObject;
        lastImage.image = pasteImage;
    } else {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 80)];
        imageView.image = pasteImage;
        imageView.userInteractionEnabled = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changePosition:)];
        [imageView addGestureRecognizer:pan];
        [self addSubview:imageView];
        [self.pasteImageArray addObject:imageView];
    }
}

- (void)changePosition:(UIPanGestureRecognizer *)reg
{
    UIImageView *imageView = (UIImageView *)reg.view;
    CGPoint currentPoint = [reg locationInView:self];
    imageView.center = currentPoint;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];

    UIBezierPath *bezier = [UIBezierPath bezierPath];
    _bezier = bezier;
    [bezier setLineWidth:self.lineWidth];
    [bezier moveToPoint:point];
    [self.pathsArray addObject:bezier];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];

    [_bezier addLineToPoint:point];
    [self setNeedsDisplay];
}

- (void)eraser
{
    if (self.pathsArray.count > 1) {
        [self.pathsArray removeLastObject];
    } else {
        if (self.pasteImageArray.count) {
            UIImageView *imageView = self.pasteImageArray.lastObject;
            [imageView removeFromSuperview];
            [self.pasteImageArray removeLastObject];
        }
    }

    [self setNeedsDisplay];
}

- (void)setPenWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (!self.pathsArray.count) {
        return;
    }
    
    for (UIBezierPath *path in self.pathsArray) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)path;
            [image drawInRect:self.bounds];
        } else {
            [path stroke];
        }
    }
}


@end
