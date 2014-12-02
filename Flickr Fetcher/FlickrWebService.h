//
//  FlickrWebService.h
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/1/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FlickrWebService : NSObject

//+ (void)getImageWithQuery:(NSURL *)url withBackgroundCompletion:(void(^)(UIImage *image, NSError *error))completionBlock;
+ (void)getDataFromQuery:(NSURL *)url withBackgroundCompletion:(void(^)(NSDictionary *, NSError *))completionBlock;

+ (void)getTopPlacesInBackgroundWithCompletion:(void(^)(NSArray *results, NSError *error))completion;
@end
