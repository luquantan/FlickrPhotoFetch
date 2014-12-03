//
//  LQTopPlacesTableViewSection.m
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/3/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import "LQTopPlacesTableViewSection.h"

@implementation LQTopPlacesTableViewSection

- (NSMutableArray *)associatedPlaces
{
    if (!_associatedPlaces) {
        _associatedPlaces = [NSMutableArray array];
    }
    return _associatedPlaces;
}


@end
