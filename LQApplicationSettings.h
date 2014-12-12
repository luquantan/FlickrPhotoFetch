//
//  LQApplicationSettings.h
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/4/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQApplicationSettings : NSObject

+ (instancetype)sharedSettings;
@property (nonatomic, strong) NSArray *recentPhotos;

@end
