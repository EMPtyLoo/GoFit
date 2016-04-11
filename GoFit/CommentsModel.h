//
//  CommentsModel.h
//  GoFit
//
//  Created by EMPty on 2/26/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentsModel : NSObject
@property (nonatomic) NSString* people;
@property (nonatomic) NSString* comments;
@property (nonatomic) NSInteger tag;
- (id) initWithDic:(NSDictionary*) dic;
+ (id) commentsWithDic:(NSDictionary*) dic;
@end
