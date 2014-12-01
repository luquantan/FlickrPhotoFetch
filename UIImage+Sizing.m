//
//  UIImage+ImageScalingForScrollView.m
//  ImaginariumDemo
//
//  Created by LuQuan Intrepid on 11/25/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "UIImage+Sizing.h"

@implementation UIImage (Sizing)

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize sizeThatFits = CGSizeZero;
    
    CGFloat scale = self.size.height / self.size.width;
    CGFloat widthThatFits = size.width;
    CGFloat heightThatFits = scale * widthThatFits;
    
    sizeThatFits = CGSizeMake(widthThatFits, heightThatFits);
    
    return sizeThatFits;
}

@end
