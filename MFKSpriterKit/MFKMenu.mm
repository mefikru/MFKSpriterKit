//
//  MFKMenu.mm
//  MFKSpriterKit
//
//  Created by mefik on 04.09.15.
//  Copyright (c) 2015 mefik-studio. All rights reserved.
//

#import "MFKMenu.h"
#import "MFKTypes.h"
#import "MFKMenu.h"
#import "RXMLElement.h"
#import "DDMathParser.h"

//////////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////////

@implementation MFKGameMenuProbe

@synthesize render;

+ (MFKGameMenuProbe *) newGameMenuProbe {
    MFKGameMenuProbe *gmp = [[MFKGameMenuProbe alloc] init];
    [gmp setRender:true];
    return gmp;
}

@end

//////////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////////

@implementation MFKGameMenuItem

@synthesize type;
@synthesize value;
@synthesize x;
@synthesize y;
@synthesize textureId;

+ (MFKGameMenuItem *) newGameMenuItem: (MFKGameMenuItemTypeEnum) theType : (long) theValue {
    MFKGameMenuItem *gmi = [[MFKGameMenuItem alloc] init];
    [gmi setType:theType];
    [gmi setValue:theValue];
    [gmi setTextureId:0];
    return gmi;
}

- (void) setMapTexture: (GLfloat) theXPixel : (GLfloat) theYPixel : (long) theX : (long) theY : (long) theWidth : (long) theHeight {
    mapTexture[2] = (GLfloat) theX * theXPixel;
    mapTexture[3] = (GLfloat) theY * theYPixel;
    mapTexture[0] = mapTexture[2];
    mapTexture[1] = mapTexture[3] + (GLfloat) theHeight * theYPixel;
    mapTexture[4] = mapTexture[2] + (GLfloat) theWidth * theXPixel;
    mapTexture[5] = mapTexture[1];
    mapTexture[6] = mapTexture[4];
    mapTexture[7] = mapTexture[3];
    mapTexture[8] = mapTexture[4];
    mapTexture[9] = mapTexture[5];
    mapTexture[10] = mapTexture[2];
    mapTexture[11] = mapTexture[3];
}

- (GLfloat *) getMapTexture {
    return mapTexture;
}

- (void) setMapViewport: (GLfloat) thePixel : (long) theX : (long) theY : (long) theWidth : (long) theHeight {
    mapViewport[2] = (GLfloat) theX * thePixel;
    mapViewport[3] = (GLfloat) theY * thePixel;
    mapViewport[0] = mapViewport[2];
    mapViewport[1] = mapViewport[3] + (GLfloat) theHeight * thePixel;
    mapViewport[4] = mapViewport[2] + (GLfloat) theWidth * thePixel;
    mapViewport[5] = mapViewport[1];
    mapViewport[6] = mapViewport[4];
    mapViewport[7] = mapViewport[3];
    mapViewport[8] = mapViewport[4];
    mapViewport[9] = mapViewport[5];
    mapViewport[10] = mapViewport[2];
    mapViewport[11] = mapViewport[3];
}

- (GLfloat *) getMapViewport {
    return mapViewport;
}

@end

//////////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////////

@implementation MFKGameMenuEventField

@synthesize rect;

+ (MFKGameMenuEventField *) newGameMenuEventField: (long) theX : (long) theY : (long) theWidth : (long) theHeight {
    MFKGameMenuEventField *gmef = [[MFKGameMenuEventField alloc] init];
    [gmef setRect:CGRectMake(theX, theY, theWidth, theHeight)];
    return gmef;
}

@end

//////////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////////

@implementation MFKGameMenuEvent

@synthesize type;
@synthesize items;
@synthesize x;
@synthesize y;

+ (MFKGameMenuEvent *) newGameMenuEvent: (MFKGameMenuEventTypeEnum) theType : (long) theX : (long) theY {
    MFKGameMenuEvent *gme = [[MFKGameMenuEvent alloc] init];
    [gme setItems:[[NSMutableArray alloc] init]];
    [gme setX:theX];
    [gme setY:theY];
    return gme;
}

- (void) dealloc {
    for (MFKGameMenuItem *gmi in items) if (gmi) SAFE_ARC_RELEASE(gmi);
    SAFE_ARC_RELEASE(items);
    SAFE_ARC_SUPER_DEALLOC();
}

@end

//////////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////////

@implementation MFKGameMenu

@synthesize type;
//@synthesize events;
@synthesize x;
@synthesize y;
@synthesize num;
@synthesize field;
@synthesize currentMenuEvent;
@synthesize probe;
@synthesize delayOverPush;
@synthesize delayX;
@synthesize delayY;

+ (MFKGameMenu *) newGameMenu: (MFKGameMenuTypeEnum) theType : (long) theX : (long) theY : (long) theNum {
    MFKGameMenu *gm = [[MFKGameMenu alloc] init];
    for (int i = 0; i < GMET_ALL; i++) gm->events[i] = nil;
    [gm setType:theType];
    [gm setX:theX];
    [gm setY:theY];
    [gm setNum:theNum];
    [gm setField:nil];
    [gm setDelayOverPush:0];
    [gm setDelayX:0];
    [gm setDelayY:0];
    [gm setCurrentMenuEvent:nil];
    [gm setProbe:[MFKGameMenuProbe newGameMenuProbe]];
    return gm;
}

- (void) dealloc {
    if (field) SAFE_ARC_RELEASE(field);
    for (int i = 0; i < GMET_ALL; i++) if (events[i] != nil) SAFE_ARC_RELEASE(events[i]);
    SAFE_ARC_RELEASE(probe);
    SAFE_ARC_SUPER_DEALLOC();
}

- (void) setEvent: (MFKGameMenuEventTypeEnum) theType : (MFKGameMenuEvent *) theEvent {
    if (theType < GMET_ALL) {
        //        if (events[theType] != nil) NSLog(@"!!! already");
        events[theType] = theEvent;
    }// else NSLog(@"pidzec!");
}

- (MFKGameMenuEvent *) getEvent: (MFKGameMenuEventTypeEnum) theType {
    if (theType >= GMET_ALL) return nil;
    return events[theType];
}

@end

//////////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////////

@implementation MFKMenu

@synthesize menus;
@synthesize menuOver;
@synthesize screenSize;
@synthesize screenScale;
@synthesize pixelSize;
@synthesize texturesController;
@synthesize uniformTexture;
@synthesize uniformProjectionMatrix;
@synthesize matrixProjection;
@synthesize callbackTouchMenuObj;
@synthesize callbackTouchMenuSel;
@synthesize callbackProbeMenuObj;
@synthesize callbackProbeMenuSel;

+ (MFKMenu *) newMenu {
    MFKMenu *m = [[MFKMenu alloc] init];
    [m setMenus:[[NSMutableArray alloc] init]];
    [m setScreenScale:0];
    [m setPixelSize:0];
    [m setTexturesController:nil];
    return m;
}

- (void) dealloc {
    for (MFKGameMenu *gm in menus) if (gm) SAFE_ARC_RELEASE(gm);
    SAFE_ARC_RELEASE(menus);
    SAFE_ARC_SUPER_DEALLOC();
}

- (void) setTouchMenuCallback:(id) theObject withSelector:(SEL) theSelector {
    callbackTouchMenuObj = theObject;
    callbackTouchMenuSel = theSelector;
}

- (void) setProbeMenuCallback:(id) theObject withSelector:(SEL) theSelector {
    callbackProbeMenuObj = theObject;
    callbackProbeMenuSel = theSelector;
}

- (long) getGameMenuXY: (NSString *) theString : (long) theNum {
    if ([theString length]) {
        if ([theString characterAtIndex:0] == '=')
            return [[[[[[theString substringFromIndex:1] stringByReplacingOccurrencesOfString:@"num" withString:[NSString stringWithFormat:@"%ld", theNum]] stringByReplacingOccurrencesOfString:@"w" withString:[NSString stringWithFormat:@"%d", (int) round(screenSize.width / screenScale)]] stringByReplacingOccurrencesOfString:@"h" withString:[NSString stringWithFormat:@"%d", (int) (screenSize.height / screenScale)]] numberByEvaluatingString] longValue];
        else
            return [theString intValue];
    } else return 0;
}

- (void) loadGameMenus: (NSString *) theConfigName {
    NSString *path = [[NSBundle mainBundle] pathForResource:theConfigName ofType:@"xml"];
    NSData *xml = [[NSData alloc] initWithContentsOfFile:path];
#if !__has_feature(objc_arc)
    @autoreleasepool {
#endif
        RXMLElement *doc = [RXMLElement elementFromXMLData:xml];

        NSArray *textureNodes = [doc childrenWithRootXPath:@"/plist/textures/TextureAtlas"];
        for (RXMLElement *textureElement in textureNodes) {
            NSString *ip = [textureElement attribute:@"imagePath"];
            if ([ip compare:@""] != NSOrderedSame) {
                [texturesController addTexture:ip useScalePrefix:YES];
            }
        }

        NSArray *menuNodes = [doc childrenWithRootXPath:@"/plist/menus/menu"];
        for (RXMLElement *menuElement in menuNodes) {
            NSString *menuType = [menuElement attribute:@"type"];
            MFKGameMenuTypeEnum gmt = getGameMenuTypeEnumByString(menuType);
            long num = [self getGameMenuXY:[menuElement attribute:@"num"] :1];
            if (!num) num = 1;
            for (long i = 1; i <= num; i++) {
                long x = [self getGameMenuXY:[menuElement attribute:@"x"] :i];
                long y = [self getGameMenuXY:[menuElement attribute:@"y"] :i];
                long z = [self getGameMenuXY:[menuElement attribute:@"id"] :i];
#ifdef LOG_LOAD_MENU
                NSLog(@"MENU: New menu type=%d, x=%ld, y=%ld, num=%ld", gmt, x, y, i);
#endif
                MFKGameMenu *gm = [MFKGameMenu newGameMenu:gmt :x :y :([[menuElement attribute:@"id"] compare:@""] == NSOrderedSame) ? i : z];
                [menus addObject:gm];

                NSArray *fieldNodes = [menuElement children:@"field"];
                for (RXMLElement *fieldElement in fieldNodes) {
                    long xxx = (x + [self getGameMenuXY:[fieldElement attribute:@"x"] :i]);
                    long yyy = (y + [self getGameMenuXY:[fieldElement attribute:@"y"] :i]);
                    long w = [self getGameMenuXY:[fieldElement attribute:@"width"] :i];
                    long h = [self getGameMenuXY:[fieldElement attribute:@"height"] :i];
#ifdef LOG_LOAD_MENU
                    NSLog(@"MENU:   New field x=%ld, y=%ld, w=%ld, h=%ld", xxx, yyy, w, h);
#endif
                    MFKGameMenuEventField *gmef = [MFKGameMenuEventField newGameMenuEventField :xxx :yyy :w :h];
                    [gm setField:gmef];
                    break;
                }

                NSArray *eventNodes = [menuElement children:@"event"];
                for (RXMLElement *eventElement in eventNodes) {
                    NSString *eventType = [eventElement attribute:@"type"];
                    MFKGameMenuEventTypeEnum gmet = getGameMenuEventTypeEnumByString(eventType);
                    long xx = x + [self getGameMenuXY:[eventElement attribute:@"x"] :i];
                    long yy = y + [self getGameMenuXY:[eventElement attribute:@"y"] :i];
#ifdef LOG_LOAD_MENU
                    NSLog(@"MENU:   New event type=%d, x=%ld, y=%ld", gmet, xx, yy);
#endif
                    if ([gm getEvent:gmet] != nil) {
                        NSLog(@"MENU:   Leak memory. Event already assigned.");
                        continue;
                    }
                    MFKGameMenuEvent *gme = [MFKGameMenuEvent newGameMenuEvent:gmet :xx :yy];
                    [gm setEvent:gmet :gme];
                    NSArray *itemNodes = [eventElement children:@"item"];
                    for (RXMLElement *itemElement in itemNodes) {
                        MFKGameMenuItemTypeEnum gmit = getGameMenuItemTypeEnumByString([itemElement attribute:@"type"]);
                        long xxxx = [self getGameMenuXY:[itemElement attribute:@"x"] :i];
                        long xxx = xx + xxxx;
                        long yyyy = [self getGameMenuXY:[itemElement attribute:@"y"] :i];
                        long yyy = yy + yyyy;
                        long w = [self getGameMenuXY:[itemElement attribute:@"width"] :i];
                        long h = [self getGameMenuXY:[itemElement attribute:@"height"] :i];
                        long ax = [self getGameMenuXY:[itemElement attribute:@"ax"] :i];
                        long ay = [self getGameMenuXY:[itemElement attribute:@"ay"] :i];
#ifdef LOG_LOAD_MENU
                        NSLog(@"MENU:     New item type=%d, x=%ld, y=%ld, w=%ld, h=%ld", gmit, xxx, yyy, w, h);
#endif
                        long v = [self getGameMenuXY:[itemElement attribute:@"value"] :i];
                        MFKGameMenuItem *gmi = [MFKGameMenuItem newGameMenuItem :gmit :v];
                        if (gmit == GMIT_PICTURE) {
                            NSString *t = [itemElement attribute:@"texture"];
                            if ([t compare:@""] != NSOrderedSame) {
                                [gmi setTextureId:[texturesController textureByName:t]];
                                NSString *sp = [NSString stringWithFormat:@"/plist/textures/TextureAtlas[@imagePath='%@']/sprite[@n='%@_%@']", t, menuType, eventType];
                                NSArray *textureNodes = [doc childrenWithRootXPath:sp];
                                if ([textureNodes count]) {
                                    RXMLElement *textureElement = [textureNodes objectAtIndex:0];
                                    w = (long) [[textureElement attribute:@"w"] longLongValue];
                                    h = (long) [[textureElement attribute:@"h"] longLongValue];
                                    ax = (long) [[textureElement attribute:@"x"] longLongValue];
                                    ay = (long) [[textureElement attribute:@"y"] longLongValue];
                                } else {
                                    NSLog(@"Cannot find appropriate Sprite '%@_%@' in TextureAtlas '%@'", menuType, eventType, t);
                                }
                            }
                        }
                        [gmi setMapTexture:[texturesController getXPixelSize:[gmi textureId]] :[texturesController getYPixelSize:[gmi textureId]] :ax :ay :w :h];
                        [gmi setMapViewport:pixelSize :xxx :yyy :w :h];
                        [[gme items] addObject:gmi];
                    }
                }
            }
        }
#if !__has_feature(objc_arc)
    }
#endif
    SAFE_ARC_RELEASE(xml);
}

- (bool) touchMenu: (UIMYTouchState) theTouchState : (CGPoint) theTouchPoint screenBounds :(CGRect) theBounds {
    bool ret = false;
    for (MFKGameMenu *gm in menus) {
        if (![[gm probe] render]) continue;
        MFKGameMenuEventField *gmef = [gm field];
        if (gmef != nil)
            if (CGRectContainsPoint([gmef rect], theTouchPoint)) {
                ret = true;

                if (theTouchState != UIMYTouchEnd) {
                    menuOver = gm;
                } else {
                    if (callbackTouchMenuObj) {
                        [callbackTouchMenuObj performSelector:callbackTouchMenuSel withObject:gm];
                    }
                }
            }
    }

    if (theTouchState != UIMYTouchEnd) {
        if (!ret) menuOver = nil;
        return ret;
    } else
        if (ret) menuOver = nil;

    return ret;
}

- (void) renderMenus {
    for (MFKGameMenu *gm in menus) {
        if (callbackProbeMenuObj) {
            [callbackProbeMenuObj performSelector:callbackProbeMenuSel withObject:gm];
            if (![[gm probe] render]) continue;
        }

        MFKGameMenuEvent *gme;
        gme = [gm getEvent:GMET_NORMAL];

        bool noOver = false;

        if ((menuOver == gm) && !noOver) {
            gme = [gm getEvent:GMET_OVER];
            if (gme == nil) {
                gme = [gm getEvent:GMET_SELECTED];
                if (gme == nil) gme = [gm getEvent:GMET_NORMAL];
            }
        }

        if ([gm currentMenuEvent] == nil)
            [gm setCurrentMenuEvent:gme];
        else if ([gm currentMenuEvent] != gme) {
            [gm setDelayX:[gme x] - [[gm currentMenuEvent] x]];
            [gm setDelayY:[gme y] - [[gm currentMenuEvent] y]];
            [gm setCurrentMenuEvent:gme];
        }
        GLfloat xxx = 0.0f;
        GLfloat yyy = 0.0f;
        if ([gm delayX] != 0) {
            long xx = trunc([gm delayX] / 2);
            if (xx == 0) [gm setDelayX:0]; else [gm setDelayX:[gm delayX] - xx];
            xxx = xx * pixelSize;
        }
        if ([gm delayY] != 0) {
            long yy = trunc([gm delayY] / 2);
            if (yy == 0) [gm setDelayY:0]; else [gm setDelayY:[gm delayY] - yy];
            yyy = yy * pixelSize;
        }

        for (MFKGameMenuItem *gmi in [gme items]) {
            @try {
                GLfloat *v = nil;
                GLfloat *t = nil;
                //            MFKGameMenuIcon *gmic = nil;
                //            MFKCharacterControlButtonEnum ccb = CCB_UNDEFINED;
                switch ([gmi type]) {
                    case GMIT_PICTURE:
                        v = [gmi getMapViewport];
                        t = [gmi getMapTexture];
                        break;

                    default:
                        break;
                }
                if (v != nil && t != nil) {
                    glBindTexture(GL_TEXTURE_2D, [gmi textureId]);

                    GLKMatrix4 modelMatrix = GLKMatrix4Translate(matrixProjection, -xxx, -yyy, 0.0f);
                    glUniformMatrix4fv(uniformProjectionMatrix, 1, 0, modelMatrix.m);
                    glEnableVertexAttribArray(GLKVertexAttribPosition);
                    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
                    glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, 0, v);
                    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 0, t);
                    glDrawArrays(GL_TRIANGLES, 0, 6);
                    glDisableVertexAttribArray(GLKVertexAttribPosition);
                    glDisableVertexAttribArray(GLKVertexAttribTexCoord0);
                }
            }
            @catch (NSException *exception) {
                NSLog(@"⛔Exception in render menu: '%@'", exception.reason);
                NSLog(@"%u", [gmi type]);
            }
            @finally {

            }
        }

    }
}

@end
