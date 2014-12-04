//
//  FlickrWebService.m
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/1/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import "FlickrWebService.h"
#import "FlickrFetcher.h"

#import "LQTopPlaceModel.h"
#import "LQTopPlacesPhotos.h"

@implementation FlickrWebService
+ (void)getDataFromQuery:(NSURL *)url withBackgroundCompletion:(void(^)(NSDictionary *dictionary, NSError *error))completionBlock
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
       
            NSData *jsonResults = [NSData dataWithContentsOfURL:location];
            NSDictionary *propertyListResult = [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL];
        
            if (completionBlock) completionBlock(propertyListResult, error);
        
    }];
    [task resume];
}

+ (void)getPhotoFromQuery:(NSURL *)url withBackgroundCompletion:(void(^)(UIImage *image, NSError *error))completionBlock
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
            if (completionBlock) completionBlock(image, nil);
        } else {
            if (completionBlock) completionBlock(nil, error);
        }
        
    }];
    [task resume];
    
}

+ (void)getTopPlacesInBackgroundWithCompletion:(void(^)(NSArray *results, NSError *error))completion
{
    [FlickrWebService getDataFromQuery:[FlickrFetcher URLforTopPlaces] withBackgroundCompletion:^(NSDictionary *dictionary, NSError *error) {
        if (dictionary) {
            NSArray *topPlacesRaw = [dictionary valueForKeyPath:FLICKR_RESULTS_PLACES];
            NSMutableArray *returnArray = [NSMutableArray array];
            for (NSDictionary *topPlaceDict in topPlacesRaw) {
                LQTopPlaceModel *topPlace = [[LQTopPlaceModel alloc] initWithDictionary:topPlaceDict];
                [returnArray addObject:topPlace];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) completion(returnArray, nil);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) completion(nil, error);
            });
        }
    }];
}

+ (void)getTopPlacesWithPlaceId:(NSString *)placeId withMaxResult:(int)maxResult withBackgroundCompletion:(void(^)(NSArray *results, NSError *error))completion
{
    [FlickrWebService getDataFromQuery:[FlickrFetcher URLforPhotosInPlace:placeId maxResults:maxResult] withBackgroundCompletion:^(NSDictionary *dictionary, NSError *error) {
        if (dictionary) {
            NSDictionary *photoDict = [dictionary valueForKeyPath:FLICKR_RESULTS_PHOTOS];
            NSMutableArray *photos = [[NSMutableArray alloc] init];
            for (NSDictionary *photoInfo in photoDict) {
                LQTopPlacesPhotos *model = [[LQTopPlacesPhotos alloc] initWithDictionary:photoInfo];
                [photos addObject:model];
            }
    
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) completion(photos, nil);
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) completion(nil, error);
            });
        }
    }];
}

+ (void)getPhoto:(NSDictionary *)photo withFormat:(FlickrPhotoFormat)format withBackgroundCompletion:(void(^)(UIImage *image, NSError *error))completion
{
    [FlickrWebService getPhoto:photo withFormat:format withBackgroundCompletion:^(UIImage *image, NSError *error) {
        if (!error && image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) completion(image, nil);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) completion(nil, error);
            });
        }
    }];
}

@end
