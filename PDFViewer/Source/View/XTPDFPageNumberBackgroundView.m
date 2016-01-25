//
//  XTPDFPageNumberBackgroundView.m
//  PDFViewer
//
//  Created by Pavel Dolgov on 25/01/16.
//  Copyright © 2016 Pavel Dolgov. All rights reserved.
//

#import "XTPDFPageNumberBackgroundView.h"

@implementation XTPDFPageNumberBackgroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setBubbleColor:[UIColor colorWithRed:0x9F/255.0f green:0xA3/255.0f blue:0xA9/255.0f alpha:0.7f]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.height / 2];
    [self.bubbleColor setFill];
    [bezierPath fill];
}

@end