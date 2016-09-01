//
//  MFKShader.h
//  MFKSpriterKit
//
//  Created by mefik on 24.11.15.
//  Copyright (c) 2015 mefik. All rights reserved.
//

#import <Foundation/Foundation.h>

// Uniform index.
enum
{
    UNIFORM_MODELVIEWPROJECTION_MATRIX,
    UNIFORM_NORMAL_MATRIX,
    UNIFORM_LIGHT_POSITION,
    UNIFORM_TEXTURE,
    UNIFORM_TEXTUREUSE,
    UNIFORM_COLOR,
    NUM_UNIFORMS
};
GLint uniforms[NUM_UNIFORMS];

// Attribute index.
enum
{
    ATTRIB_VERTEX,
    ATTRIB_NORMAL,
    ATTRIB_COLOR,
    NUM_ATTRIBUTES
};

@interface MFKShader : NSObject {
    GLuint program;
}

+ (MFKShader *) newShader;
- (void) dealloc;

@end
