//
//  XTPDFTiledView.h
//  PDFViewer
//
//  Created by Pavel Dolgov on 25/01/16.
//  Copyright © 2016 Pavel Dolgov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTPDFTiledView : UIView

@property CGPDFPageRef pdfPage;
@property CGFloat currentScale;

- (id)initWithFrame:(CGRect)frame scale:(CGFloat)scale;
- (void)setPage:(CGPDFPageRef)newPage;

@end
