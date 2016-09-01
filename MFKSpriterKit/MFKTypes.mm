//
//  MFKTypes.mm
//  MFKSpriterKit
//
//  Created by mefik on 26.02.14.
//  Copyright (c) 2014 mefik-studio. All rights reserved.
//

#include "MFKTypes.h"

MFKGameMenuEventTypeEnum getGameMenuEventTypeEnumByString(NSString *theString) {
	MFKGameMenuEventTypeEnum gmet = GMET_NORMAL;
    if (theString) {
        if ([theString compare:@"over"] == NSOrderedSame) gmet = GMET_OVER; else
        if ([theString compare:@"selected"] == NSOrderedSame) gmet = GMET_SELECTED; else
        if ([theString compare:@"disabled"] == NSOrderedSame) gmet = GMET_DISABLED; else
        if ([theString compare:@"invisible"] == NSOrderedSame) gmet = GMET_INVISIBLE;
    }
	return gmet;
}

MFKGameMenuItemTypeEnum getGameMenuItemTypeEnumByString(NSString *theString) {
	MFKGameMenuItemTypeEnum gmit = GMIT_UNDEFINED;
    if (theString) {
        if ([theString compare:@"picture"] == NSOrderedSame) gmit = GMIT_PICTURE;
    }
#ifdef LOG_TYPE_TO_STRING
    if (gmit == GMIT_UNDEFINED) NSLog(@"!!! getGameMenuItemTypeEnumByString '%@'", theString);
#endif
    return gmit;
}

MFKGameMenuTypeEnum getGameMenuTypeEnumByString(NSString *theString) {
	MFKGameMenuTypeEnum gmt = GMT_UNDEFINED;
    if (theString) {
        if ([theString compare:@"next"] == NSOrderedSame) gmt = GMT_NEXT; else
        if ([theString compare:@"next2"] == NSOrderedSame) gmt = GMT_NEXT2; else
        if ([theString compare:@"next3"] == NSOrderedSame) gmt = GMT_NEXT3; else
        if ([theString compare:@"scale_plus"] == NSOrderedSame) gmt = GMT_SCALEPLUS; else
        if ([theString compare:@"scale_minus"] == NSOrderedSame) gmt = GMT_SCALEMINUS; else
        if ([theString compare:@"prev"] == NSOrderedSame) gmt = GMT_PREV; else
        if ([theString compare:@"prev2"] == NSOrderedSame) gmt = GMT_PREV2; else
        if ([theString compare:@"prev3"] == NSOrderedSame) gmt = GMT_PREV3; else
        if ([theString compare:@"choose"] == NSOrderedSame) gmt = GMT_CHOOSE; else
        if ([theString compare:@"bones"] == NSOrderedSame) gmt = GMT_BONES; else
        if ([theString compare:@"flip_hor"] == NSOrderedSame) gmt = GMT_FLIPHOR; else
        if ([theString compare:@"rotate"] == NSOrderedSame) gmt = GMT_ROTATE;
    }
#ifdef LOG_TYPE_TO_STRING
    if (gmt == GMT_UNDEFINED) NSLog(@"!!! getGameMenuTypeEnumByString '%@'", theString);
#endif
    return gmt;
}

MFKTextJustifyEnum getTextJustifyEnumByString(NSString *theString) {
    MFKTextJustifyEnum tj = TJ_LEFT;
    if (theString) {
        if ([theString compare:@"right"] == NSOrderedSame) tj = TJ_RIGHT; else
        if ([theString compare:@"center"] == NSOrderedSame) tj = TJ_CENTER;
    }
    return tj;
}
