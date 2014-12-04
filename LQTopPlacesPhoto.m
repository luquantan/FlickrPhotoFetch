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


//if (format == FlickrPhotoFormatOriginal) secret = [photo objectForKey:@"originalsecret"];
//
//NSString *fileType = @"jpg";
//if (format == FlickrPhotoFormatOriginal) fileType = [photo objectForKey:@"originalformat"];
//
//if (!farm || !server || !photo_id || !secret) return nil;
//
//NSString *formatString = @"s";
//switch (format) {
//    case FlickrPhotoFormatSquare:    formatString = @"s"; break;
//    case FlickrPhotoFormatLarge:     formatString = @"b"; break;
//    case FlickrPhotoFormatOriginal:  formatString = @"o"; break;
//}
//

@implementation LQTopPlacesPhoto

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.photoTitle = [dictionary valueForKey:LQTopPlacesPhotoTitleKey];
        self.photoDescription = [dictionary valueForKeyPath:LQTopPlacesPhotoDescriptionKey];
        
        self.farm = [dictionary valueForKey:LQTopPlacesPhotoFarmKey];
        self.server = [dictionary valueForKey:LQTopPlacesPhotoServerKey];
        self.photoId = [dictionary valueForKey:LQTopPlacesPhotoPhotoIdKey];
        self.secret = [dictionary valueForKey:LQTopPlacesPhotoSecretKey];
        self.fileType = [dictionary valueForKey:LQTopPlacesPhotoFileTypeKey];
        self.originalsecret = [dictionary valueForKey:LQTopPlacesPhotoOriginalSecretKey];
        
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
