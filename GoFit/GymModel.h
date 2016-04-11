//
//  GymModel.h
//  GoFit
//
//  Created by EMPty on 12/11/15.
//  Copyright (c) 2015 EMPty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GymModel : NSObject
@property(nonatomic) NSString* name;
@property(nonatomic) NSString* phone;
@property(nonatomic) NSString* address;
@property(nonatomic) NSString* icon;
@property(nonatomic) NSString* distance;
@property(nonatomic) NSString* count;
- (id) initWithDic:(NSDictionary*) dic;
+ (id) gymWithDic:(NSDictionary*) dic;
@end
