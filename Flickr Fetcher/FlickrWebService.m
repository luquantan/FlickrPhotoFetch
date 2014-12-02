//
//  FlickrWebService.m
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/1/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import "FlickrWebService.h"
#import "FlickrFetcher.h"
#import "LQFlickrPlace.h"

@implementation FlickrWebService

static NSString * const LQFlickrPlaceCountryPropertyKey = @"country";

//+ (void)getImageWithQuery:(NSURL *)url withBackgroundCompletion:(void (^)(UIImage *, NSError *))completionBlock
//{
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
//    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//        UIImage *image;
//        if (!error) {
//            image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (completionBlock) completionBlock(image, error);
//        });
//    }];
//    [task resume];
//}

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

+ (void)getTopPlacesInBackgroundWithCompletion:(void(^)(NSArray *results, NSError *error))completion
{
    [FlickrWebService getDataFromQuery:[FlickrFetcher URLforTopPlaces] withBackgroundCompletion:^(NSDictionary *dictionary, NSError *error) {
        if (dictionary) {

            NSArray *topPlacesRaw = [dictionary valueForKeyPath:FLICKR_RESULTS_PLACES];
            NSMutableArray *returnArray = [NSMutableArray array];
            for (NSDictionary *topPlaceDict in topPlacesRaw) {
                LQFlickrPlace *topPlace = [[LQFlickrPlace alloc] initWithDictionary:topPlaceDict];
                [returnArray addObject:topPlace];
            }
//            NSArray *countries = [returnArray valueForKey:LQFlickrPlaceCountryPropertyKey];
//            NSSet *allCountries = [NSSet setWithArray:countries];
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:LQFlickrPlaceCountryPropertyKey ascending:YES];
            NSArray *filteredResults = [returnArray sortedArrayUsingDescriptors:@[sortDescriptor]];

            
            if (completion) completion(filteredResults, nil);
        } else {
            if (completion) completion(nil, error);
        }
    }];
}

@end
