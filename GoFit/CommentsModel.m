//
//  CommentsModel.m
//  GoFit
//
//  Created by EMPty on 2/26/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import "CommentsModel.h"

@implementation CommentsModel
- (id) initWithDic:(NSDictionary*) dic
{
    if (self = [super init]) {
        _people = [dic objectForKey:@"ID"];
        _comments = [dic objectForKey:@"text"];
           }
    
    return self;
}

+ (id) commentsWithDic:(NSDictionary*) dic
{
    return [[self alloc]initWithDic:dic];
}

@end
