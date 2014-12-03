//
//  LQTop50PlacesModel.h
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/3/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQTop50PlacesModel : NSObject

@property (nonatomic, strong) NSDictionary *photo;

- (NSString *)tableViewDescriptionForPhoto;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
