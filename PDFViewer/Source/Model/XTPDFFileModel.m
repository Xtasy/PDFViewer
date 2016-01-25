//
//  XTPDFFileModel.m
//  PDFViewer
//
//  Created by Pavel Dolgov on 25/01/16.
//  Copyright © 2016 Pavel Dolgov. All rights reserved.
//

#import "XTPDFFileModel.h"

@implementation XTPDFFileModel

+ (instancetype)pagedPdfByPath:(NSURL *)path
{
    XTPDFFileModel * fileModel = [XTPDFFileModel new];
    CGPDFDocumentRef pdf = CGPDFDocumentCreateWithURL((__bridge CFURLRef) path);
    [fileModel setPdf:pdf];
    [fileModel setNumberOfPages:CGPDFDocumentGetNumberOfPages(pdf)];
    return fileModel;
}

+ (instancetype)pagedPdfByData:(NSData *)data
{
    XTPDFFileModel * fileModel = [XTPDFFileModel new];
    CFDataRef PDFData = (__bridge CFDataRef)data;
    CGDataProviderRef provider = CGDataProviderCreateWithCFData(PDFData);
    CGPDFDocumentRef pdf = CGPDFDocumentCreateWithProvider(provider);
    [fileModel setPdf:pdf];
    [fileModel setNumberOfPages:CGPDFDocumentGetNumberOfPages(pdf)];
    return fileModel;
}

- (void)dealloc
{
    if(self.pdf != NULL) CGPDFDocumentRelease(self.pdf);
}

@end
