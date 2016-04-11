//
//  DrugModel.h
//  GoFit
//
//  Created by EMPty on 12/12/15.
//  Copyright (c) 2015 EMPty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrugModel : NSObject
@property(nonatomic) NSString* image;
@property(nonatomic) NSString* title;
@property(nonatomic) NSString* price;
@property(nonatomic) NSString* from;
@property(nonatomic) NSString* countOfBuyer;
- (id) initWithDic:(NSDictionary*) dic;
+ (id) drugWithDic:(NSDictionary*) dic;
@end
