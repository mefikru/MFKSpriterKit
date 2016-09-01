//
//  MFKGLTextController.h
//  MFKSpriterKit
//
//  Created by mefik on 29.09.10.
//  Copyright 2010 mefik-studio. All rights reserved.
//

#import "MFKTypes.h"

#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <Foundation/Foundation.h>

struct GL_FONT {
	GLfloat texture[8];
	unsigned short w;
	unsigned short h;
};

struct GL_FONTS {
	struct GL_FONT* font;
};

@interface MFKGLTextController : NSObject {
@private
	struct GL_FONTS *fonts;
    GLuint textures[MAX_TEXTUREFONTS];
}
@property (assign, nonatomic) GLfloat mapCoordX;
@property (assign, nonatomic) GLfloat mapCoordY;
@property (assign, nonatomic) GLfloat px;
@property (assign, nonatomic) GLfloat py;
@property (assign, nonatomic) GLint uniformColor;
@property (assign, nonatomic) GLint uniformTexture;
@property (assign, nonatomic) unsigned char scale;
@property (ARC_ASSIGN, nonatomic) NSMutableArray *textObjects;

+ (MFKGLTextController *) newWithFonts: (struct GL_FONTS *) theFonts;
- (void) dealloc;
- (void) setTexture: (GLuint) theTextureInfo index: (unsigned short) theIndex;
- (void) setMapCoords: (GLfloat) theX :(GLfloat) theY;
- (void) renderTextFromArray: (NSMutableArray *) theArray;
- (void) renderTextFromBuf: (__unsafe_unretained MFKGLText *[]) theBuf size: (unsigned short) theSize;
- (void) renderTextFromGLtext: (MFKGLText *) theText;
- (void) renderText: (unsigned short) theFrom to: (unsigned short) theTo;

@end
