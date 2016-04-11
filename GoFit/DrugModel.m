//
//  DrugModel.m
//  GoFit
//
//  Created by EMPty on 12/12/15.
//  Copyright (c) 2015 EMPty. All rights reserved.
//

#import "DrugModel.h"

@implementation DrugModel
- (id) initWithDic:(NSDictionary*) dic
{
    if (self = [super init]) {
       
        self.image = [dic objectForKey:@"image"];
        self.title = [dic objectForKey:@"title"];
        self.price = [dic objectForKey:@"price"];
        self.from = [dic objectForKey:@"from"];
        self.countOfBuyer = [dic objectForKey:@"countOfBuyer"];
        
        NSLog(@"image:%@  title:%@    price:%@    from:%@    countOfBuyer:%@",_image,_title,_price,_from,_countOfBuyer);
    }
    return self;

}

+ (id) drugWithDic:(NSDictionary*) dic
{
    return [[self alloc]initWithDic:dic];

}
@end
