//
//  TopPlacesModel.h
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/1/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TopPlacesModel : NSObject

- (NSUInteger)numberOfCountriesInTopPlaces;
- (NSString *)titleStringAtIndex:(NSUInteger)index;
- (NSString *)subtitleStringAtIndex:(NSUInteger)index;

@end
