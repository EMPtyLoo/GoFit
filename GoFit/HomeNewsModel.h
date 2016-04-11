//
//  HomeNewsModel.h
//  GoFit
//
//  Created by EMPty on 2/7/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeNewsModel : NSObject
@property (nonatomic) NSString* title;
@property (nonatomic) NSArray* images;
- (id) initWithDic:(NSArray*) array;
+ (id) homeNewsWithDic:(NSArray*) array;
@end
