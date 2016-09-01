//
//  MFKGLText.h
//  MFKSpriterKit
//
//  Created by mefik on 29.09.10.
//  Copyright 2010 mefik-studio. All rights reserved.
//

#import "MFKTypes.h"
#import <Foundation/Foundation.h>

@interface MFKGLText : NSObject {
@private
	NSString *text;
	Rect *rect;
	MFKTextJustifyEnum justify;
	int font;
}

@property (ARC_RETAIN, nonatomic) NSString *text;
@property (assign, nonatomic) Rect *rect;
@property (assign, nonatomic) bool mapCoords;
@property (assign, nonatomic) GLfloat R;
@property (assign, nonatomic) GLfloat G;
@property (assign, nonatomic) GLfloat B;
@property (assign, nonatomic) GLfloat A;

+ (MFKGLText *) newWithText: (NSString *) theText font: (int) theFontNum justify: (MFKTextJustifyEnum) theJustify mapCoords: (bool) theMapCoords rect: (Rect) theRect R: (GLfloat) theR G: (GLfloat) theG B: (GLfloat) theB A: (GLfloat) theA ;
- (void) dealloc;
- (int) getFont;
- (MFKTextJustifyEnum) getJustify;

@end
