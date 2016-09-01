//
//  MFKGLTextController.m
//  MFKSpriterKit
//
//  Created by mefik on 29.09.10.
//  Copyright 2010 mefik-studio. All rights reserved.
//

#import "MFKGLText.h"
#import "MFKGLTextController.h"

@implementation MFKGLTextController

@synthesize mapCoordX;
@synthesize mapCoordY;
@synthesize px;
@synthesize py;
@synthesize uniformColor;
@synthesize uniformTexture;
@synthesize scale;
@synthesize textObjects;

+ (MFKGLTextController *) newWithFonts: (struct GL_FONTS *) theFonts {
    MFKGLTextController *gltc = [[MFKGLTextController alloc] init];
    [gltc setTextObjects: [[NSMutableArray alloc] init]];
    gltc->fonts = theFonts;
    for (int i = 0; i < MAX_TEXTUREFONTS; i++) gltc->textures[i] = 0;
    return gltc;
}

- (void) dealloc {
    for (int i = 0; i < [textObjects count]; i++) SAFE_ARC_RELEASE([textObjects objectAtIndex:i]);
    SAFE_ARC_RELEASE(textObjects);
    SAFE_ARC_SUPER_DEALLOC();
}

- (void) setTexture: (GLuint) theTextureInfo index: (unsigned short) theIndex {
    if (theIndex < MAX_TEXTUREFONTS)
        textures[theIndex] = theTextureInfo;
}

- (void) setMapCoords: (GLfloat) theX :(GLfloat) theY {
    [self setMapCoordX: theX];
    [self setMapCoordY: theY];
}

- (int) measureText: (NSString *) theText startFrom: (int) theStart measuredSize: (Point *) theMeasuredSize font: (int) theFont rect: (Rect *) theRect {
	theMeasuredSize->v = 0;
	theMeasuredSize->h = 0;
	long width = (theRect->right << scale) - (theRect->left << scale);
	long height = (theRect->bottom << scale) - (theRect->top << scale);
	unsigned char c;
	unsigned short w, h;
	int i;
	for (i = theStart; i < [theText length]; i++) {
		c = [theText characterAtIndex:i] - 32;
		w = fonts[theFont].font[c].w << scale;
		h = fonts[theFont].font[c].h << scale;
		if (theMeasuredSize->v + w > width) break;
		if (theMeasuredSize->h > h) { if (theMeasuredSize->h > height) break; } else { 
			if (h > height) break; 
			theMeasuredSize->h = h;
		}
		theMeasuredSize->v += w;
	}
	return i - theStart;
}

- (void) renderTextObject: (MFKGLText *) theText {
    if (theText == nil) return;
    if ([[theText text] compare:@""] == NSOrderedSame) return;
    int f = [theText getFont];
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, textures[f]);
//    glBindTexture(GL_TEXTURE0, textures[f]);
    glUniform4f(uniformColor, [theText R], [theText G], [theText B], [theText A]);
    glUniform1i(uniformTexture, 0);
    long width = ([theText rect]->right << scale) - ([theText rect]->left << scale);
	int ts, te;
    te = 0;
    ts = 0;
    GLfloat coords[8];
    GLfloat curX = (GLfloat) [theText rect]->left * px;
    GLfloat curY = (GLfloat) [theText rect]->top * py;
    if ([theText mapCoords]) {
        curX = mapCoordX + curX;
        curY = mapCoordY + curY;
    }
    unsigned char c;
	Point ms;

    while ((te = [self measureText:[theText text] startFrom:ts measuredSize:&ms font:f rect:[theText rect]]) > 0) {
        if (te) {
            if ([theText getJustify] == TJ_RIGHT) curX += (width - ms.v) * px;
//            if ([theText getJustify] == TJ_CENTER) curX += ((width - ms.v) * xPix) / 2;
        }
        for (int j = ts; j < ts + te; j++) {
            c = [[theText text] characterAtIndex:j] - 32;
            coords[2] = curX;
            coords[3] = curY;
            coords[0] = coords[2];
            coords[1] = coords[3] + ((fonts[f].font[c].h << scale) * py);
            coords[4] = coords[2] + ((fonts[f].font[c].w << scale) * px);
            coords[5] = coords[3];
            coords[6] = coords[4];
            coords[7] = coords[1];
            curX += ((fonts[f].font[c].w << scale) * px);
            glEnableVertexAttribArray(GLKVertexAttribPosition);
            glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
            glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, 0, coords);
            glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 0, fonts[f].font[c].texture);
            glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
            glDisableVertexAttribArray(GLKVertexAttribPosition);
            glDisableVertexAttribArray(GLKVertexAttribTexCoord0);
        }
        ts += te;
        curY += (ms.h / 2) * py;
        curX = [theText rect]->left * px;
    }
}

- (void) renderTextFromArray: (NSMutableArray *) theArray {
    for (MFKGLText *text in theArray) {
        [self renderTextObject:text];
    }
}

- (void) renderTextFromBuf: (__unsafe_unretained MFKGLText *[]) theBuf size: (unsigned short) theSize  {
    unsigned short s = theSize;
    while (theSize) {
        [self renderTextObject:theBuf[s - theSize]];
        theSize--;
    }
}

- (void) renderTextFromGLtext: (MFKGLText *) theText {
    [self renderTextObject:theText];
}

- (void) renderText: (unsigned short) theFrom to: (unsigned short) theTo {
    for (int i = theFrom; i < theTo; i++) {
        MFKGLText *text = [textObjects objectAtIndex:i];
        [self renderTextObject:text];
	}
}

@end
