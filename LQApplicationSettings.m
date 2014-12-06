//
//  LQApplicationSettings.m
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/4/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import "LQApplicationSettings.h"

static NSString * const LQApplicationSettingsSavePhotosKey = @"LQApplicationSettingsSavePhotosKey";
static NSInteger const LQApplicationSettingsMaxNumberOfRecentPhotos = 50;

@interface LQApplicationSettings()

@end

@implementation LQApplicationSettings

@synthesize recentPhotos = _recentPhotos;

- (NSArray *)recentPhotos
{
    _recentPhotos = [self loadRecentPhotos];
    return _recentPhotos;
}

- (void)setRecentPhotos:(NSArray *)recentPhotos
{
    _recentPhotos = recentPhotos;
    [self saveRecentPhotos:[self validifyRecentPhotosToSave:recentPhotos]];
}

- (NSArray *)validifyRecentPhotosToSave:(NSArray *)photos
{
    NSMutableOrderedSet *set = [[NSMutableOrderedSet alloc] initWithArray:photos];
    NSUInteger setCount = [set count];
    if (setCount > LQApplicationSettingsMaxNumberOfRecentPhotos) {
        [set removeObjectsInRange:NSMakeRange(LQApplicationSettingsMaxNumberOfRecentPhotos, setCount - LQApplicationSettingsMaxNumberOfRecentPhotos)];
    }
    NSArray *returnArray = [set array];
    return returnArray;
}

+ (instancetype)sharedSettings
{
    static LQApplicationSettings *settings = nil;
    static dispatch_once_t singleToken;
    dispatch_once(&singleToken, ^{
        settings = [[self alloc] init];
    });
    return settings;
}

- (void)saveRecentPhotos:(NSArray *)photos
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:photos];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:LQApplicationSettingsSavePhotosKey];
    [defaults synchronize];
}

- (id)loadRecentPhotos
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:LQApplicationSettingsSavePhotosKey];
    if (data) {
        NSArray *photos = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return photos;
    } else {
        return @[];
    }
}

@end
