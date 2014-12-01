//
//  TopPlacesModel.m
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/1/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import "TopPlacesModel.h"
#import "FlickrFetcher.h"
#import "FlickrWebService.h"

@interface TopPlacesModel()
@property (nonatomic, strong) NSDictionary *topPlaces;
@property (nonatomic, strong) NSMutableArray *locationArray;
@property (nonatomic, strong) NSMutableSet *countries;
@end

@implementation TopPlacesModel
@synthesize topPlaces = _topPlaces;
- (NSDictionary *)topPlaces
{
    if (!_topPlaces) {
        [FlickrWebService getDataFromQuery:[FlickrFetcher URLforTopPlaces] WithBackgroundCompletion:^(NSDictionary *dictionary) { //this will not run
            if (dictionary) {
                _topPlaces = [[NSDictionary alloc] initWithDictionary:dictionary];
            }
        }];
    }
    return _topPlaces;
}

- (void)setTopPlaces:(NSDictionary *)topPlaces
{
    _topPlaces = topPlaces;
    [self updateModel];
}

- (NSMutableSet *)countries
{
    if (!_countries) {
        _countries = [[NSMutableSet alloc] init];
    }
    return _countries;
}

- (NSMutableArray *)locationArray
{
    if (!_locationArray) {
        _locationArray = [[NSMutableArray alloc] init];
    }
    return _locationArray;
}

- (void)updateModel
{
    for (id content in self.topPlaces) {
        id locationValue = [self.topPlaces objectForKey:content];
        if ([locationValue isKindOfClass:[NSString class]]) {
            NSString *locationString = (NSString *)locationValue;
            NSArray *seperatedLocationString = [locationString componentsSeparatedByString:@","];
            [self.locationArray addObject:seperatedLocationString];
            [self.countries addObject:[seperatedLocationString lastObject]];
        }
    }
}

- (NSUInteger)numberOfCountriesInTopPlaces
{
    return [self.countries count];
}

- (NSString *)titleStringAtIndex:(NSUInteger)index
{
    NSArray *array = [[NSArray alloc] initWithArray:self.locationArray[index]];
    return [NSString stringWithFormat:@"%@",[array lastObject]];
}
- (NSString *)subtitleStringAtIndex:(NSUInteger)index
{
    NSArray *array = [[NSArray alloc] initWithArray:self.locationArray[index]];
    return [NSString stringWithFormat:@"%@, %@",array[0],array[1]];
}

@end
