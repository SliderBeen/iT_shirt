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

@end

@implementation DIYPaintView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
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
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:pasteImage];
    imageView.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changePosition:)];
    [imageView addGestureRecognizer:pan];
    [self addSubview:imageView];
    [self.pasteImageArray addObject:imageView];
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
