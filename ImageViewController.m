//
//  ImageViewController.m
//  ImaginariumDemo
//
//  Created by LuQuan Intrepid on 11/24/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "ImageViewController.h"
#import "UIImage+Sizing.h"
#import "FlickrWebService.h"
#import "LQTopPlacesPhoto.h"

@interface ImageViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIImage *image;
@end

@implementation ImageViewController
- (void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    _scrollView.minimumZoomScale = 1.0;
    _scrollView.maximumZoomScale = 5.0;
    _scrollView.delegate = self;
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
    }
    return _imageView;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
}

- (void)setPhoto:(LQTopPlacesPhoto *)photo
{
    _photo = photo;
    [self.activityIndicator startAnimating];
    [FlickrWebService getPhoto:_photo withFormat:FlickrPhotoFormatOriginal withBackgroundCompletion:^(UIImage *image, NSError *error) {
        if (!error && image) {
            self.image = image;
        } else {
            NSLog(@"%@", error);
        }
        [self.activityIndicator stopAnimating];
    }];
}

- (UIImage *)image
{
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
    
    
    if (image) {
        CGSize sizeThatFits = [image sizeThatFits:self.scrollView.bounds.size];
        self.imageView.frame = CGRectMake(0, 0, sizeThatFits.width, sizeThatFits.height);
        self.scrollView.contentSize = self.imageView.bounds.size;
    } else {
        self.scrollView.contentSize = CGSizeZero;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
}


@end
