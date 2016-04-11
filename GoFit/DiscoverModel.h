//
//  DiscoverModel.h
//  GoFit
//
//  Created by EMPty on 2/7/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverModel : NSObject
@property (nonatomic) NSString* icon;
@property (nonatomic) NSString* mainImage;
@property (nonatomic) NSString* name;
@property (nonatomic) NSString* sign;
@property (nonatomic) NSString* mainText;
@property (nonatomic) NSArray* peopleWhoLike;
@property (nonatomic) NSArray* comments;
@property (nonatomic) NSInteger tag;
- (id) initWithDic:(NSDictionary*) dic;
+ (id) discoverWithDic:(NSDictionary*) dic;

@end
