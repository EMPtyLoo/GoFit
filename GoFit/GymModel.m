//
//  GymModel.m
//  GoFit
//
//  Created by EMPty on 12/11/15.
//  Copyright (c) 2015 EMPty. All rights reserved.
//

#import "GymModel.h"

@implementation GymModel
- (id) initWithDic:(NSDictionary*) dic
{
    if (self = [super init]) {
        self.name = [dic valueForKey:@"name"];
        self.address = [dic valueForKey:@"address"];
        self.phone = [dic valueForKey:@"phone"];
        self.count = [dic valueForKey:@"count"];
        self.distance = [dic valueForKey:@"distance"];
        self.icon = [dic valueForKey:@"icon"];
        NSLog(@"name:%@,address:%@,phone:%@,count:%@,distance:%@,icon:%@",_name,_address,_phone,_count,_distance,_icon);
    }
    return self;
}

+ (id) gymWithDic:(NSDictionary*) dic
{
    return [[self alloc]initWithDic:dic];
}
@end
