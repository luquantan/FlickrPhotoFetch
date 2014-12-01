//
//  LQFlickrPlace.h
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/1/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQFlickrPlace : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@property (nonatomic, copy) NSString *placeId;
@property (nonatomic, copy) NSString *woeId;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *country;
@end
