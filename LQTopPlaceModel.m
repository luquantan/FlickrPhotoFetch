//
//  LQFlickrPlace.m
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/1/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import "LQTopPlaceModel.h"
#import "FlickrFetcher.h"

;

@implementation LQTopPlaceModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSString *placeString = dictionary[FLICKR_PLACE_NAME];
        NSArray *components = [placeString componentsSeparatedByString:@", "];

        self.country = [components lastObject];
        if ([components count] == 3) {
            self.province = components[0];
            self.state = components[1];
        } else if ([components count] == 2) {
            self.state = [components firstObject];
        }
        
        self.placeId = dictionary[FLICKR_PLACE_ID];
        self.woeId = dictionary[FLICKR_PLACE_WOEID];
        self.latitude = [[dictionary objectForKey:FLICKR_LATITUDE] doubleValue];
        self.longitude = [[dictionary objectForKey:FLICKR_LONGITUDE] doubleValue];
    }
    return self;
}

@end
