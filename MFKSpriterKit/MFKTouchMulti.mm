//
//  MFKTouchMulti.h
//  MFKSpriterKit
//
//  Created by mefik on 01.02.15.
//  Copyright 2015 mefik-studio. All rights reserved.
//

#import "MFKTouchMulti.h"
#import "MFKTypes.h"

@implementation MFKTouchMulti
@synthesize touchBegin;
@synthesize touchMenu;
@synthesize beginLocation;
@synthesize lastLocation;
@synthesize swipeDirection;

+ (MFKTouchMulti *) newTouchMulti: (UITouch *) theTouch {
    MFKTouchMulti *tm = [[MFKTouchMulti alloc] init];
    [tm setTouchBegin:theTouch];
    [tm setTouchEnded:false];
    [tm setTouchMenu:false];
    return tm;
}

- (void) dealloc {
    SAFE_ARC_SUPER_DEALLOC();
}

@end
