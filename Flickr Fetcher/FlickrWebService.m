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

+ (void)getDataFromQuery:(NSURL *)url WithBackgroundCompletion:(void(^)(NSDictionary *dictionary))completionBlock
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSData *jsonResults = [NSData dataWithContentsOfURL:location];
            NSDictionary *propertyListResult = [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL];
            if (completionBlock) completionBlock(propertyListResult);
        }
    }];
    [task resume];
}

+(void)getTopPlacesInBackgroundWithCompletion:(void(^)(NSArray *results, NSError *error))completion
{
    [FlickrWebService getDataFromQuery:[FlickrFetcher URLforTopPlaces] WithBackgroundCompletion:^(NSDictionary *dictionary) { //this will not run
        if (dictionary) {
            // TODO: Make Constants
            NSArray *topPlacesRaw = [dictionary valueForKeyPath:FLICKR_RESULTS_PLACES];
            NSMutableArray *returnArray = [NSMutableArray array];
            for (NSDictionary *topPlaceDict in topPlacesRaw) {
                LQFlickrPlace *topPlace = [[LQFlickrPlace alloc] initWithDictionary:topPlaceDict];
                [returnArray addObject:topPlace];
            }
            
            NSArray *countries = [returnArray valueForKey:@"country"];
            NSSet *allCountries = [NSSet setWithArray:countries];
            
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"country" ascending:YES];
            NSArray *filteredResults = [returnArray sortedArrayUsingDescriptors:@[sortDescriptor]];

            
            
            completion(returnArray, nil);
        } else {
        // TODO: Define Error
            completion(nil, [NSError errorWithDomain:@"LuQuan.Domain" code:1 userInfo:nil]);
        }
    }];
}

@end
