//
//  XTPDFContainerViewController.h
//  PDFViewer
//
//  Created by Pavel Dolgov on 25/01/16.
//  Copyright © 2016 Pavel Dolgov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTPDFFileModel.h"
#import "XTPDFScrollView.h"

@interface XTPDFContainerViewController : UIViewController <UIGestureRecognizerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property CGPDFPageRef currentPage;
@property CGFloat currentScale;
@property (nonatomic, strong) XTPDFFileModel * data;
@property (nonatomic, strong) XTPDFScrollView * scrollView;
@property (nonatomic, strong) UICollectionView * miniaturesView;

- (instancetype)initWithFileData:(NSData *)data;

- (void)showCurrentPage;
- (void)setPageNumber:(NSUInteger)pageNumber;
- (NSUInteger)pageNumber;

@end
