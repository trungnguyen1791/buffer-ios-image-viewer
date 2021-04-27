//
//  SecondViewController.m
//  BFRImageViewer
//
//  Created by Andrew Yates on 20/11/2015.
//  Copyright © 2015 Andrew Yates. All rights reserved.
//

#import "SecondViewController.h"
#import "BFRImageViewController.h"

@interface SecondViewController () <UIViewControllerPreviewingDelegate>
@property (strong, nonatomic) NSArray *imgURLs;
@end

@implementation SecondViewController

- (instancetype) init {
    if (self = [super init]) {
        self.title = @"Multiple Images";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *openImageFromURL = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    openImageFromURL.translatesAutoresizingMaskIntoConstraints = NO;
    [openImageFromURL setTitle:@"Open Images" forState:UIControlStateNormal];
    [openImageFromURL addTarget:self action:@selector(openImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openImageFromURL];
    [openImageFromURL.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [openImageFromURL.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    
    if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)] && self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self check3DTouch];
    }
    
    NSURL *url1 = [NSURL URLWithString:@"https://enkei.com/wp-content/uploads/2015/01/GT7-Silver-lr.jpg"];
    NSURL *url2 = [NSURL URLWithString:@"https://enkei.com/wp-content/uploads/2015/01/GT7-Black-LR.jpg"];
    NSURL *url3 = [NSURL URLWithString:@"http://i.imgur.com/XBnuETM.jpg"];
//    self.imgURLs = @[url1, url2, url3];
    
    LocalImageObject *obj1 = [LocalImageObject new];
    obj1.urlString = @"https://enkei.com/wp-content/uploads/2015/01/GT7-Silver-lr.jpg";
    obj1.title = @"Image so 1 ";
    
    LocalImageObject *obj2 = [LocalImageObject new];
    obj2.urlString = @"https://enkei.com/wp-content/uploads/2015/01/GT7-Black-LR.jpg";
    obj2.title = @"2021-04-01 16:01:29.248783+0700 BFRImageViewer[4831:223011] [] nw_protocol_get_quic_image_block_invoke dlopen libquic failed";
    
    self.imgURLs = @[obj1, obj2];
}

- (void)openImage {
    BFRImageViewController *imageVC = [[BFRImageViewController alloc] initWithImageSource:self.imgURLs];
    imageVC.startingIndex = 0; // Default
    [self presentViewController:imageVC animated:YES completion:nil];
}

#pragma mark - 3D Touch
- (void)check3DTouch {
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
}

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    return [[BFRImageViewController alloc] initWithImageSource:self.imgURLs];
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self presentViewController:viewControllerToCommit animated:YES completion:nil];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)] && self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self check3DTouch];
    }
}
@end
