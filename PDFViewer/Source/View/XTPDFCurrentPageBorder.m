//
//  XTPDFCurrentPageBorder.m
//  PDFViewer
//
//  Created by Pavel Dolgov on 25/01/16.
//  Copyright © 2016 Pavel Dolgov. All rights reserved.
//

#import "XTPDFCurrentPageBorder.h"

@implementation XTPDFCurrentPageBorder

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setBorderColor:[UIColor redColor]];
        [self setBorderWidth:2.0f];
    }
    return self;
}

- (void)drawRect:(CGRect) rect
{
    CGRect strokeRect = CGRectMake(rect.origin.x + self.borderWidth / 2,
                                   rect.origin.y + self.borderWidth / 2,
                                   rect.size.width - self.borderWidth,
                                   rect.size.height - self.borderWidth);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, NO);
    CGContextSetStrokeColorWithColor(context, [self.borderColor CGColor]);
    CGContextSetLineWidth(context, self.borderWidth);
    CGContextStrokeRect(context, strokeRect);
}

@end
