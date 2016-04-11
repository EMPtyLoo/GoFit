//
//  HomeTipsModel.m
//  GoFit
//
//  Created by EMPty on 3/8/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import "HomeTipsModel.h"
//SDWebImage
//#import "UIImageView+WebCache.h"

@implementation HomeTipsModel
- (id) initWithDic:(NSDictionary*) dic
{
    if (self = [super init]) {
        NSLog(@"%@",dic);
        NSArray* arr = [dic objectForKey:@"image"];
        if (arr.count != 0) {
            
        
        NSDictionary* temp = arr[0];
        self.image = [temp objectForKey:@"url"];
        }
        
    self.titile = [dic objectForKey:@"title"];
    self.from = [dic objectForKey:@"from"];
    self.time = [dic objectForKey:@"time"];
    }
    return self;
    
}

+ (id) homeTipsWithDic:(NSDictionary*) dic
{
    return [[self alloc]initWithDic:dic];
}
@end
