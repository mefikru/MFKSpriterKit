//
//  SCMLObject.m
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

//#define LOG_SCML_LOADING

#if __has_feature(objc_arc)
#define SAFE_ARC_RELEASE(x)
#define SAFE_ARC_RETAIN(x) (x)
#define SAFE_ARC_SUPER_DEALLOC()
#else
#define SAFE_ARC_RELEASE(x) ([(x) release])
#define SAFE_ARC_RETAIN(x) ([(x) retain])
#define SAFE_ARC_SUPER_DEALLOC() ([super dealloc])
#endif

#import "SCMLObject.h"
#import "RXMLElement.h"
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/glext.h>

#define BUFFER_OFFSET(i) ((char *) NULL + (i))

static float linear(float a, float b, float t) {
    return ((b - a) * t) + a;
}

static float angleLinear(float angleA, float angleB, int spin, float t) {
    if (spin == 0) return angleA;
    if (spin > 0) {
        if ((angleB - angleA) < 0) angleB += 360;
    } else if (spin < 0) {
        if ((angleB - angleA) > 0) angleB -= 360;
    }
    return linear(angleA, angleB, t);
}

static float quadratic(float a, float b, float c, float t) {
    return linear(linear(a, b, t), linear(b, c, t), t);
}

static float cubic(float a, float b, float c, float d, float t) {
    return linear(quadratic(a, b, c, t), quadratic(b, c, d, t), t);
}

SCMLObjectTypeEnum getScmlObjectTypeEnumByString(NSString *theString) {
    SCMLObjectTypeEnum ot = OT_SPRITE;
    if (theString) {
        if ([theString compare:@"sprite"] == NSOrderedSame) ot = OT_SPRITE; else
        if ([theString compare:@"bone"] == NSOrderedSame) ot = OT_BONE; else
        if ([theString compare:@"box"] == NSOrderedSame) ot = OT_BOX; else
        if ([theString compare:@"point"] == NSOrderedSame) ot = OT_POINT; else
        if ([theString compare:@"sound"] == NSOrderedSame) ot = OT_SOUND; else
        if ([theString compare:@"entity"] == NSOrderedSame) ot = OT_ENTITY; else
        if ([theString compare:@"variable"] == NSOrderedSame) ot = OT_VARIABLE;
    }
    return ot;
}

SCMLCurveTypeEnum getScmlCurveTypeEnumByString(NSString *theString) {
    SCMLCurveTypeEnum ct = CT_LINEAR;
    if (theString) {
        if ([theString compare:@"linear"] == NSOrderedSame) ct = CT_LINEAR; else
        if ([theString compare:@"instant"] == NSOrderedSame) ct = CT_INSTANT; else
        if ([theString compare:@"quadratic"] == NSOrderedSame) ct = CT_QUADRATIC; else
        if ([theString compare:@"cubic"] == NSOrderedSame) ct = CT_CUBIC;
    }
    return ct;
}

//******************************************************************************
//      SCMLTextures
//******************************************************************************
@implementation SCMLTextures

@synthesize textures;
@synthesize xPixelSize;
@synthesize yPixelSize;
@synthesize scalePrefix;
@synthesize scaleFactor;

+ (SCMLTextures *) newScmlTextures {
    SCMLTextures *textures = [[SCMLTextures alloc] init];
    [textures setTextures:[[NSMutableDictionary alloc] init]];
    [textures setXPixelSize:[[NSMutableDictionary alloc] init]];
    [textures setYPixelSize:[[NSMutableDictionary alloc] init]];
    [textures setScalePrefix:nil];
    [textures setScaleFactor:1];
    return textures;
}

- (void) dealloc {
    for (NSString *file in textures) {
        GLuint texture = [[textures objectForKey:file] unsignedIntValue];
        glDeleteTextures(1, &texture);
    }
    SAFE_ARC_RELEASE(textures);
    SAFE_ARC_RELEASE(xPixelSize);
    SAFE_ARC_RELEASE(yPixelSize);
    SAFE_ARC_SUPER_DEALLOC();
}

- (void) loadTexture: (NSString *) theFileName : (GLuint) texture {
    CGImageRef textureImage = [UIImage imageWithContentsOfFile:theFileName].CGImage;
    if (textureImage == nil) {
        NSLog(@"Failed to load texture image");
        return;
    }
    NSInteger texWidth = CGImageGetWidth(textureImage);
    NSInteger texHeight = CGImageGetHeight(textureImage);
    [xPixelSize setObject:[NSNumber numberWithFloat:1.0f / texWidth] forKey:[NSNumber numberWithUnsignedInt:texture]];
    [yPixelSize setObject:[NSNumber numberWithFloat:1.0f / texHeight] forKey:[NSNumber numberWithUnsignedInt:texture]];

    GLubyte *textureData = (GLubyte *) calloc(texWidth * texHeight * 4, sizeof(GLubyte));
    CGContextRef textureContext = CGBitmapContextCreate(textureData, texWidth, texHeight, 8, texWidth * 4, CGImageGetColorSpace(textureImage), (CGBitmapInfo) kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(textureContext, CGRectMake(0.0, 0.0, (CGFloat)texWidth, (CGFloat)texHeight), textureImage);
    CGContextRelease(textureContext);
    glBindTexture(GL_TEXTURE_2D, texture);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, (GLsizei) texWidth, (GLsizei) texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
    free(textureData);
}

- (GLuint) addTexture:(NSString *) filePath useScalePrefix: (BOOL) theUseScalePrefix {
    NSNumber *num = [textures objectForKey:filePath];
    GLuint texture = 0;
    if (num == nil) {
#ifdef LOG_SCML_LOADING
        NSLog(@"    Atlas loaging new '%@'", filePath);
#endif
        glGenTextures(1, &texture);
        [textures setObject:[NSNumber numberWithUnsignedInt:texture] forKey:filePath];
        [self loadTexture:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%@", [filePath stringByDeletingPathExtension],
                                                                  !theUseScalePrefix || scalePrefix == nil ? @"" : scalePrefix] ofType:[filePath pathExtension]] :texture];
    } else {
        texture = [num unsignedIntValue];
#ifdef LOG_SCML_LOADING
        NSLog(@"    Atlas already loaded '%u'", texture);
#endif
    }
    return texture;
}

- (void) removeTexture:(GLuint) theTextureId {
    for (NSString *file in textures) {
        NSNumber *num = [textures objectForKey:file];
        GLuint texture = [num unsignedIntValue];
        if (texture == theTextureId) {
            [xPixelSize removeObjectForKey:num];
            [yPixelSize removeObjectForKey:num];
            [textures removeObjectForKey:file];
            glDeleteTextures(1, &texture);
            break;
        }
    }
}

- (GLuint) textureByName:(NSString *) filePath {
    NSNumber *num = [textures objectForKey:filePath];
    if (num != nil) return [num unsignedIntValue];
    return 0;
}

- (GLfloat) getXPixelSize:(GLuint) theTextureId {
    NSNumber *num = [xPixelSize objectForKey:[NSNumber numberWithUnsignedInt:theTextureId]];
    if (num == nil) return 0.0f;
    return [num floatValue] * scaleFactor;
}

- (GLfloat) getYPixelSize:(GLuint) theTextureId {
    NSNumber *num = [yPixelSize objectForKey:[NSNumber numberWithUnsignedInt:theTextureId]];
    if (num == nil) return 0.0f;
    return [num floatValue] * scaleFactor;
}

@end

//******************************************************************************
//      SCMLObject
//******************************************************************************
@implementation SCMLObject

@synthesize folders;
@synthesize entities;
@synthesize activeCharacterMap;
@synthesize textures;
@synthesize currentEntity;
@synthesize currentAnimation;
@synthesize currentTime;
@synthesize pixelSizeX;
@synthesize pixelSizeY;
@synthesize baseScale;
@synthesize spritesToDraw;
#ifdef SCML_BONES_DRAW
@synthesize bonesToDraw;
#endif

+ (SCMLObject *) newScmlObject {
    SCMLObject *scml = [[SCMLObject alloc] init];
    [scml setFolders:[[NSMutableArray alloc] init]];
    [scml setEntities:[[NSMutableArray alloc] init]];
    [scml setActiveCharacterMap:[[NSMutableArray alloc] init]];
    [scml setCurrentAnimation:nil];
    [scml setCurrentEntity:nil];
    [scml setCurrentTime:0];
    [scml setPixelSizeX:0.0f];
    [scml setPixelSizeY:0.0f];
    [scml setBaseScale:1.0f];
    [scml setSpritesToDraw:[[NSMutableArray alloc] init]];
#ifdef SCML_BONES_DRAW
    [scml setBonesToDraw:[[NSMutableArray alloc] init]];
#endif
    return scml;
}

- (void) dealloc {
    for (SCMLSpatialTimelineKey *key in spritesToDraw) if (key) SAFE_ARC_RELEASE(key);
    SAFE_ARC_RELEASE(spritesToDraw);
#ifdef SCML_BONES_DRAW
    for (SCMLSpatialTimelineKey *key in bonesToDraw) if (key) SAFE_ARC_RELEASE(key);
    SAFE_ARC_RELEASE(bonesToDraw);
#endif
    SAFE_ARC_RELEASE(folders);
    SAFE_ARC_RELEASE(entities);
    SAFE_ARC_RELEASE(activeCharacterMap);
    SAFE_ARC_SUPER_DEALLOC();
}

- (void) releaseMain {
    for (SCMLFolder *folder in folders) if (folder) SAFE_ARC_RELEASE(folder);
    [folders removeAllObjects];
    for (SCMLEntity *entity in entities) if (entity) SAFE_ARC_RELEASE(entity);
    [entities removeAllObjects];
    for (SCMLFolder *folder in activeCharacterMap) if (folder) SAFE_ARC_RELEASE(folder);
    [activeCharacterMap removeAllObjects];
}

- (void) setCurrentTime:(NSTimeInterval) newTime {
    if (!currentAnimation) return;
    
    switch ([currentAnimation loopType]) {
        case LT_NO_LOOPING:
            newTime =  fmin(newTime, [currentAnimation length]);
            break;

        case LT_LOOPING:
        default:
            newTime = fmod(newTime, [currentAnimation length]);
            break;
    }
    [self updateCharacter:[currentAnimation mainlineKeyFromTime:newTime] time:newTime];
}

- (void) updateCharacter:(SCMLMainlineKey *) theMainKey time:(NSTimeInterval) newTime {
#ifdef SCML_BONES_DRAW
    for (SCMLSpatialTimelineKey *key in bonesToDraw) if (key) SAFE_ARC_RELEASE(key);
    [bonesToDraw removeAllObjects];
#endif

    NSMutableArray *transformBoneKeys = [[NSMutableArray alloc] init];
    for (SCMLRef *ref in [theMainKey boneRefs]) {
        SCMLSpatialTimelineKey *currentKey = [currentAnimation keyFromRef:ref time:newTime];
        if ([ref parent] >= 0) {
            SCMLSpatialInfo *newInfo = [[currentKey info] unmapFromParent:[transformBoneKeys objectAtIndex:[ref parent]]];
            SAFE_ARC_RELEASE([currentKey info]);
            [currentKey setInfo:nil];
            [currentKey setInfo:newInfo];
        }
        [transformBoneKeys addObject:[currentKey info]];
#ifdef SCML_BONES_DRAW
        [bonesToDraw addObject:currentKey];
#endif
    }

    for (SCMLSpatialTimelineKey *key in spritesToDraw) if (key) SAFE_ARC_RELEASE(key);
    [spritesToDraw removeAllObjects];

    bool zIndexUse = false;

    for (SCMLRef *ref in [theMainKey objectRefs]) {
        SCMLSpatialTimelineKey *currentKey = [currentAnimation keyFromRef:ref time:newTime];
        if ([ref parent] >= 0) {
            SCMLSpatialInfo *newInfo = [[currentKey info] unmapFromParent:[transformBoneKeys objectAtIndex:[ref parent]]];
            SAFE_ARC_RELEASE([currentKey info]);
            [currentKey setInfo:nil];
            [currentKey setInfo:newInfo];
        }
        [[currentKey info] setZIndex:[ref zIndex]];
        if ([ref zIndex] > 0) zIndexUse = true;
        [spritesToDraw addObject:currentKey];
    }
    SAFE_ARC_RELEASE(transformBoneKeys);

    if (zIndexUse) {
        [spritesToDraw sortUsingComparator:
         ^NSComparisonResult(id obj1, id obj2) {
             SCMLSpatialTimelineKey *key1 = (SCMLSpatialTimelineKey *) obj1;
             SCMLSpatialTimelineKey *key2 = (SCMLSpatialTimelineKey *) obj2;
             if ([[key1 info] zIndex] > [[key2 info] zIndex]) return (NSComparisonResult)NSOrderedDescending;
             if ([[key1 info] zIndex] < [[key2 info] zIndex]) return (NSComparisonResult)NSOrderedAscending;
             return (NSComparisonResult)NSOrderedSame;
         }];
    }
}

- (void) applyCharacterMap:(SCMLCharacterMap *) theCharacterMap reset:(bool) theReset {
    if (theReset) {
        for (SCMLFolder *folder in activeCharacterMap) if (folder) SAFE_ARC_RELEASE(folder);
        [activeCharacterMap removeAllObjects];
        SAFE_ARC_RELEASE(activeCharacterMap);
        activeCharacterMap = folders;
    }
    for (SCMLMapInstruction *mapInstruction in [theCharacterMap maps]) {
        if ([mapInstruction tarFolder] > -1 && [mapInstruction tarFile] > -1) {
//            SCMLFolder *folder = [activeCharacterMap objectAtIndex:[mapInstruction tarFolder]];
//            SCMLFile *file = [[folder files] objectAtIndex:[mapInstruction tarFile]];
            //!!!!!!!!!!
//            activeCharacterMap[folder].files[file]=targetFile;
        }
    }
}

- (void) duplicateSCML:(SCMLObject *) theSCMLObject {
    textures = [theSCMLObject textures];
    currentEntity = nil;
    currentAnimation = nil;
    pixelSizeX = [theSCMLObject pixelSizeX];
    pixelSizeY = [theSCMLObject pixelSizeY];
    baseScale = [theSCMLObject baseScale];
    [self releaseMain];
    SAFE_ARC_RELEASE(folders);
    SAFE_ARC_RELEASE(entities);
    SAFE_ARC_RELEASE(activeCharacterMap);
    folders = SAFE_ARC_RETAIN([theSCMLObject folders]);
    activeCharacterMap = SAFE_ARC_RETAIN([theSCMLObject activeCharacterMap]);
    entities = SAFE_ARC_RETAIN([theSCMLObject entities]);
}

- (void) openSCML:(NSString *) theSCMLFilePath textureAtlas:(NSString *) theTextureAtlasFilePath {
    [self releaseMain];

    NSData *xml = [[NSData alloc] initWithContentsOfFile:theSCMLFilePath];
    NSData *xml2 = [[NSData alloc] initWithContentsOfFile:theTextureAtlasFilePath];
#if !__has_feature(objc_arc)
    @autoreleasepool {
#endif
        RXMLElement *doc = [RXMLElement elementFromXMLData:xml];
        RXMLElement *doc2 = [RXMLElement elementFromXMLData:xml2];
        NSArray *atlasNodes = [doc2 childrenWithRootXPath:@"/TextureAtlas"];
        NSArray *spriterDataNodes = [doc childrenWithRootXPath:@"/spriter_data"];
        for (RXMLElement *spriterDataElement in spriterDataNodes) {
            NSString *scmlVersion = [spriterDataElement attributeCstr:"scml_version"];
            if ([scmlVersion compare:@"1.0"] == NSOrderedSame) {
                NSArray *folderNodes = [spriterDataElement children:@"folder"];
                for (RXMLElement *folderElement in folderNodes) {
                    NSString *folderId = [folderElement attributeCstr:"id"];
                    NSString *folderName = [folderElement attributeCstr:"name"];
#ifdef LOG_SCML_LOADING
                    NSLog(@"Folder '%@'", folderName);
#endif
                    SCMLFolder *folder = [SCMLFolder newScmlFolder];
                    [folders addObject:folder];
                    [folder setName:folderName];
                    [folder setFolderId:[folderId intValue]];
                    NSArray *fileNodes = [folderElement children:@"file"];
                    for (RXMLElement *fileElement in fileNodes) {
                        NSString *fileId = [fileElement attributeCstr:"id"];
                        NSString *fileName = [fileElement attributeCstr:"name"];
                        NSString *pivotX = [fileElement attributeCstr:"pivot_x"];
                        NSString *pivotY = [fileElement attributeCstr:"pivot_y"];
#ifdef LOG_SCML_LOADING
                        NSLog(@"File   '%@'", fileName);
                        bool spriteFound = false;
#endif
                        SCMLFile *file = [SCMLFile newScmlFile];
                        [[folder files] addObject:file];
                        [file setName:fileName];
                        [file setFileId:[fileId intValue]];
                        if ([pivotX compare:@""] != NSOrderedSame) [file setPivotX:[pivotX floatValue]];
                        if ([pivotY compare:@""] != NSOrderedSame) [file setPivotY:1.0f - [pivotY floatValue]];
                        //Find sprite in texture atlas
                        for (RXMLElement *atlasElement in atlasNodes) {
                            NSString *atlasFileName = [atlasElement attributeCstr:"imagePath"];
                            NSString *atlasWidth = [atlasElement attributeCstr:"width"];
                            NSString *atlasHeight = [atlasElement attributeCstr:"height"];
                            long atlasW = (long) [atlasWidth longLongValue];
                            long atlasH = (long) [atlasHeight longLongValue];
                            GLfloat pixelX = 1.0f / atlasW;
                            GLfloat pixelY = 1.0f / atlasH;
                            if (!atlasFileName || [atlasFileName compare:@""] == NSOrderedSame) continue;
                            NSArray *spriteNodes = [doc2 childrenWithRootXPath:[NSString stringWithFormat:@"/TextureAtlas[@imagePath='%@']/sprite[@n='%@']", atlasFileName, fileName]];
                            for (RXMLElement *spriteElement in spriteNodes) {
                                NSString *spriteX = [spriteElement attributeCstr:"x"];
                                NSString *spriteY = [spriteElement attributeCstr:"y"];
                                NSString *spriteW = [spriteElement attributeCstr:"w"];
                                NSString *spriteH = [spriteElement attributeCstr:"h"];
                                NSString *spriteR = [spriteElement attributeCstr:"r"];
                                bool spriteRotated = false;
                                if (spriteR) spriteRotated = [spriteR compare:@"y"] == NSOrderedSame;
                                [file setX:[spriteX intValue]];
                                [file setY:[spriteY intValue]];
                                [file setW:[spriteW intValue]];
                                [file setH:[spriteH intValue]];
                                [file generateTexCoords:[spriteX floatValue] * pixelX
                                                      y:[spriteY floatValue] * pixelY
                                                      w:([spriteX floatValue] + [spriteW floatValue]) * pixelX
                                                      h:([spriteY floatValue] + [spriteH floatValue]) * pixelY
                                                rotated:spriteRotated];
                                if (spriteRotated) {
                                    [file setW:[spriteH intValue]];
                                    [file setH:[spriteW intValue]];
                                }
                                [file generateVecCoords:[file w] h:[file h] pX:pixelSizeX pY:pixelSizeY];
                                [file generateVBO];
                                [file setTexture:[textures addTexture:atlasFileName useScalePrefix:NO]];
#ifdef LOG_SCML_LOADING
                                NSLog(@"   Atlas x=%@, y=%@, w=%@, h=%@, r=%@", spriteX, spriteY, spriteW, spriteH, spriteRotated ? @"yes" : @"no");
                                spriteFound = true;
#endif
                            }
                        }
                        SAFE_ARC_RELEASE(file);
#ifdef LOG_SCML_LOADING
                        if (!spriteFound) NSLog(@"   Atlas not found");
#endif
                    }
                }
            }
        }

        NSArray *entityNodes = [doc childrenWithRootXPath:@"/spriter_data/entity"];
        for (RXMLElement *entityElement in entityNodes) {
            NSString *entityId = [entityElement attributeCstr:"id"];
            NSString *entityName = [entityElement attributeCstr:"name"];
            SCMLEntity *entity = [SCMLEntity newScmlEntity];
            [entity setName:entityName];
            [entity setEntityId:[entityId intValue]];
#ifdef LOG_SCML_LOADING
            NSLog(@"Entity '%@'", entityName);
#endif
            [entities addObject:entity];

#ifdef SCML_BONES_DRAW
            NSArray *boneNodes = [entityElement children:@"obj_info"];
            for (RXMLElement *boneElement in boneNodes) {
                NSString *type = [boneElement attributeCstr:"type"];
                if (!type || [type compare:@"bone"] != NSOrderedSame) continue;
                NSString *boneName = [boneElement attributeCstr:"realname"];
                if ([boneName compare:@""] == NSOrderedSame) boneName = [boneElement attributeCstr:"name"];
                [boneElement attributeCstr:"name"];
                NSString *boneW = [boneElement attributeCstr:"w"];
                NSString *boneH = [boneElement attributeCstr:"h"];
                SCMLBone *bone = [SCMLBone newScmlBone];
                [[entity bones] addObject:bone];
                [bone setName:boneName];
                [bone setW:[boneW floatValue] * baseScale];
                [bone setH:[boneH floatValue] * baseScale];
                [bone generateVecCoords:[bone w] h:[bone h] pX:pixelSizeX pY:pixelSizeY];
                [bone generateVBO];
            }
#endif

            NSArray *characterMapNodes = [entityElement children:@"character_map"];
            for (RXMLElement *characterMapElement in characterMapNodes) {
                NSString *characterMapName = [characterMapElement attributeCstr:"name"];
#ifdef LOG_SCML_LOADING
                NSString *characterMapId = [characterMapElement attributeCstr:"id"];
                NSLog(@"    CharacterMap '%@, %@'", characterMapId, characterMapName);
#endif
                SCMLCharacterMap *characterMap = [SCMLCharacterMap newScmlCharacterMap];
                [[entity characterMaps] addObject:characterMap];
                [characterMap setName:characterMapName];
                NSArray *mapInstructionNodes = [characterMapElement children:@"map"];
                for (RXMLElement *mapInstructionElement in mapInstructionNodes) {
                    NSString *folder = [mapInstructionElement attributeCstr:"folder"];
                    NSString *file = [mapInstructionElement attributeCstr:"file"];
                    NSString *targetFolder = [mapInstructionElement attributeCstr:"target_folder"];
                    NSString *targetFile = [mapInstructionElement attributeCstr:"target_file"];
#ifdef LOG_SCML_LOADING
                    NSLog(@"        Map (folder='%@', file='%@', tarFolder='%@', tarFile='%@')", folder, file, targetFolder, targetFile);
#endif
                    SCMLMapInstruction *mapInstruction = [SCMLMapInstruction newScmlMapInstruction];
                    [[characterMap maps] addObject:mapInstruction];
                    if ([folder compare:@""] != NSOrderedSame) [mapInstruction setFolder:[folder intValue]];
                    if ([file compare:@""] != NSOrderedSame) [mapInstruction setFile:[file intValue]];
                    if ([targetFolder compare:@""] != NSOrderedSame) [mapInstruction setTarFolder:[targetFolder intValue]];
                    if ([targetFile compare:@""] != NSOrderedSame) [mapInstruction setTarFile:[targetFile intValue]];
                }
            }

            NSArray *animationNodes = [entityElement children:@"animation"];
            for (RXMLElement *animationElement in animationNodes) {
                NSString *animationName = [animationElement attributeCstr:"name"];
                NSString *animationLength = [animationElement attributeCstr:"length"];
                NSString *animationLooping = [animationElement attributeCstr:"looping"];
#ifdef LOG_SCML_LOADING
                NSString *animationId = [animationElement attributeCstr:"id"];
                NSLog(@"    Animation '%@, %@' (length='%@', looping='%@')", animationId, animationName, animationLength, animationLooping);
#endif
                SCMLAnimation *animation = [SCMLAnimation newScmlAnimation];
                [[entity animations] addObject:animation];
                if (animationLength && [animationLength compare:@""] != NSOrderedSame) [animation setLength:[animationLength intValue]];
                [animation setName:animationName];
                if (!animationLooping || [animationLooping compare:@"true"] == NSOrderedSame)
                    [animation setLoopType:LT_LOOPING];
                else if ([animationLooping compare:@"false"] == NSOrderedSame)
                    [animation setLoopType:LT_NO_LOOPING];
                NSArray *keyNodes = [[animationElement child:@"mainline"] children:@"key"];
                for (RXMLElement *keyElement in keyNodes) {
                    NSString *keyTime = [keyElement attributeCstr:"time"];
#ifdef LOG_SCML_LOADING
                    NSString *keyId = [keyElement attributeCstr:"id"];
                    NSLog(@"        MainlineKey '%@' (time='%@')", keyId, keyTime);
#endif
                    SCMLMainlineKey *mainlineKey = [SCMLMainlineKey newScmlMainlineKey];
                    [[animation mainlineKeys] addObject:mainlineKey];
                    if (keyTime && [keyTime compare:@""] != NSOrderedSame) [mainlineKey setTime:[keyTime intValue]];
                    NSArray *boneRefNodes = [keyElement children:@"bone_ref"];
                    int zIndex = 0;
                    for (RXMLElement *boneRefElement in boneRefNodes) {
#ifdef LOG_SCML_LOADING
                        NSString *boneRefId = [boneRefElement attributeCstr:"id"];
#endif
                        NSString *boneRefParent = [boneRefElement attributeCstr:"parent"];
                        NSString *boneRefTimeline = [boneRefElement attributeCstr:"timeline"];
                        NSString *boneRefKey = [boneRefElement attributeCstr:"key"];
#ifdef LOG_SCML_LOADING
                        NSLog(@"            BoneRef '%@' (parent='%@', timeline='%@', key='%@')", boneRefId, boneRefParent, boneRefTimeline, boneRefKey);
#endif
                        SCMLRef *boneRef = [SCMLRef newScmlRef];
                        [[mainlineKey boneRefs] addObject:boneRef];
                        if (boneRefParent && [boneRefParent compare:@""] != NSOrderedSame) [boneRef setParent:[boneRefParent intValue]];
                        if (boneRefTimeline && [boneRefTimeline compare:@""] != NSOrderedSame) [boneRef setTimeline:[boneRefTimeline intValue]];
                        if (boneRefKey && [boneRefKey compare:@""] != NSOrderedSame) [boneRef setKey:[boneRefKey intValue]];
                        [boneRef setZIndex: zIndex++];
                    }

                    NSArray *objRefNodes = [keyElement children:@"object_ref"];
                    for (RXMLElement *objRefElement in objRefNodes) {
#ifdef LOG_SCML_LOADING
                        NSString *objRefId = [objRefElement attributeCstr:"id"];
#endif
                        NSString *objRefParent = [objRefElement attributeCstr:"parent"];
                        NSString *objRefTimeline = [objRefElement attributeCstr:"timeline"];
                        NSString *objRefKey = [objRefElement attributeCstr:"key"];
                        NSString *objRefZIndex = [objRefElement attributeCstr:"z_index"];
#ifdef LOG_SCML_LOADING
                        NSLog(@"            ObjectRef '%@' (parent='%@', timeline='%@', key='%@')", objRefId, objRefParent, objRefTimeline, objRefKey);
#endif
                        SCMLRef *objRef = [SCMLRef newScmlRef];
                        [[mainlineKey objectRefs] addObject:objRef];
                        if (objRefParent && [objRefParent compare:@""] != NSOrderedSame) [objRef setParent:[objRefParent intValue]];
                        if (objRefTimeline && [objRefTimeline compare:@""] != NSOrderedSame) [objRef setTimeline:[objRefTimeline intValue]];
                        if (objRefKey && [objRefKey compare:@""] != NSOrderedSame) [objRef setKey:[objRefKey intValue]];
                        if (objRefZIndex && [objRefZIndex compare:@""] != NSOrderedSame) [objRef setZIndex:[objRefZIndex intValue]];
                    }
                }

                NSArray *timelineNodes = [animationElement children:@"timeline"];
                for (RXMLElement *timelineElement in timelineNodes) {
                    NSString *timelineName = [timelineElement attributeCstr:"name"];
                    NSString *timelineType = [timelineElement attributeCstr:"type"];
#ifdef LOG_SCML_LOADING
                    NSString *timelineId = [timelineElement attributeCstr:"id"];
                    NSLog(@"        Timeline '%@, %@' (type='%@')", timelineId, timelineName, timelineType);
#endif
                    SCMLTimeline *timeline = [SCMLTimeline newScmlTimeline];
                    [[animation timelines] addObject:timeline];
                    [timeline setName:timelineName];
                    [timeline setObjectType:getScmlObjectTypeEnumByString(timelineType)];
                    NSArray *keyNodes = [timelineElement children:@"key"];
                    for (RXMLElement *keyElement in keyNodes) {
                        NSString *keyTime = [keyElement attributeCstr:"time"];
                        NSString *keySpin = [keyElement attributeCstr:"spin"];
                        NSString *keyCurveType = [keyElement attributeCstr:"curve_type"];
                        NSString *keyC1 = [keyElement attributeCstr:"c1"];
                        NSString *keyC2 = [keyElement attributeCstr:"c2"];
#ifdef LOG_SCML_LOADING
                        NSString *keyId = [keyElement attributeCstr:"id"];
                        NSLog(@"            Key '%@' (time='%@', spin='%@', curve_type='%@', c1='%@', c2='%@')", keyId, keyTime, keySpin, keyCurveType, keyC1, keyC2);
#endif
                        NSArray *boneNodes = [keyElement children:@"bone"];
#ifdef SCML_BONES_DRAW
                        SCMLBone *boneLink = nil;
                        if ([boneNodes count] > 0) {
                            for (SCMLBone *bone in [entity bones]) {
                                if ([[bone name] compare:[timeline name]] == NSOrderedSame) {
                                    boneLink = bone;
                                    break;
                                }
                            }
                        }
#endif
                        for (RXMLElement *boneElement in boneNodes) {
                            NSString *boneX = [boneElement attributeCstr:"x"];
                            NSString *boneY = [boneElement attributeCstr:"y"];
                            NSString *boneAngle = [boneElement attributeCstr:"angle"];
                            NSString *boneScaleX = [boneElement attributeCstr:"scale_x"];
                            NSString *boneScaleY = [boneElement attributeCstr:"scale_y"];
                            NSString *boneA = [boneElement attributeCstr:"a"];
#ifdef LOG_SCML_LOADING
                            NSLog(@"                Bone '(x='%@', y='%@', angle='%@', scale_x='%@', scale_y='%@', a='%@')", boneX, boneY, boneAngle, boneScaleX, boneScaleY, boneA);
#endif
                            SCMLBoneTimelineKey *boneTimelineKey = [SCMLBoneTimelineKey newScmlBoneTimelineKey];
                            [[timeline keys] addObject:boneTimelineKey];
                            if (keyTime && [keyTime compare:@""] != NSOrderedSame) [boneTimelineKey setTime:[keyTime intValue]];
                            if (keyCurveType && [keyCurveType compare:@""] != NSOrderedSame) [boneTimelineKey setCurveType:getScmlCurveTypeEnumByString(keyCurveType)];;
                            if (keyC1 && [keyC1 compare:@""] != NSOrderedSame) [boneTimelineKey setC1:[keyC1 floatValue]];
                            if (keyC2 && [keyC2 compare:@""] != NSOrderedSame) [boneTimelineKey setC2:[keyC2 floatValue]];
#ifdef SCML_BONES_DRAW
                            [boneTimelineKey setBone:boneLink];
                            if (boneLink) {
                                [boneTimelineKey setWidth:[boneLink h]];
                                [boneTimelineKey setLength:[boneLink w]];
                            }
#endif
                            if (boneX && [boneX compare:@""] != NSOrderedSame) [[boneTimelineKey info] setX:[boneX floatValue]];
                            if (boneY && [boneY compare:@""] != NSOrderedSame) [[boneTimelineKey info] setY:-[boneY floatValue]];
                            if (boneAngle && [boneAngle compare:@""] != NSOrderedSame) [[boneTimelineKey info] setAngle:[boneAngle floatValue]];
                            if (boneScaleX && [boneScaleX compare:@""] != NSOrderedSame) [[boneTimelineKey info] setScaleX:[boneScaleX floatValue]];
                            if (boneScaleY && [boneScaleY compare:@""] != NSOrderedSame) [[boneTimelineKey info] setScaleY:[boneScaleY floatValue]];
                            if (boneA && [boneA compare:@""] != NSOrderedSame) [[boneTimelineKey info] setA:[boneA floatValue]];
                            if (keySpin && [keySpin compare:@""] != NSOrderedSame) [[boneTimelineKey info] setSpin:[keySpin intValue]];
                        }

                        NSArray *objNodes = [keyElement children:@"object"];
                        for (RXMLElement *objElement in objNodes) {
                            NSString *objFolder = [objElement attributeCstr:"folder"];
                            NSString *objFile = [objElement attributeCstr:"file"];
                            NSString *objX = [objElement attributeCstr:"x"];
                            NSString *objY = [objElement attributeCstr:"y"];
                            NSString *objAngle = [objElement attributeCstr:"angle"];
                            NSString *objScaleX = [objElement attributeCstr:"scale_x"];
                            NSString *objScaleY = [objElement attributeCstr:"scale_y"];
                            NSString *objPivotX = [objElement attributeCstr:"pivot_x"];
                            NSString *objPivotY = [objElement attributeCstr:"pivot_y"];
                            NSString *objA = [objElement attributeCstr:"a"];
#ifdef LOG_SCML_LOADING
                            NSLog(@"                Object '(folder='%@', file='%@', x='%@', y='%@', angle='%@', scale_x='%@', scale_y='%@', pivot_x='%@', pivot_y='%@', a='%@')", objFolder, objFile, objX, objY, objAngle, objScaleX, objScaleY, objPivotX, objPivotY, objA);
#endif
                            SCMLSpriteTimelineKey *objTimelineKey = [SCMLSpriteTimelineKey newScmlSpriteTimelineKey];
                            [[timeline keys] addObject:objTimelineKey];
                            if (keyTime && [keyTime compare:@""] != NSOrderedSame) [objTimelineKey setTime:[keyTime intValue]];
                            if (keyCurveType && [keyCurveType compare:@""] != NSOrderedSame) [objTimelineKey setCurveType:getScmlCurveTypeEnumByString(keyCurveType)];
                            if (keyC1 && [keyC1 compare:@""] != NSOrderedSame) [objTimelineKey setC1:[keyC1 floatValue]];
                            if (keyC2 && [keyC2 compare:@""] != NSOrderedSame) [objTimelineKey setC2:[keyC2 floatValue]];
                            if (objFile && [objFile compare:@""] != NSOrderedSame && objFolder && [objFolder compare:@""] != NSOrderedSame) {
                                int objFolderId = [objFolder intValue];
                                int objFileId = [objFile intValue];
                                SCMLFile *fileRef = nil;
                                for (SCMLFolder *folder in folders) {
                                    if ([folder folderId] == objFolderId) {
                                        for (SCMLFile *file in [folder files]) {
                                            if ([file fileId] ==  objFileId) {
                                                fileRef = file;
                                                break;
                                            }
                                        }
                                    }
                                    if (fileRef) break;
                                }
                                [objTimelineKey setFile:fileRef];
#ifdef LOG_SCML_LOADING
                                NSLog(@"                File '(file='%@')", [fileRef name]);
#endif
                            }
                            if (objPivotX && [objPivotX compare:@""] != NSOrderedSame) [objTimelineKey setPivotX:[objPivotX floatValue]];
                            else if ([objTimelineKey file])
                                [objTimelineKey setPivotX:[[objTimelineKey file] pivotX]];
                            if (objPivotY && [objPivotY compare:@""] != NSOrderedSame) [objTimelineKey setPivotY:1.0f - [objPivotY floatValue]];
                            else if ([objTimelineKey file])
                                [objTimelineKey setPivotY:[[objTimelineKey file] pivotY]];
                            if (objX && [objX compare:@""] != NSOrderedSame) [[objTimelineKey info] setX:[objX floatValue]];
                            if (objY && [objY compare:@""] != NSOrderedSame) [[objTimelineKey info] setY:-[objY floatValue]];
                            if (objAngle && [objAngle compare:@""] != NSOrderedSame) [[objTimelineKey info] setAngle:[objAngle floatValue]];
                            if (objScaleX && [objScaleX compare:@""] != NSOrderedSame) [[objTimelineKey info] setScaleX:[objScaleX floatValue]];
                            if (objScaleY && [objScaleY compare:@""] != NSOrderedSame) [[objTimelineKey info] setScaleY:[objScaleY floatValue]];
                            if (objA && [objA compare:@""] != NSOrderedSame) [[objTimelineKey info] setA:[objA floatValue]];
                            if (keySpin && [keySpin compare:@""] != NSOrderedSame) [[objTimelineKey info] setSpin:[keySpin intValue]];
                        }
                    }
                }
            }
        }
#if !__has_feature(objc_arc)
    }
#endif
    SAFE_ARC_RELEASE(xml2);
    SAFE_ARC_RELEASE(xml);
}

@end

//******************************************************************************
//      SCMLFolder
//******************************************************************************
@implementation SCMLFolder

@synthesize name;
@synthesize files;

+ (SCMLFolder *) newScmlFolder {
    SCMLFolder *folder = [[SCMLFolder alloc] init];
    [folder setName:nil];
    [folder setFiles:[[NSMutableArray alloc] init]];
    return folder;
}

- (void) dealloc {
    if (name) SAFE_ARC_RELEASE(name);
    SAFE_ARC_RELEASE(files);
    SAFE_ARC_SUPER_DEALLOC();
}

@end

//******************************************************************************
//      SCMLFile
//******************************************************************************
@implementation SCMLFile

@synthesize name;
@synthesize pivotX;
@synthesize pivotY;

@synthesize texture;
@synthesize va;
@synthesize vb;
@synthesize vah;
@synthesize vbh;

+ (SCMLFile *) newScmlFile {
    SCMLFile *file = [[SCMLFile alloc] init];
    [file setName:nil];
    [file setPivotX:0.0f];
    [file setPivotY:1.0f];
    file->va = 0;
    file->vb = 0;
    file->vah = 0;
    file->vbh = 0;
    file->coords = malloc(sizeof(GLfloat) * 24);
    file->coordsFlipH = malloc(sizeof(GLfloat) * 24);
    return file;
}

- (void) dealloc {
    if (name) SAFE_ARC_RELEASE(name);
    if (coords) free(coords);
    if (coordsFlipH) free(coordsFlipH);
    glDeleteBuffers(1, &vb);
    glDeleteVertexArraysOES(1, &va);
    glDeleteBuffers(1, &vbh);
    glDeleteVertexArraysOES(1, &vah);
    SAFE_ARC_SUPER_DEALLOC();
}

- (void) generateTexCoords:(GLfloat) theX y:(GLfloat) theY w:(GLfloat) theW h:(GLfloat) theH rotated:(bool) isRotated {
    coords[2] = theX;
    coords[3] = isRotated ? theY : theH;
    coords[6] = isRotated ? theW : coords[2];
    coords[7] = isRotated ? coords[3] : theY;
    coords[10] = isRotated ? coords[6] : theW;
    coords[11] = isRotated ? theH : coords[7];
    coords[14] = coords[2];
    coords[15] = coords[3];
    coords[18] = coords[10];
    coords[19] = coords[11];
    coords[22] = isRotated ? coords[2] : coords[10];
    coords[23] = isRotated ? coords[11] : coords[3];
}

- (void) generateVecCoords:(GLint) theW h:(GLint) theH pX:(GLfloat) thePixelX pY:(GLfloat) thePixelY {
    coords[0] = 0.0f;
    coords[1] = thePixelY * theH;
    coords[4] = coords[0];
    coords[5] = 0.0f;
    coords[8] = thePixelX * theW;
    coords[9] = coords[5];
    coords[12] = coords[0];
    coords[13] = coords[1];
    coords[16] = coords[8];
    coords[17] = coords[5];
    coords[20] = coords[8];
    coords[21] = coords[1];
}

- (void) generateVBO {
    memcpy(coordsFlipH, coords, sizeof(GLfloat) * 24);
    coordsFlipH[0] = coords[8];
    coordsFlipH[1] = coords[1];
    coordsFlipH[4] = coordsFlipH[0];
    coordsFlipH[5] = 0.0f;
    coordsFlipH[8] = 0.0f;
    coordsFlipH[9] = 0.0f;
    coordsFlipH[12] = coordsFlipH[0];
    coordsFlipH[13] = coordsFlipH[1];
    coordsFlipH[16] = coordsFlipH[8];
    coordsFlipH[17] = coordsFlipH[9];
    coordsFlipH[20] = coordsFlipH[8];
    coordsFlipH[21] = coordsFlipH[1];

    glGenVertexArraysOES(1, &va);
    glBindVertexArrayOES(va);
    glGenBuffers(1, &vb);
    glBindBuffer(GL_ARRAY_BUFFER, vb);
    glBufferData(GL_ARRAY_BUFFER, 24 * sizeof(GLfloat), coords, GL_STATIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 4, BUFFER_OFFSET(0));
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 4, BUFFER_OFFSET(sizeof(GLfloat) * 2));
    glBindVertexArrayOES(0);

    glGenVertexArraysOES(1, &vah);
    glBindVertexArrayOES(vah);
    glGenBuffers(1, &vbh);
    glBindBuffer(GL_ARRAY_BUFFER, vbh);
    glBufferData(GL_ARRAY_BUFFER, 24 * sizeof(GLfloat), coordsFlipH, GL_STATIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 4, BUFFER_OFFSET(0));
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 4, BUFFER_OFFSET(sizeof(GLfloat) * 2));
    glBindVertexArrayOES(0);

    free(coords);
    coords = NULL;
    free(coordsFlipH);
    coordsFlipH = NULL;
}

@end

#ifdef SCML_BONES_DRAW
//******************************************************************************
//      SCMLBone
//******************************************************************************
@implementation SCMLBone

@synthesize name;
@synthesize va;
@synthesize vb;

+ (SCMLBone *) newScmlBone {
    SCMLBone *bone = [[SCMLBone alloc] init];
    [bone setName:nil];
    bone->va = 0;
    bone->vb = 0;
    bone->coords = malloc(sizeof(GLfloat) * 24);
    return bone;
}

- (void) dealloc {
    if (name) SAFE_ARC_RELEASE(name);
    if (coords) free(coords);
    glDeleteBuffers(1, &vb);
    glDeleteVertexArraysOES(1, &va);
    SAFE_ARC_SUPER_DEALLOC();
}

- (void) generateVecCoords:(GLint) theW h:(GLint) theH pX:(GLfloat) thePixelX pY:(GLfloat) thePixelY {
    memset(coords, 0, sizeof(GLfloat) * 24);
    coords[0] = 0.0f;
    coords[1] = thePixelY * (theH / 2);
    coords[4] = thePixelX * theH * 2;
    coords[5] = 0.0f;
    coords[8] = thePixelX * theW;
    coords[9] = coords[1];
    coords[12] = coords[0];
    coords[13] = coords[1];
    coords[16] = coords[8];
    coords[17] = coords[9];
    coords[20] = coords[4];
    coords[21] = thePixelY * theH;
}

- (void) generateVBO {
    glGenVertexArraysOES(1, &va);
    glBindVertexArrayOES(va);
    glGenBuffers(1, &vb);
    glBindBuffer(GL_ARRAY_BUFFER, vb);
    glBufferData(GL_ARRAY_BUFFER, sizeof(GLfloat) * 24, coords, GL_STATIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, 16, BUFFER_OFFSET(0));
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 16, BUFFER_OFFSET(8));
    glBindVertexArrayOES(0);

    free(coords);
    coords = NULL;
}

@end
#endif

//******************************************************************************
//      SCMLEntity
//******************************************************************************
@implementation SCMLEntity

#ifdef SCML_BONES_DRAW
@synthesize bones;
#endif
@synthesize name;
@synthesize characterMaps;
@synthesize animations;

+ (SCMLEntity *) newScmlEntity {
    SCMLEntity *entity = [[SCMLEntity alloc] init];
    [entity setName:nil];
    [entity setAnimations:[[NSMutableArray alloc] init]];
    [entity setCharacterMaps:[[NSMutableArray alloc] init]];
#ifdef SCML_BONES_DRAW
    [entity setBones:[[NSMutableArray alloc] init]];
#endif
    return entity;
}

- (void) dealloc {
    if (name) SAFE_ARC_RELEASE(name);
#ifdef SCML_BONES_DRAW
    for (SCMLBone *bone in bones) if (bone) SAFE_ARC_RELEASE(bone);
    SAFE_ARC_RELEASE(bones);
#endif
    for (SCMLCharacterMap *map in characterMaps) if (map) SAFE_ARC_RELEASE(map);
    SAFE_ARC_RELEASE(characterMaps);
    for (SCMLAnimation *animation in animations) if (animation) SAFE_ARC_RELEASE(animation);
    SAFE_ARC_RELEASE(animations);
    SAFE_ARC_SUPER_DEALLOC();
}

@end

//******************************************************************************
//      SCMLCharacterMap
//******************************************************************************
@implementation SCMLCharacterMap

@synthesize name;
@synthesize maps;

+ (SCMLCharacterMap *) newScmlCharacterMap {
    SCMLCharacterMap *characterMap = [[SCMLCharacterMap alloc] init];
    [characterMap setName:nil];
    [characterMap setMaps:[[NSMutableArray alloc] init]];
    return characterMap;
}

- (void) dealloc {
    if (name) SAFE_ARC_RELEASE(name);
    for (SCMLMapInstruction *map in maps) if (map) SAFE_ARC_RELEASE(map);
    SAFE_ARC_RELEASE(maps);
    SAFE_ARC_SUPER_DEALLOC();
}

@end

//******************************************************************************
//      SCMLMapInstruction
//******************************************************************************
@implementation SCMLMapInstruction

@synthesize folder;
@synthesize file;
@synthesize tarFolder;
@synthesize tarFile;

+ (SCMLMapInstruction *) newScmlMapInstruction {
    SCMLMapInstruction *mapInstruction = [[SCMLMapInstruction alloc] init];
    [mapInstruction setTarFolder:-1];
    [mapInstruction setTarFile:-1];
    return mapInstruction;
}

- (void) dealloc {
    SAFE_ARC_SUPER_DEALLOC();
}

@end

//******************************************************************************
//      SCMLAnimation
//******************************************************************************
@implementation SCMLAnimation

@synthesize name;
@synthesize length;
@synthesize loopType;
@synthesize mainlineKeys;
@synthesize timelines;

+ (SCMLAnimation *) newScmlAnimation {
    SCMLAnimation *animation = [[SCMLAnimation alloc] init];
    [animation setName:nil];
    [animation setLoopType:LT_LOOPING];
    [animation setMainlineKeys:[[NSMutableArray alloc] init]];
    [animation setTimelines:[[NSMutableArray alloc] init]];
    return animation;
}

- (void) dealloc {
    if (name) SAFE_ARC_RELEASE(name);

    for (SCMLMainlineKey *key in mainlineKeys) if (key) SAFE_ARC_RELEASE(key);
    SAFE_ARC_RELEASE(mainlineKeys);
    for (SCMLTimeline *timeline in timelines) if (timeline) SAFE_ARC_RELEASE(timeline);
    SAFE_ARC_RELEASE(timelines);
    SAFE_ARC_SUPER_DEALLOC();
}

- (SCMLMainlineKey *) mainlineKeyFromTime:(NSTimeInterval) theTime {
    SCMLMainlineKey *currentMainKey = nil;
    for (SCMLMainlineKey* mainlineKey in mainlineKeys) {
        if ([mainlineKey time] <= theTime) currentMainKey = mainlineKey;
        if ([mainlineKey time] > theTime) break;
    }
    return currentMainKey;
}

- (SCMLSpatialTimelineKey *) keyFromRef:(SCMLRef *) theRef time:(NSTimeInterval) newTime {
    SCMLTimeline *timeline = [timelines objectAtIndex:[theRef timeline]];
    SCMLSpatialTimelineKey *keyA = [[timeline keys] objectAtIndex:[theRef key]];
    if ([[timeline keys] count] == 1) {
        return [keyA copy];
    }
    int nextKeyIndex = [theRef key] + 1;
    if (nextKeyIndex >= [[timeline keys] count]) {
        if (loopType == LT_LOOPING) {
            nextKeyIndex = 0;
        } else {
            return [keyA copy];
        }
    }

    SCMLSpatialTimelineKey *keyB = [[timeline keys] objectAtIndex:nextKeyIndex];
    NSTimeInterval keyBTime = [keyB time];
    NSTimeInterval curTime = newTime;
    if (keyBTime < [keyA time]) {
        keyBTime += length;
        if (curTime < [keyA time]) curTime += length;
    }
    return (SCMLSpatialTimelineKey *) [keyA interpolate:keyB nextKeyTime:keyBTime currentTime:curTime];
}

@end

//******************************************************************************
//      SCMLMainlineKey
//******************************************************************************
@implementation SCMLMainlineKey

@synthesize time;
@synthesize boneRefs;
@synthesize objectRefs;

+ (SCMLMainlineKey *) newScmlMainlineKey {
    SCMLMainlineKey *mainlineKey = [[SCMLMainlineKey alloc] init];
    [mainlineKey setTime:0];
    [mainlineKey setBoneRefs:[[NSMutableArray alloc] init]];
    [mainlineKey setObjectRefs:[[NSMutableArray alloc] init]];
    return mainlineKey;
}

- (void) dealloc {
    for (SCMLRef *ref in boneRefs) if (ref) SAFE_ARC_RELEASE(ref);
    SAFE_ARC_RELEASE(boneRefs);
    for (SCMLRef *ref in objectRefs) if (ref) SAFE_ARC_RELEASE(ref);
    SAFE_ARC_RELEASE(objectRefs);
    SAFE_ARC_SUPER_DEALLOC();
}

@end

//******************************************************************************
//      SCMLRef
//******************************************************************************
@implementation SCMLRef

@synthesize parent;
@synthesize timeline;
@synthesize key;
@synthesize zIndex;

+ (SCMLRef *) newScmlRef {
    SCMLRef *ref = [[SCMLRef alloc] init];
    [ref setParent:-1];
    [ref setZIndex:0];
    return ref;
}

- (void) dealloc {
    SAFE_ARC_SUPER_DEALLOC();
}

@end

//******************************************************************************
//      SCMLTimeline
//******************************************************************************
@implementation SCMLTimeline

@synthesize name;
@synthesize objectType;
@synthesize keys;

+ (SCMLTimeline *) newScmlTimeline {
    SCMLTimeline *timeline = [[SCMLTimeline alloc] init];
    [timeline setName:nil];
    [timeline setKeys:[[NSMutableArray alloc] init]];
    return timeline;
}

- (void) dealloc {
    if (name) SAFE_ARC_RELEASE(name);
    for (SCMLTimelineKey *key in keys) if (key) SAFE_ARC_RELEASE(key);
    SAFE_ARC_RELEASE(keys);
    SAFE_ARC_SUPER_DEALLOC();
}

@end

//******************************************************************************
//      SCMLTimelineKey
//******************************************************************************
@implementation SCMLTimelineKey

@synthesize time;
@synthesize curveType;
@synthesize c1;
@synthesize c2;

+ (SCMLTimelineKey *) newScmlTimelineKey {
    SCMLTimelineKey *timelineKey = [[SCMLTimelineKey alloc] init];
    [timelineKey setTime:0];
    [timelineKey setCurveType:CT_LINEAR];
    return timelineKey;
}

- (void) dealloc {
    SAFE_ARC_SUPER_DEALLOC();
}

- (SCMLTimelineKey *) interpolate:(SCMLTimelineKey *) theNextKey nextKeyTime:(NSTimeInterval) theNextKeyTime currentTime:(NSTimeInterval) theCurrentTime {
    //It's fully overrided by subclass
    return nil;
}

- (float) getTimeRatioWithNextKey:(SCMLTimelineKey *) theNextKey nextKeyTime:(NSTimeInterval) theNextKeyTime currentTime:(NSTimeInterval) theCurrentTime {
    if (curveType == CT_INSTANT || time == theNextKeyTime) {
        return 0.0f;
    }
    float t = (theCurrentTime - time) / (theNextKeyTime - time);
    if (curveType == CT_LINEAR) {
        return t;
    } else if (curveType == CT_QUADRATIC) {
        return quadratic(0.0f, c1, 1.0, t);
    } else if (curveType == CT_CUBIC) {
        return cubic(0.0f, c1, c2, 1.0f, t);
    }
    return 0.0f;
}

@end

//******************************************************************************
//      SCMLSpatialTimelineKey
//******************************************************************************
@implementation SCMLSpatialTimelineKey

@synthesize info;

+ (SCMLSpatialTimelineKey *) newScmlSpatialTimelineKey {
    SCMLSpatialTimelineKey *spatialTimelineKey = [[SCMLSpatialTimelineKey alloc] init];
    [spatialTimelineKey setInfo:[SCMLSpatialInfo newScmlSpatialInfo]];
    return spatialTimelineKey;
}

- (void) dealloc {
    SAFE_ARC_RELEASE(info);
    SAFE_ARC_SUPER_DEALLOC();
}

@end

//******************************************************************************
//      SCMLSpatialInfo
//******************************************************************************
@implementation SCMLSpatialInfo

@synthesize x;
@synthesize y;
@synthesize angle;
@synthesize scaleX;
@synthesize scaleY;
@synthesize a;
@synthesize spin;

+ (SCMLSpatialInfo *) newScmlSpatialInfo {
    SCMLSpatialInfo *spatialInfo = [[SCMLSpatialInfo alloc] init];
    [spatialInfo setX:0.0f];
    [spatialInfo setY:0.0f];
    [spatialInfo setAngle:0.0f];
    [spatialInfo setScaleX:1.0f];
    [spatialInfo setScaleY:1.0f];
    [spatialInfo setA:1.0f];
    [spatialInfo setSpin:1];
    return spatialInfo;
}

- (void) dealloc {
    SAFE_ARC_SUPER_DEALLOC();
}

- (instancetype) copyWithZone:(NSZone *) zone {
    SCMLSpatialInfo *spatialInfo = [[[self class] allocWithZone:zone] init];
    spatialInfo.x = self.x;
    spatialInfo.y = self.y;
    spatialInfo.angle = self.angle;
    spatialInfo.scaleX = self.scaleX;
    spatialInfo.scaleY = self.scaleY;
    spatialInfo.a = self.a;
    spatialInfo.spin = self.spin;
    return spatialInfo;
}

- (SCMLSpatialInfo *) unmapFromParent:(SCMLSpatialInfo *) theParentInfo {
    SCMLSpatialInfo *unmappedObj = [self copy];
    if ([theParentInfo scaleX] * [theParentInfo scaleY] < 0) {
        [unmappedObj setAngle:(360 - [unmappedObj angle]) + [theParentInfo angle]];
    } else {
        [unmappedObj setAngle:[theParentInfo angle] + [unmappedObj angle]];
    }
    while ([unmappedObj angle] >= 360) [unmappedObj setAngle:[unmappedObj angle] - 360.0f];
    while ([unmappedObj angle] < 0) [unmappedObj setAngle:[unmappedObj angle] + 360.0f];
    [unmappedObj setScaleX:[unmappedObj scaleX] * [theParentInfo scaleX]];
    [unmappedObj setScaleY:[unmappedObj scaleY] * [theParentInfo scaleY]];
    [unmappedObj setA:[unmappedObj a] * [theParentInfo a]];

    if (x != 0.0f || y != 0.0f) {
        float preMultX = x * [theParentInfo scaleX];
        float preMultY = y * [theParentInfo scaleY];
        float r = GLKMathDegreesToRadians([theParentInfo angle]);
        float s = sinf(r);
        float c = cosf(r);
        float ys = (preMultY * s);
        float yc = (preMultY * c);
        float xs = (preMultX * s);
        float xc = (preMultX * c);
        [unmappedObj setX:ys + xc];
        [unmappedObj setY:xs - yc];
        [unmappedObj setX:[unmappedObj x] + [theParentInfo x]];
        [unmappedObj setY:-[unmappedObj y] + [theParentInfo y]];
    } else {
        [unmappedObj setX:[theParentInfo x]];
        [unmappedObj setY:[theParentInfo y]];
    }
    return unmappedObj;
}

- (void) linear:(SCMLSpatialInfo *) theInfoB timeRatio:(float) theTimeRatio {
    [self setX: linear(x, [theInfoB x], theTimeRatio)];
    [self setY: linear(y, [theInfoB y], theTimeRatio)];
    [self setAngle: angleLinear(angle, [theInfoB angle], spin, theTimeRatio)];
    [self setScaleX: linear(scaleX, [theInfoB scaleX], theTimeRatio)];
    [self setScaleY: linear(scaleY, [theInfoB scaleY], theTimeRatio)];
    [self setA: linear(a, [theInfoB a], theTimeRatio)];
}

@end

//******************************************************************************
//      SCMLBoneTimelineKey
//******************************************************************************
@implementation SCMLBoneTimelineKey

#ifdef SCML_BONES_DRAW
@synthesize bone;
#endif
@synthesize length;
@synthesize width;

+ (SCMLBoneTimelineKey *) newScmlBoneTimelineKey {
    SCMLBoneTimelineKey *boneTimelineKey = [[SCMLBoneTimelineKey alloc] init];
    [boneTimelineKey setLength:200];
    [boneTimelineKey setWidth:10];
    [boneTimelineKey setBone:nil];
    [boneTimelineKey setInfo:[SCMLSpatialInfo newScmlSpatialInfo]];
    [boneTimelineKey setTime:0];
    [boneTimelineKey setCurveType:CT_LINEAR];
    return boneTimelineKey;
}

- (instancetype) copyWithZone:(NSZone *) zone {
    SCMLBoneTimelineKey *boneTimelineKey = [[[self class] allocWithZone:zone] init];
    boneTimelineKey.length = self.length;
    boneTimelineKey.width = self.width;
    boneTimelineKey.bone = self.bone;
    boneTimelineKey.info = [self.info copy];
    return boneTimelineKey;
}

- (void) dealloc {
    SAFE_ARC_SUPER_DEALLOC();
}

- (SCMLBoneTimelineKey *) interpolate:(SCMLBoneTimelineKey *) theNextKey nextKeyTime:(NSTimeInterval) theNextKeyTime currentTime:(NSTimeInterval) theCurrentTime {
    return [self linear:theNextKey timeRatio:[self getTimeRatioWithNextKey:theNextKey nextKeyTime:theNextKeyTime currentTime:theCurrentTime]];
}

- (SCMLBoneTimelineKey *) linear:(SCMLBoneTimelineKey *) theKeyB timeRatio:(float) theTimeRatio {
    SCMLBoneTimelineKey *returnKey = [self copy];
    [[returnKey info] linear:[theKeyB info] timeRatio:theTimeRatio];
#ifdef SCML_BONES_DRAW
    [returnKey setLength:linear([returnKey length], [theKeyB length], theTimeRatio)];
    [returnKey setWidth:linear([returnKey width], [theKeyB width], theTimeRatio)];
#endif
    return returnKey;
}

@end

//******************************************************************************
//      SCMLSpriteTimelineKey
//******************************************************************************
@implementation SCMLSpriteTimelineKey

@synthesize file;
@synthesize useDefaultPivot;
@synthesize pivotX;
@synthesize pivotY;

+ (SCMLSpriteTimelineKey *) newScmlSpriteTimelineKey {
    SCMLSpriteTimelineKey *spriteTimelineKey = [[SCMLSpriteTimelineKey alloc] init];
    [spriteTimelineKey setPivotX:0.0f];
    [spriteTimelineKey setPivotY:1.0f];
    [spriteTimelineKey setFile:nil];
    [spriteTimelineKey setUseDefaultPivot:false];
    [spriteTimelineKey setInfo:[SCMLSpatialInfo newScmlSpatialInfo]];
    [spriteTimelineKey setTime:0];
    [spriteTimelineKey setCurveType:CT_LINEAR];
    return spriteTimelineKey;
}

- (instancetype) copyWithZone:(NSZone *) zone {
    SCMLSpriteTimelineKey *spriteTimelineKey = [[[self class] allocWithZone:zone] init];
    spriteTimelineKey.file = self.file;
    spriteTimelineKey.useDefaultPivot = self.useDefaultPivot;
    spriteTimelineKey.pivotX = self.pivotX;
    spriteTimelineKey.pivotY = self.pivotY;
    spriteTimelineKey.info = [self.info copy];
    return spriteTimelineKey;
}

- (void) dealloc {
    SAFE_ARC_SUPER_DEALLOC();
}

- (SCMLSpriteTimelineKey *) interpolate:(SCMLSpriteTimelineKey *) theNextKey nextKeyTime:(NSTimeInterval) theNextKeyTime currentTime:(NSTimeInterval) theCurrentTime {
    return [self linear:theNextKey timeRatio:[self getTimeRatioWithNextKey:theNextKey nextKeyTime:theNextKeyTime currentTime:theCurrentTime]];
}

- (SCMLSpriteTimelineKey *) linear:(SCMLSpriteTimelineKey *) theKeyB timeRatio:(float) theTimeRatio {
    SCMLSpriteTimelineKey *returnKey = [self copy];
    [[returnKey info] linear:[theKeyB info] timeRatio:theTimeRatio];
    if (!useDefaultPivot) {
        [returnKey setPivotX:linear(pivotX, [theKeyB pivotX], theTimeRatio)];
        [returnKey setPivotY:linear(pivotY, [theKeyB pivotY], theTimeRatio)];
    }
    return returnKey;
}

@end
