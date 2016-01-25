//
//  XTPDFMiniatureCustomCell.h
//  PDFViewer
//
//  Created by Pavel Dolgov on 25/01/16.
//  Copyright © 2016 Pavel Dolgov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTPDFMiniatureCustomCell : UICollectionViewCell

- (void)setPage:(CGPDFPageRef)page pageNumber:(NSUInteger)pageNumber;

@end
