//
//  MyAnnotation.m
//  GoFit
//
//  Created by EMPty on 3/6/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

- (id)initWithCoordinate2D:(CLLocationCoordinate2D) coordinate
{
    if (self = [super init]) {
        _coordinate = coordinate;
    }
    
    return self;
}

+ (NSString*) reusedID
{
    return @"MyAnnotationReusedID";
}

@end
