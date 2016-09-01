//
//  SCMLObject.h
//  MFKSpriterKit
//       ___     ___     ___     ___     ___     ___     ___     ___
//   ___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___
//  /   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \
//  \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/
//  /   \___/                                                   \___/   \
//  \___/                                                           \___/
//  /   \    This is the SCMLObject implementation                  /   \
//  \___/           for the Spriter 2D animation character studio   \___/
//  /   \___                                                     ___/   \
//  \___/   \___     ___     ___     ___     ___     ___     ___/   \___/
//  /   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \
//  \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/
//  /   \___/                                                   \___/   \
//  \___/                                                           \___/
//  /   \    Permission is hereby granted, free of charge, to any   /   \
//  \___/  person obtaining a copy of this software and associated  \___/
//  /   \  documentation files (the "Software"), to deal in the     /   \
//  \___/  Software without restriction, including without          \___/
//  /   \  limitation the rights to use, copy, modify, merge,       /   \
//  \___/  publish, distribute, sublicense, and/or sell copies of   \___/
//  /   \  the Software, and to permit persons to whom the Software /   \
//  \___/  is furnished to do so, subject to the following          \___/
//  /   \  conditions:                                              /   \
//  \___/                                                           \___/
//  /   \     The above copyright notice and this permission notice /   \
//  \___/  shall be included in all copies or substantial portions  \___/
//  /   \  of the Software.                                         /   \
//  \___/    ___     ___     ___     ___     ___     ___     ___    \___/
//  /   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \
//  \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/
//  /   \                                                           /   \
//  \___/                                                           \___/
//  /   \  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF    /   \
//  \___/  ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED  \___/
//  /   \  TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A  THE /   \
//  \___/  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT      \___/
//  /   \  SHALL AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY     /   \
//  \___/  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION  \___/
//  /   \  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR  /   \
//  \___/  IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER      \___/
//  /   \  DEALINGS IN THE SOFTWARE.                                /   \
//  \___/                                                           \___/
//  /   \___                                                     ___/   \
//  \___/   \___     ___     ___     ___     ___     ___     ___/   \___/
//  /   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \
//  \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/
//  /   \___/   \___/   \  _/   \___        /           \___/   \___/   \
//  \___    \__                                             \  _/    ___/
//  /                                                                   \
//  \_  ▄▄▄▄▄▄▄▄▄▄▄       ▄▄▄▄▄▄▄▄       ▄▄▄▄▄▄▄▄  ▄▄▄   ▄▄▄   ▄▄▄▄▄  __/
//  /   ██ ▀█▄ ▀█▄▀█▄   ▄█▀      ▀█▄   ▄█▀      ▀█ ▀█▀█▄ ██▄▀▄█▀▄█▀     \
//  \_  ██    ▄   ▄ ▀█▄ ██   ▄██▄  ▀█ ▀▀▀▀▀▀▀▀▀▀▀▀ █▄▀▄█ █▀▄█▀ ▀█▄  \___/
//  /    ▀█▄  ██  ███▀▄ ██  ██ ▄█▀ ▄█ ██▀▀▀▀▀▀█    ██▀▄▀ ▄█▀ ▄█▄ ▀█▄    \
//  \___/ ██  ██ ▄█▀▄██ ██  ███▀ ▄█▀  ██  ▄▄▄█▀    ██  █ ██  █ ██  █   _/
//  /     ██  ██▀▀▄█▀ █ ██  ▀▀ ▄█▀▄██ ██  █        ██  █ ██  █ ██  █    \
//  \___/ ██▄█▀   ██▄█▀  ▀█▄▄▄█▀▄██▄▀ ██▄█▀ studio ██▄█▀ ██▄█▀ ██▄█▀  __/
//  /   \___                                                     ___    \
//  \___/   \                                               \___/   \___/
//  /   \__                                                 /   \___/   \
//  \___/          Created by mefik on 04.02.15.              __/   \___/
//  /   \___/      Maxim Filippov aka mefik                     \  _/   \
//  \___/   \      https://plus.google.com/+MaximFilippov           \___/
//  /   \          http://mefik.ru                                  /   \
//  \___/                                                           \___/
//      \__                                                      ___/
//  \___/          Copyright (c) 2015 mefik-studio.           __/   \___/
//  /   \___/      All rights reserved.                         \   /   \
//  \___    \                                                       \___/
//  /                                                            ___/   \
//

#import <Foundation/Foundation.h>

#ifndef SCMLObject_h
#define SCMLObject_h

#if __has_feature(objc_arc)
#define ARC_ASSIGN strong
#define ARC_RETAIN strong
#else
#define ARC_ASSIGN assign
#define ARC_RETAIN retain
#endif

#define SCML_BONES_DRAW

typedef enum {
    LT_NO_LOOPING,
    LT_LOOPING
} SCMLLoopTypeEnum;

typedef enum {
    OT_SPRITE,
    OT_BONE,
    OT_BOX,
    OT_POINT,
    OT_SOUND,
    OT_ENTITY,
    OT_VARIABLE
} SCMLObjectTypeEnum;

typedef enum {
    CT_INSTANT,
    CT_LINEAR,
    CT_QUADRATIC,
    CT_CUBIC
} SCMLCurveTypeEnum;

@class SCMLSpatialInfo;
@class SCMLEntity;
@class SCMLAnimation;
@class SCMLMainlineKey;
@class SCMLSpatialTimelineKey;
@class SCMLRef;

//******************************************************************************
//      SCMLTextures
//******************************************************************************
@interface SCMLTextures : NSObject

@property (ARC_ASSIGN, nonatomic) NSMutableDictionary *textures;
@property (ARC_ASSIGN, nonatomic) NSMutableDictionary *xPixelSize;
@property (ARC_ASSIGN, nonatomic) NSMutableDictionary *yPixelSize;
@property (assign, nonatomic) unsigned char scaleFactor;
@property (copy, nonatomic) NSString *scalePrefix;

+ (SCMLTextures *) newScmlTextures;
- (void) dealloc;
- (GLuint) addTexture:(NSString *) filePath useScalePrefix: (BOOL) theUseScalePrefix;
- (void) removeTexture:(GLuint) theTextureId;
- (GLuint) textureByName:(NSString *) filePath;
- (GLfloat) getXPixelSize:(GLuint) theTextureId;
- (GLfloat) getYPixelSize:(GLuint) theTextureId;

@end

//******************************************************************************
//      SCMLObject
//******************************************************************************
@interface SCMLObject : NSObject

//List of SCMLFolder objects
@property (ARC_ASSIGN, nonatomic) NSMutableArray *folders;
//List of SCMLEntity objects
@property (ARC_ASSIGN, nonatomic) NSMutableArray *entities;
//List of SCMLFolder objects
@property (ARC_ASSIGN, nonatomic) NSMutableArray *activeCharacterMap;
@property (assign, nonatomic) SCMLTextures *textures;
@property (assign, nonatomic) SCMLEntity *currentEntity;
@property (assign, nonatomic) SCMLAnimation *currentAnimation;
@property (assign, nonatomic) NSTimeInterval currentTime;
@property (assign, nonatomic) GLfloat pixelSizeX;
@property (assign, nonatomic) GLfloat pixelSizeY;
@property (assign, nonatomic) GLfloat baseScale;
//List of SCMLSpriteTimelineKey objects
@property (ARC_ASSIGN, nonatomic) NSMutableArray *spritesToDraw;
#ifdef SCML_BONES_DRAW
//List of SCMLBoneTimelineKey objects
@property (ARC_ASSIGN, nonatomic) NSMutableArray *bonesToDraw;
#endif

+ (SCMLObject *) newScmlObject;
- (void) dealloc;
- (void) releaseMain;
- (void) openSCML:(NSString *) theSCMLFilePath textureAtlas:(NSString *) theTextureAtlasFilePath;
- (void) duplicateSCML:(SCMLObject *) theSCMLObject;
- (void) setCurrentTime:(NSTimeInterval) newTime;

@end

//******************************************************************************
//      SCMLFolder
//******************************************************************************
@interface SCMLFolder : NSObject

@property (ARC_RETAIN, nonatomic) NSString *name;
@property (assign, nonatomic) int folderId;
//List of SCMLFile objects
@property (ARC_ASSIGN, nonatomic) NSMutableArray *files;

+ (SCMLFolder *) newScmlFolder;
- (void) dealloc;

@end

//******************************************************************************
//      SCMLFile
//******************************************************************************
@interface SCMLFile : NSObject {
    GLfloat *coords;
    GLfloat *coordsFlipH;
}

@property (ARC_RETAIN, nonatomic) NSString *name;
@property (assign, nonatomic) int fileId;
@property (assign, nonatomic) float pivotX;
@property (assign, nonatomic) float pivotY;
@property (assign, nonatomic) int x;
@property (assign, nonatomic) int y;
@property (assign, nonatomic) int w;
@property (assign, nonatomic) int h;

@property (assign, nonatomic) GLint texture;
@property (readonly, nonatomic) GLuint va;
@property (readonly, nonatomic) GLuint vb;
@property (readonly, nonatomic) GLuint vah;
@property (readonly, nonatomic) GLuint vbh;

+ (SCMLFile *) newScmlFile;
- (void) dealloc;
- (void) generateTexCoords:(GLfloat) theX y:(GLfloat) theY w:(GLfloat) theW h:(GLfloat) theH rotated:(bool) isRotated;
- (void) generateVecCoords:(GLint) theW h:(GLint) theH pX:(GLfloat) thePixelX pY:(GLfloat) thePixelY;
- (void) generateVBO;

@end

#ifdef SCML_BONES_DRAW
//******************************************************************************
//      SCMLBone
//******************************************************************************
@interface SCMLBone : NSObject {
    GLfloat *coords;
}

@property (ARC_RETAIN, nonatomic) NSString *name;
@property (assign, nonatomic) float w;
@property (assign, nonatomic) float h;
@property (readonly, nonatomic) GLuint va;
@property (readonly, nonatomic) GLuint vb;

+ (SCMLBone *) newScmlBone;
- (void) dealloc;
- (void) generateVecCoords:(GLint) theW h:(GLint) theH pX:(GLfloat) thePixelX pY:(GLfloat) thePixelY;
- (void) generateVBO;

@end
#endif

//******************************************************************************
//      SCMLEntity
//******************************************************************************
@interface SCMLEntity : NSObject

#ifdef SCML_BONES_DRAW
//List of SCMLBone objects
@property (ARC_ASSIGN, nonatomic) NSMutableArray *bones;
#endif
@property (ARC_RETAIN, nonatomic) NSString *name;
@property (assign, nonatomic) int entityId;
//List of SCMLCharacterMap objects
@property (ARC_ASSIGN, nonatomic) NSMutableArray *characterMaps;
//List of SCMLAnimation objects
@property (ARC_ASSIGN, nonatomic) NSMutableArray *animations;

+ (SCMLEntity *) newScmlEntity;
- (void) dealloc;

@end

//******************************************************************************
//      SCMLCharacterMap
//******************************************************************************
@interface SCMLCharacterMap : NSObject

@property (ARC_RETAIN, nonatomic) NSString *name;
//List of SCMLMapInstruction objects
@property (ARC_ASSIGN, nonatomic) NSMutableArray *maps;

+ (SCMLCharacterMap *) newScmlCharacterMap;
- (void) dealloc;

@end

//******************************************************************************
//      SCMLMapInstruction
//******************************************************************************
@interface SCMLMapInstruction : NSObject

@property (assign, nonatomic) int folder;
@property (assign, nonatomic) int file;
@property (assign, nonatomic) int tarFolder;
@property (assign, nonatomic) int tarFile;

+ (SCMLMapInstruction *) newScmlMapInstruction;
- (void) dealloc;

@end

//******************************************************************************
//      SCMLAnimation
//******************************************************************************
@interface SCMLAnimation : NSObject {
    GLfloat *coords;
}

@property (ARC_RETAIN, nonatomic) NSString *name;
@property (assign, nonatomic) int length;
@property (assign, nonatomic) SCMLLoopTypeEnum loopType;
//List of SCMLMainlineKey objects
@property (ARC_ASSIGN, nonatomic) NSMutableArray *mainlineKeys;
//List of SCMLTimeline objects
@property (ARC_ASSIGN, nonatomic) NSMutableArray *timelines;

+ (SCMLAnimation *) newScmlAnimation;
- (void) dealloc;
- (SCMLMainlineKey *) mainlineKeyFromTime:(NSTimeInterval) theTime;
- (SCMLSpatialTimelineKey *) keyFromRef:(SCMLRef *) theRef time:(NSTimeInterval) newTime;

@end

//******************************************************************************
//      SCMLMainlineKey
//******************************************************************************
@interface SCMLMainlineKey : NSObject

@property (assign, nonatomic) NSTimeInterval time;
//List of SCMLRef objects
@property (ARC_ASSIGN, nonatomic) NSMutableArray *boneRefs;
//List of SCMLRef objects
@property (ARC_ASSIGN, nonatomic) NSMutableArray *objectRefs;

+ (SCMLMainlineKey *) newScmlMainlineKey;
- (void) dealloc;

@end

//******************************************************************************
//      SCMLRef
//******************************************************************************
@interface SCMLRef : NSObject

@property (assign, nonatomic) int parent;
@property (assign, nonatomic) int timeline;
@property (assign, nonatomic) int key;
@property (assign, nonatomic) int zIndex;

+ (SCMLRef *) newScmlRef;
- (void) dealloc;

@end

//******************************************************************************
//      SCMLTimeline
//******************************************************************************
@interface SCMLTimeline : NSObject

@property (ARC_RETAIN, nonatomic) NSString *name;
@property (assign, nonatomic) SCMLObjectTypeEnum objectType;
//List of SCMLTimelineKey objects
@property (ARC_ASSIGN, nonatomic) NSMutableArray *keys;

+ (SCMLTimeline *) newScmlTimeline;
- (void) dealloc;

@end

//******************************************************************************
//      SCMLTimelineKey
//******************************************************************************
@interface SCMLTimelineKey : NSObject

@property (assign, nonatomic) NSTimeInterval time;
@property (assign, nonatomic) SCMLCurveTypeEnum curveType;
@property (assign, nonatomic) float c1;
@property (assign, nonatomic) float c2;

+ (SCMLTimelineKey *) newScmlTimelineKey;
- (void) dealloc;
- (SCMLTimelineKey *) interpolate:(SCMLTimelineKey *) theNextKey nextKeyTime:(NSTimeInterval) theNextKeyTime currentTime:(NSTimeInterval) theCurrentTime;
- (float) getTimeRatioWithNextKey:(SCMLTimelineKey *) theNextKey nextKeyTime:(NSTimeInterval) theNextKeyTime currentTime:(NSTimeInterval) theCurrentTime;

@end

//******************************************************************************
//      SCMLSpatialTimelineKey
//******************************************************************************
@interface SCMLSpatialTimelineKey : SCMLTimelineKey

@property (ARC_ASSIGN, nonatomic) SCMLSpatialInfo *info;

+ (SCMLSpatialTimelineKey *) newScmlSpatialTimelineKey;
- (void) dealloc;

@end

//******************************************************************************
//      SCMLSpatialInfo
//******************************************************************************
@interface SCMLSpatialInfo : NSObject

@property (assign, nonatomic) float x;
@property (assign, nonatomic) float y;
@property (assign, nonatomic) float angle;
@property (assign, nonatomic) float scaleX;
@property (assign, nonatomic) float scaleY;
@property (assign, nonatomic) float a;
@property (assign, nonatomic) int spin;
@property (assign, nonatomic) int zIndex;

+ (SCMLSpatialInfo *) newScmlSpatialInfo;
- (void) dealloc;
- (SCMLSpatialInfo *) unmapFromParent:(SCMLSpatialInfo *) theParentInfo;
- (void) linear:(SCMLSpatialInfo *) theInfoB timeRatio:(float) theTimeRatio;

@end

//******************************************************************************
//      SCMLBoneTimelineKey
//******************************************************************************
@interface SCMLBoneTimelineKey : SCMLSpatialTimelineKey

#ifdef SCML_BONES_DRAW
@property (assign, nonatomic) SCMLBone *bone;
#endif
@property (assign, nonatomic) float length;
@property (assign, nonatomic) float width;

+ (SCMLBoneTimelineKey *) newScmlBoneTimelineKey;
- (void) dealloc;
- (SCMLBoneTimelineKey *) interpolate:(SCMLBoneTimelineKey *) theNextKey nextKeyTime:(NSTimeInterval) theNextKeyTime currentTime:(NSTimeInterval) theCurrentTime;
- (SCMLBoneTimelineKey *) linear:(SCMLBoneTimelineKey *) theKeyB timeRatio:(float) theTimeRatio;

@end

//******************************************************************************
//      SCMLSpriteTimelineKey
//******************************************************************************
@interface SCMLSpriteTimelineKey : SCMLSpatialTimelineKey

@property (assign, nonatomic) SCMLFile *file;
@property (assign, nonatomic) bool useDefaultPivot;
@property (assign, nonatomic) float pivotX;
@property (assign, nonatomic) float pivotY;

+ (SCMLSpriteTimelineKey *) newScmlSpriteTimelineKey;
- (void) dealloc;
- (SCMLSpriteTimelineKey *) interpolate:(SCMLSpriteTimelineKey *) theNextKey nextKeyTime:(NSTimeInterval) theNextKeyTime currentTime:(NSTimeInterval) theCurrentTime;
- (SCMLSpriteTimelineKey *) linear:(SCMLSpriteTimelineKey *) theKeyB timeRatio:(float) theTimeRatio;

@end

#endif
