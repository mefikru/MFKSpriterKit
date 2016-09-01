//
//  MFKTypes.h
//  MFKSpriterKit
//
//  Created by mefik on 04.12.12.
//  Copyright (c) 2012 mefik-studio. All rights reserved.
//

#ifndef iDiggers_MFKTypes_h
#define iDiggers_MFKTypes_h

#if __has_feature(objc_arc)
#define ARC_ASSIGN strong
#define ARC_RETAIN strong
#define SAFE_ARC_RELEASE(x)
#define SAFE_ARC_SUPER_DEALLOC()
#else
#define ARC_ASSIGN assign
#define ARC_RETAIN retain
#define SAFE_ARC_RELEASE(x) ([(x) release])
#define SAFE_ARC_SUPER_DEALLOC() ([super dealloc])
#endif

#define MAX_TEXTUREFONTS        (1)

#define FONT_TAHOMA             0

typedef enum {
    UIMYSwipeGestureUndefined,
    UIMYSwipeGestureUp,
    UIMYSwipeGestureUpRight,
    UIMYSwipeGestureRight,
    UIMYSwipeGestureDownRight,
    UIMYSwipeGestureDown,
    UIMYSwipeGestureDownLeft,
    UIMYSwipeGestureLeft,
    UIMYSwipeGestureUpLeft,
} UIMYSwipeGestureRecognizerDirection;

typedef enum {
    UIMYTouchBegan,
    UIMYTouchMove,
    UIMYTouchEnd,
} UIMYTouchState;

typedef enum {
    GMIT_UNDEFINED,
    GMIT_PICTURE,
} MFKGameMenuItemTypeEnum;

MFKGameMenuItemTypeEnum getGameMenuItemTypeEnumByString(NSString *theString);

typedef enum {
    GMET_NORMAL                 = 0,
    GMET_OVER                   = 1,
    GMET_SELECTED               = 2,
    GMET_DISABLED               = 3,
    GMET_INVISIBLE              = 4,

    GMET_ALL                    = 5,
} MFKGameMenuEventTypeEnum;

MFKGameMenuEventTypeEnum getGameMenuEventTypeEnumByString(NSString *theString);

typedef enum {
    GMT_UNDEFINED,
    GMT_NEXT,
    GMT_NEXT2,
    GMT_NEXT3,
    GMT_PREV,
    GMT_PREV2,
    GMT_PREV3,
    GMT_SCALEPLUS,
    GMT_SCALEMINUS,
    GMT_CHOOSE,
    GMT_BONES,
    GMT_FLIPHOR,
    GMT_ROTATE,
} MFKGameMenuTypeEnum;

MFKGameMenuTypeEnum getGameMenuTypeEnumByString(NSString *theString);

typedef enum {
    VCT_FONT_TAHOMA,
    
    VCT_END,
} MFKViewControllerTextureEnum;

typedef enum {
    TJ_LEFT                                 = 0,
    TJ_RIGHT                                = 1,
    TJ_CENTER                               = 2,
} MFKTextJustifyEnum;

#endif
