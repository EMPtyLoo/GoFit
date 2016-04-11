//
//  HomeTipsModel.h
//  GoFit
//
//  Created by EMPty on 3/8/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeTipsModel : NSObject
@property (nonatomic) NSString* titile;
@property (nonatomic) NSString* image;
@property (nonatomic) NSString* from;
@property (nonatomic) NSString* time;
//@property (nonatomic) NSString* from;
- (id) initWithDic:(NSDictionary*) dic;
+ (id) homeTipsWithDic:(NSDictionary*) dic;
@end
