//
//  LQTop50PlacesModel.m
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/3/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import "LQTop50PlacesModel.h"

static NSString * const LQTop50PlacesModelPhotoTitleKey = @"title";
static NSString * const LQTop50PlacesModelPhotoDescriptionKey = @"description._content";
@interface LQTop50PlacesModel()
@property (nonatomic, strong) NSString *photoTitle;
@property (nonatomic, strong) NSString *photoDescription;
@end

@implementation LQTop50PlacesModel

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
    NSString *description = [[NSString alloc] init];
    
    if (self.photoTitle) {
        description = self.photoTitle;
    } else if (self.photoDescription    ) {
        description = self.photoDescription;
    } else {
        description = @"unknown";
    }
    
    return description;
}

@end
