//
//  LQTopPlacesPhoto.h
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/3/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQTopPlacesPhoto : NSObject

@property (nonatomic, strong) NSString *farm;
@property (nonatomic, strong) NSString *server;
@property (nonatomic, strong) NSString *photoId;
@property (nonatomic, strong) NSString *secret;
@property (nonatomic, strong) NSString *originalsecret;
@property (nonatomic, strong) NSString *fileType;

- (NSString *)tableViewDescriptionForPhoto;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
