//
//  ImageViewController.h
//  ImaginariumDemo
//
//  Created by LuQuan Intrepid on 11/24/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQTopPlacesPhoto.h"

@interface ImageViewController : UIViewController

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, strong) LQTopPlacesPhoto *photo;
@end
