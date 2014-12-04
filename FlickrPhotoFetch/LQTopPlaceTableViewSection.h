//
//  LQTopPlacesTableViewSection.h
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/3/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQTopPlaceTableViewSection : NSObject

@property (strong, nonatomic) NSString *countryName;
@property (strong, nonatomic) NSMutableArray *associatedPlaces;

@end
