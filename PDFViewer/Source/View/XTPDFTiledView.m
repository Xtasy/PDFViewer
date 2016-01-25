//
//  XTPDFTiledView.m
//  PDFViewer
//
//  Created by Pavel Dolgov on 25/01/16.
//  Copyright © 2016 Pavel Dolgov. All rights reserved.
//

#import "XTPDFTiledView.h"
#import <QuartzCore/QuartzCore.h>

float const kTileSize = 1024.0f; // I suppose this is a perfect tile size

@implementation XTPDFTiledView

- (id)initWithFrame:(CGRect)frame scale:(CGFloat)scale
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CATiledLayer *tiledLayer = (CATiledLayer *)[self layer];
        tiledLayer.levelsOfDetail = 4;
        tiledLayer.levelsOfDetailBias = 3;
        tiledLayer.tileSize = CGSizeMake(kTileSize, kTileSize);
        self.currentScale = scale;
    }
    return self;
}

+ (Class)layerClass
{
    return [CATiledLayer class];
}

- (void)setPage:(CGPDFPageRef)newPage
{
    if(self.pdfPage != NULL) CGPDFPageRelease(self.pdfPage);
    if(newPage != NULL) self.pdfPage = CGPDFPageRetain(newPage);
}

- (void)drawLayer:(CALayer*)layer inContext:(CGContextRef)context
{
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(context, self.bounds);
    
    if(_pdfPage == NULL) return;
    
    CGContextSaveGState(context);
    
    int rotate = CGPDFPageGetRotationAngle(self.pdfPage);
    switch (rotate)
    {
        case 0:
            CGContextTranslateCTM(context, 0, self.bounds.size.height);
            CGContextScaleCTM(context, self.currentScale, -self.currentScale);
            break;
        case 90:
        case -270:
            CGContextTranslateCTM(context, 0, 0);
            CGContextScaleCTM(context, self.currentScale, -self.currentScale);
            CGContextRotateCTM(context, -M_PI / 2);
            break;
        case 180:
        case -180:
            CGContextTranslateCTM(context, self.bounds.size.width / 2, self.bounds.size.height / 2);
            CGContextScaleCTM(context, self.currentScale, -self.currentScale);
            CGContextRotateCTM(context, M_PI);
            break;
        case 270:
        case -90:
            CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
            CGContextRotateCTM(context, M_PI / 2);
            CGContextScaleCTM(context, -self.currentScale, self.currentScale);
            break;
    }
    CGContextDrawPDFPage(context, self.pdfPage);
    CGContextRestoreGState(context);
}

- (void)dealloc
{
    if(self.pdfPage != NULL) CGPDFPageRelease(self.pdfPage);
}

@end
