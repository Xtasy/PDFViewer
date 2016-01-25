//
//  ViewController.m
//  PDFViewer
//
//  Created by Pavel Dolgov on 25/01/16.
//  Copyright © 2016 Pavel Dolgov. All rights reserved.
//

#import "ViewController.h"
#import "XTPDFContainerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"demo"
                                                     ofType:@"pdf"];
    
    NSData * data = [NSData dataWithContentsOfFile:path];
    
    XTPDFContainerViewController * vc = [[XTPDFContainerViewController alloc] initWithFileData:data];
    [vc.view setFrame:self.view.frame];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
