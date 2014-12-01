//
//  FlickrWebService.m
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/1/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import "FlickrWebService.h"
#import "FlickrFetcher.h"

@implementation FlickrWebService

+ (void)getImageWithQuery:(NSURL *)url withBackgroundCompletion:(void (^)(UIImage *, NSError *))completionBlock
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        UIImage *image;
        if (!error) {
            image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock) completionBlock(image, error);
        });
    }];
    [task resume];
}

+ (void)gettingInfoFromFlickrFormat
{
    NSURL *url = [FlickrFetcher URLforTopPlaces]; //Need to tailor this to allow for user to query anything
#warning Blocks Main Thread
    NSData *jsonResults = [NSData dataWithContentsOfURL:url];
    NSLog(@"JSON = %@", jsonResults);
    NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                        options:0
                                                                          error:NULL];
    NSLog(@"flickr results = %@",propertyListResults);
}
@end
