//
//  main.m
//  MFKSpriterKit
//
//  Created by mefik on 03.11.14.
//  Copyright (c) 2014 mefik-studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
#if __has_feature(objc_arc)
    NSLog(@"ARC on");
#else
    NSLog(@"ARC off");
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
#endif
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
#if !__has_feature(objc_arc)
    [pool release];
#endif
    return retVal;
}
