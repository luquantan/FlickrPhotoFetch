//
//  LQTopPlacesPhotos.m
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/3/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import "LQTopPlacesPhotos.h"

static NSString * const LQTop50PlacesModelPhotoTitleKey = @"title";
static NSString * const LQTop50PlacesModelPhotoDescriptionKey = @"description._content";

@interface LQTopPlacesPhotos()
@property (nonatomic, strong) NSString *photoTitle;
@property (nonatomic, strong) NSString *photoDescription;
@end

@implementation LQTopPlacesPhotos

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.photo = dictionary;
        
        self.photoTitle = [dictionary valueForKey:LQTop50PlacesModelPhotoTitleKey];
        self.photoDescription = [dictionary valueForKeyPath:LQTop50PlacesModelPhotoDescriptionKey];
    }
    return self;
}

- (NSString *)tableViewDescriptionForPhoto
{
    NSString *description = nil;
    if ([self.photoTitle length]) {
        description = self.photoTitle;
    } else if ([self.photoDescription length]) {
        description = self.photoDescription;
    } else {
        description = @"Unknown";
    }
    return description;
}

@end
