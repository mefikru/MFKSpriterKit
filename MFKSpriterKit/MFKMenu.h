//
//  MFKMenu.h
//  MFKSpriterKit
//
//  Created by mefik on 04.09.15.
//  Copyright (c) 2015 mefik-studio. All rights reserved.
//

#import "MFKTypes.h"

#import "SCMLObject.h"

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/gl.h>

//////////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////////

@interface MFKGameMenuProbe : NSObject {
}
@property (assign) bool render;
+ (MFKGameMenuProbe *) newGameMenuProbe;
@end

//////////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////////

@interface MFKGameMenuItem : NSObject {
    GLfloat mapTexture[12];
    GLfloat mapViewport[12];
}
@property (assign, nonatomic) MFKGameMenuItemTypeEnum type;
@property (assign, nonatomic) long value;
@property (assign, nonatomic) GLfloat x;
@property (assign, nonatomic) GLfloat y;
@property (assign, nonatomic) GLuint textureId;

+ (MFKGameMenuItem *) newGameMenuItem: (MFKGameMenuItemTypeEnum) theType : (long) theValue;
- (void) setMapTexture: (GLfloat) theXPixel : (GLfloat) theYPixel : (long) theX : (long) theY : (long) theWidth : (long) theHeight;
- (GLfloat *) getMapTexture;
- (void) setMapViewport: (GLfloat) thePixel : (long) theX : (long) theY : (long) theWidth : (long) theHeight;
- (GLfloat *) getMapViewport;
@end

//////////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////////

@interface MFKGameMenuEventField : NSObject
@property (nonatomic) CGRect rect;
+ (MFKGameMenuEventField *) newGameMenuEventField: (long) theX : (long) theY : (long) theWidth : (long) theHeight;
@end

//////////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////////

@interface MFKGameMenuEvent : NSObject {
}
@property (assign, nonatomic) MFKGameMenuEventTypeEnum type;
//@property (assign) NSMutableArray *fields;
@property (ARC_ASSIGN, nonatomic) NSMutableArray *items;
@property (assign, nonatomic) long x;
@property (assign, nonatomic) long y;
+ (MFKGameMenuEvent *) newGameMenuEvent: (MFKGameMenuEventTypeEnum) theType : (long) theX : (long) theY;
- (void) dealloc;
@end

//////////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////////

@interface MFKGameMenu : NSObject {
    MFKGameMenuEvent *events[GMET_ALL];
}
@property (assign, nonatomic) MFKGameMenuTypeEnum type;
//@property (assign) NSMutableArray *events;
@property (assign, nonatomic) long x;
@property (assign, nonatomic) long y;
@property (assign, nonatomic) long num;
@property (ARC_ASSIGN, nonatomic) MFKGameMenuEventField *field;
@property (assign, nonatomic) unsigned long delayOverPush;
@property (assign, nonatomic) long delayX;
@property (assign, nonatomic) long delayY;
@property (assign, nonatomic) MFKGameMenuEvent *currentMenuEvent;
@property (ARC_ASSIGN, nonatomic) MFKGameMenuProbe *probe;

+ (MFKGameMenu *) newGameMenu: (MFKGameMenuTypeEnum) theType : (long) theX : (long) theY : (long) theNum;
- (void) dealloc;
- (void) setEvent: (MFKGameMenuEventTypeEnum) theType : (MFKGameMenuEvent *) theEvent;
- (MFKGameMenuEvent *) getEvent: (MFKGameMenuEventTypeEnum) theType;
@end

//////////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////////

@interface MFKMenu : NSObject
@property (ARC_ASSIGN, nonatomic) NSMutableArray *menus;
@property (assign, nonatomic) MFKGameMenu *menuOver;
@property (assign, nonatomic) CGSize screenSize;
@property (assign, nonatomic) CGFloat screenScale;
@property (assign, nonatomic) CGFloat pixelSize;
@property (assign, nonatomic) GLint uniformTexture;
@property (assign, nonatomic) GLint uniformProjectionMatrix;
@property (assign, nonatomic) GLKMatrix4 matrixProjection;
@property (assign, nonatomic) SCMLTextures *texturesController;
@property (readonly) id callbackTouchMenuObj;
@property (readonly) SEL callbackTouchMenuSel;
@property (readonly) id callbackProbeMenuObj;
@property (readonly) SEL callbackProbeMenuSel;

+ (MFKMenu *) newMenu;
- (void) dealloc;
- (void) setTouchMenuCallback:(id) theObject withSelector:(SEL) theSelector;
- (void) setProbeMenuCallback:(id) theObject withSelector:(SEL) theSelector;
- (void) loadGameMenus: (NSString *) theConfigName;
- (bool) touchMenu: (UIMYTouchState) theTouchState : (CGPoint) theTouchPoint screenBounds :(CGRect) theBounds;
- (void) renderMenus;

@end
