//
//  MyAnnotation.h
//  GoFit
//
//  Created by EMPty on 3/6/16.
//  Copyright (c) 2016 EMPty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MyAnnotation : NSObject<MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (id)initWithCoordinate2D:(CLLocationCoordinate2D) coordinate;
+ (NSString*) reusedID;

@end
