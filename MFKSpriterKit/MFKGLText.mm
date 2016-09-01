//
//  MFKGLText.m
//  MFKSpriterKit
//
//  Created by mefik on 29.09.10.
//  Copyright 2010 mefik-studio. All rights reserved.
//

#import "MFKTypes.h"
#import "MFKGLText.h"

@implementation MFKGLText

@synthesize text;
@synthesize rect;
@synthesize mapCoords;
@synthesize R;
@synthesize G;
@synthesize B;
@synthesize A;

+ (MFKGLText *) newWithText: (NSString *) theText font: (int) theFontNum justify: (MFKTextJustifyEnum) theJustify mapCoords: (bool) theMapCoords rect: (Rect) theRect R: (GLfloat) theR G: (GLfloat) theG B: (GLfloat) theB A: (GLfloat) theA {
	MFKGLText *t = [[MFKGLText alloc] init];
	[t setText:theText];
	t->rect = (Rect *) malloc(sizeof(Rect));
	*t->rect = theRect;
	t->font = theFontNum;
	t->justify = theJustify;
    t->R = theR;
    t->G = theG;
    t->B = theB;
    t->A = theA;
    [t setMapCoords:theMapCoords];
	return t;
}

- (void) dealloc {
	free(rect);
    SAFE_ARC_RELEASE(text);
    SAFE_ARC_SUPER_DEALLOC();
}

- (int) getFont {
	return font;
}

- (MFKTextJustifyEnum) getJustify {
	return justify;
}

@end
