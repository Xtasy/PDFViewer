//
//  XTPDFFileModel.h
//  PDFViewer
//
//  Created by Pavel Dolgov on 25/01/16.
//  Copyright © 2016 Pavel Dolgov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XTPDFFileModel : NSObject

@property CGPDFDocumentRef pdf;
@property NSUInteger numberOfPages;

+ (instancetype)pagedPdfByPath:(NSURL *)path;
+ (instancetype)pagedPdfByData:(NSData *)data;

@end
