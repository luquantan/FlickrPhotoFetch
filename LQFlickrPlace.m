//
//  LQFlickrPlace.m
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/1/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import "LQFlickrPlace.h"

static NSString * const LQFlickrPlaceAPIKeyPlaceId = @"place_id";

@implementation LQFlickrPlace

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.placeId = dictionary[LQFlickrPlaceAPIKeyPlaceId];
        
        NSString *placeString = dictionary[@"_content"];
        NSArray *components = [placeString componentsSeparatedByString:@", "];
        self.country = [components lastObject];
    }
    return self;
}
@end
