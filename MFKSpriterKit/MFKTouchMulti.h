//
//  MFKTouchMulti.h
//  iDiggers
//
//  Created by mefik on 01.02.15.
//  Copyright 2015 mefik-studio. All rights reserved.
//

#import "MFKTypes.h"

@interface MFKTouchMulti : NSObject;
@property (ARC_ASSIGN, nonatomic) UITouch *touchBegin;
@property (assign, nonatomic) bool touchMenu;
@property (assign, nonatomic) CGPoint beginLocation;
@property (assign, nonatomic) CGPoint lastLocation;
@property (assign, nonatomic) UIMYSwipeGestureRecognizerDirection swipeDirection;
@property (assign, nonatomic) bool touchEnded;
+ (MFKTouchMulti *) newTouchMulti: (UITouch *) theTouch;
- (void) dealloc;
@end
