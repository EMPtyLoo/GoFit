//
//  DiscoverModel.m
//  GoFit
//
//  Created by EMPty on 2/7/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import "DiscoverModel.h"

@implementation DiscoverModel
- (id) initWithDic:(NSDictionary*) dic
{
    if (self = [super init]) {
        _name = [dic objectForKey:@"name"];
        _mainImage = [dic objectForKey:@"mainImage"];
        _icon = [dic objectForKey:@"icon"];
        _sign = [dic objectForKey:@"sign"];
        _mainText = [dic objectForKey:@"mainText"];
        _comments = [dic objectForKey:@"comments"];
        NSLog(@"%@",_mainImage);
        
    }
    
    return self;
    
}

+ (id) discoverWithDic:(NSDictionary*) dic
{
    
    return [[self alloc]initWithDic:dic];
}
@end
