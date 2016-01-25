//
//  XTPDFScrollView.h
//  PDFViewer
//
//  Created by Pavel Dolgov on 25/01/16.
//  Copyright © 2016 Pavel Dolgov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class XTPDFTiledView;

@interface XTPDFScrollView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic) CGRect pageRect;
@property (nonatomic, weak) XTPDFTiledView * tiledPDFView;
@property (nonatomic) CGPDFPageRef PDFPage;
@property (nonatomic) CGFloat PDFScale;
@property (nonatomic) BOOL hasChangedSize;

- (void)setPage:(CGPDFPageRef)page;

@end
