//
//  LQTopPlacesPhoto.h
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/3/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQTopPlacesPhoto : NSObject

@property (nonatomic, strong) id farm;
@property (nonatomic, strong) id server;
@property (nonatomic, strong) id photoId;
@property (nonatomic, strong) id secret;
@property (nonatomic, strong) id originalsecret;
@property (nonatomic, strong) id fileType;

- (NSString *)tableViewDescriptionForPhoto;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
