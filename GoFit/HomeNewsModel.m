//
//  HomeNewsModel.m
//  GoFit
//
//  Created by EMPty on 2/7/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import "HomeNewsModel.h"

@implementation HomeNewsModel

- (id) initWithDic:(NSArray*) array
{
    if (self = [super init]) {
        self.title = array[0];
        NSLog(@"%@",array[0]);
        self.images  = array[1];
    }
    return self;
}

+ (id) homeNewsWithDic:(NSArray*) array
{
    return [[self alloc]initWithArray:array];
    
}

@end

