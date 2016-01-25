//
//  XTPDFMiniatureCustomCell.m
//  PDFViewer
//
//  Created by Pavel Dolgov on 25/01/16.
//  Copyright © 2016 Pavel Dolgov. All rights reserved.
//

#import "XTPDFMiniatureCustomCell.h"
#import "XTPDFTiledView.h"
#import "XTPDFPageNumberBackgroundView.h"
#import "XTPDFCurrentPageBorder.h"

@implementation XTPDFMiniatureCustomCell
{
    XTPDFTiledView * tiledPDFView;
    UILabel * pageNumberLabel;
    UIView * pageNumberBackgroundView;
    UIView * currentPageBorder;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        pageNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(6.0f, 2.0f, 50.0f, 20.0f)];
        [pageNumberLabel setTextAlignment:NSTextAlignmentCenter];
        [pageNumberLabel.layer setCornerRadius:pageNumberLabel.frame.size.height / 2];
        [self.contentView addSubview:pageNumberLabel];
        
        pageNumberBackgroundView = [[XTPDFPageNumberBackgroundView alloc] initWithFrame:pageNumberLabel.frame];
        [self.contentView addSubview:pageNumberBackgroundView];
        
        currentPageBorder = [[XTPDFCurrentPageBorder alloc] initWithFrame:self.contentView.frame];
        [currentPageBorder setHidden:YES];
        [self.contentView addSubview:currentPageBorder];
    }
    return self;
}

- (void)setPage:(CGPDFPageRef)page pageNumber:(NSUInteger)pageNumber
{
    [tiledPDFView removeFromSuperview];
    CGRect pageRect;
    CGRect originalRect;
    CGFloat originalScale = 1.0f;
    if(page == NULL)
    {
        pageRect = self.contentView.bounds;
        originalRect = self.contentView.bounds;
    }
    else
    {
        pageRect = CGPDFPageGetBoxRect(page, kCGPDFMediaBox);
        CGFloat yScale = self.contentView.bounds.size.height / pageRect.size.height;
        CGFloat xScale = self.contentView.bounds.size.width / pageRect.size.width;
        originalScale = MIN(xScale, yScale);
        CGFloat newWidth = pageRect.size.width * originalScale;
        CGFloat newHeight = pageRect.size.height * originalScale;
        originalRect = pageRect = CGRectMake((self.contentView.bounds.size.width - newWidth) / 2, (self.contentView.bounds.size.height - newHeight) / 2, newWidth, newHeight);
    }
    tiledPDFView = [[XTPDFTiledView alloc] initWithFrame:originalRect scale:originalScale];
    [tiledPDFView setPage:page];
    [self.contentView addSubview:tiledPDFView];
    
    [self.contentView bringSubviewToFront:pageNumberBackgroundView];
    
    [pageNumberLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)pageNumber]];
    [self.contentView bringSubviewToFront:pageNumberLabel];
    
    [self.contentView bringSubviewToFront:currentPageBorder];
}

- (void)setSelected:(BOOL)selected
{
    [currentPageBorder setHidden:!selected];
    [super setSelected:selected];
}

@end
