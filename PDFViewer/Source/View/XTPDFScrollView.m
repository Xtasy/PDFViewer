//
//  XTPDFScrollView.m
//  PDFViewer
//
//  Created by Pavel Dolgov on 25/01/16.
//  Copyright © 2016 Pavel Dolgov. All rights reserved.
//

#import "XTPDFScrollView.h"
#import "XTPDFTiledView.h"

@implementation XTPDFScrollView
{
    CGRect originalRect;
    CGFloat originalScale;
    BOOL lock;
}

- (id)initWithFrame:(CGRect)frame
{
    if( self = [super initWithFrame:frame])
    {
        [self initialize];
    }
    return self;
}

-(void)initialize
{
    originalScale = 0.0f;
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    self.delegate = self;
    self.bounces = NO;
    self.minimumZoomScale = .1f;
    self.maximumZoomScale = 5.0f;
    [self setBackgroundColor:[UIColor clearColor]];
    self.contentMode = UIViewContentModeCenter;
}

- (void)setPage:(CGPDFPageRef)page
{
    if(page != NULL) CGPDFPageRetain(page);
    if(self.PDFPage != NULL) CGPDFPageRelease(self.PDFPage);
    self.PDFPage = page;
    
    if(self.PDFPage == NULL )
    {
        self.pageRect = self.bounds;
    }
    else
    {
        int rotate = CGPDFPageGetRotationAngle(self.PDFPage);
        self.pageRect = CGPDFPageGetBoxRect(_PDFPage, kCGPDFMediaBox);
        BOOL keepScale = originalScale == 0.0f ? NO : YES;
        if (self.hasChangedSize)
        {
            keepScale = NO;
            self.contentSize = self.frame.size;
        }
        if (rotate == 90 || rotate == -90 || rotate == 270 || rotate == -270)
        {
            if (!keepScale)
            {
                CGFloat xScale = self.bounds.size.width / self.pageRect.size.height;
                CGFloat yScale = self.bounds.size.height / self.pageRect.size.width;
                originalScale = self.PDFScale = MIN(xScale, yScale);
                CGFloat originalWidth = self.pageRect.size.width * originalScale;
                CGFloat originalHeight = self.pageRect.size.height * originalScale;
                originalRect = self.pageRect = CGRectMake((self.bounds.size.width - originalHeight) / 2, (self.bounds.size.height- originalWidth) / 2, originalHeight, originalWidth);
            }
            CGFloat newWidth = self.pageRect.size.width * self.PDFScale;
            CGFloat newHeight = self.pageRect.size.height * self.PDFScale;
            self.pageRect = CGRectMake((self.bounds.size.width - newHeight) / 2, (self.bounds.size.height- newWidth) / 2, newHeight, newWidth);
            
        }
        else
        {
            if (!keepScale)
            {
                CGFloat yScale = self.frame.size.height / self.pageRect.size.height;
                CGFloat xScale = self.frame.size.width / self.pageRect.size.width;
                originalScale = self.PDFScale = MIN(xScale, yScale);
                CGFloat originalWidth = self.pageRect.size.width * originalScale;
                CGFloat originalHeight = self.pageRect.size.height * originalScale;
                originalRect = CGRectMake((self.frame.size.width - originalWidth) / 2, (self.frame.size.height - originalHeight) / 2, originalWidth, originalHeight);
            }
            CGFloat newWidth = self.pageRect.size.width * self.PDFScale;
            CGFloat newHeight = self.pageRect.size.height * self.PDFScale;
            self.pageRect = CGRectMake((self.frame.size.width - newWidth) / 2, (self.frame.size.height - newHeight) / 2, newWidth, newHeight);
        }
    }
    self.hasChangedSize = NO;
    [self replaceTiledPDFViewWithFrame:self.pageRect];
}


- (void)dealloc
{
    if(self.PDFPage != NULL) CGPDFPageRelease(self.PDFPage);
}

#pragma mark -
#pragma mark UIScrollView delegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.tiledPDFView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    if (self.PDFScale * scale < originalScale)
    {
        self.PDFScale = originalScale;
        self.pageRect = originalRect;
    }
    else
    {
        self.PDFScale *= scale;
        self.pageRect = CGRectMake((self.contentSize.width - self.pageRect.size.width * scale) / 2, (self.contentSize.height - self.pageRect.size.height * scale) / 2, self.pageRect.size.width * scale, self.pageRect.size.height * scale );
    }
    [self replaceTiledPDFViewWithFrame:self.pageRect];
}

-(void)replaceTiledPDFViewWithFrame:(CGRect)frame
{
    [self.tiledPDFView removeFromSuperview];
    if (self.PDFScale < self.minimumZoomScale) self.PDFScale = self.minimumZoomScale;
    XTPDFTiledView * tiledPDFView = [[XTPDFTiledView alloc] initWithFrame:frame scale:self.PDFScale];
    [tiledPDFView setPage:self.PDFPage];
    [self addSubview:tiledPDFView];
    self.tiledPDFView = tiledPDFView;
}

@end
