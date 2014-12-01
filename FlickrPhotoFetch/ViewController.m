//
//  ViewController.m
//  FlickrPhotoFetch
//
//  Created by Lu Quan Tan on 11/29/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import "ViewController.h"
#import "FlickrFetcher.h"
#import "FlickrWebService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [FlickrWebService gettingInfoFromFlickrFormat];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
