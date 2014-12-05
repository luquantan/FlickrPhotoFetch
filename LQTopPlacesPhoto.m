//
//  LQTopPlacesPhoto.m
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/3/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import "LQTopPlacesPhoto.h"

static NSString * const LQTopPlacesPhotoTitleKey = @"title";
static NSString * const LQTopPlacesPhotoDescriptionKey = @"description._content";
static NSString * const LQTopPlacesPhotoFarmKey = @"farm";
static NSString * const LQTopPlacesPhotoServerKey = @"server";
static NSString * const LQTopPlacesPhotoPhotoIdKey = @"id";
static NSString * const LQTopPlacesPhotoSecretKey = @"secret";
static NSString * const LQTopPlacesPhotoOriginalSecretKey = @"originalsecret";
static NSString * const LQTopPlacesPhotoFileTypeKey = @"originalformat";

@interface LQTopPlacesPhoto()
@property (nonatomic, strong) NSString *photoTitle;
@property (nonatomic, strong) NSString *photoDescription;

@end

@implementation LQTopPlacesPhoto

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.photoTitle = [dictionary objectForKey:LQTopPlacesPhotoTitleKey];
        self.photoDescription = [dictionary valueForKeyPath:LQTopPlacesPhotoDescriptionKey];
        
        self.farm = [dictionary objectForKey:LQTopPlacesPhotoFarmKey];
        self.server = [dictionary objectForKey:LQTopPlacesPhotoServerKey];
        self.photoId = [dictionary objectForKey:LQTopPlacesPhotoPhotoIdKey];
        self.secret = [dictionary objectForKey:LQTopPlacesPhotoSecretKey];
        self.fileType = [dictionary objectForKey:LQTopPlacesPhotoFileTypeKey];
        self.originalsecret = [dictionary objectForKey:LQTopPlacesPhotoOriginalSecretKey];
        
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

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.farm forKey:LQTopPlacesPhotoFarmKey];
    [coder encodeObject:self.server forKey:LQTopPlacesPhotoServerKey];
    [coder encodeObject:self.photoId forKey:LQTopPlacesPhotoPhotoIdKey];
    [coder encodeObject:self.secret forKey:LQTopPlacesPhotoSecretKey];
    [coder encodeObject:self.originalsecret forKey:LQTopPlacesPhotoOriginalSecretKey];
    [coder encodeObject:self.fileType forKey:LQTopPlacesPhotoFileTypeKey];
    [coder encodeObject:self.photoTitle forKey:LQTopPlacesPhotoTitleKey];
    [coder encodeObject:self.photoDescription forKey:LQTopPlacesPhotoDescriptionKey];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.farm = [coder decodeObjectForKey:LQTopPlacesPhotoFarmKey];
        self.server = [coder decodeObjectForKey:LQTopPlacesPhotoServerKey];
        self.photoId = [coder decodeObjectForKey:LQTopPlacesPhotoPhotoIdKey];
        self.secret = [coder decodeObjectForKey:LQTopPlacesPhotoSecretKey];
        self.originalsecret = [coder decodeObjectForKey:LQTopPlacesPhotoOriginalSecretKey];
        self.fileType = [coder decodeObjectForKey:LQTopPlacesPhotoFileTypeKey];
        self.photoTitle = [coder decodeObjectForKey:LQTopPlacesPhotoTitleKey];
        self.photoDescription = [coder decodeObjectForKey:LQTopPlacesPhotoDescriptionKey];
    }
    return self;
}
@end
