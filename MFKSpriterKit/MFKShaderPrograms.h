//
//  MFKShaderPrograms.h
//  MFKSpriterKit
//
//  Created by mefik on 04.02.15.
//  Copyright (c) 2015 mefik-studio. All rights reserved.
//

#import "MFKTypes.h"

#import <Foundation/Foundation.h>

// Uniform index.
typedef enum {
    U_MODELVIEWPROJECTION_MATRIX,
    U_TEXTURE,
    U_TEXTUREUSE,
    U_COLOR,
    U_PIVOT,
    U_TRANSLATE,
    U_BASIC_TRANSLATE,
    U_ROTATE,
    U_BASIC_ROTATE,
    U_SCALE,
    U_BASIC_SCALE,
    U_SCML_BASE_SCALE,
    NUM_UNIFORMS
} MFKUniformEnum;

// Shaders
typedef enum {
    SP_MAIN,
    SP_SCML,
    NUM_SHADERPROGRAMS
} MFKShaderProgramEnum;

@interface MFKShaderProgram : NSObject;
@property (assign, nonatomic) GLuint program;
@property (assign, nonatomic) GLuint vertShader;
@property (assign, nonatomic) GLuint fragShader;
@property (ARC_ASSIGN, nonatomic) NSMutableDictionary *uniforms;

+ (MFKShaderProgram *) newShaderProgram;
- (void) dealloc;
- (GLuint) uniform:(MFKUniformEnum) theUniform;

@end

@interface MFKShaderPrograms : NSObject;

@property (ARC_ASSIGN, nonatomic) NSMutableDictionary *programs; //List of MFKShaderProgram objects

+ (MFKShaderPrograms *) newShaderPrograms;
- (void) dealloc;

- (MFKShaderProgram *) program:(MFKShaderProgramEnum) theType;

- (BOOL) loadShader:(NSString *) theShaderName type:(MFKShaderProgramEnum) theType;
- (void) attachAttribute:(MFKShaderProgramEnum) theType index:(GLuint) theIndex name:(const GLchar *) theName;
- (BOOL) linkShader:(MFKShaderProgramEnum) theType;
- (void) attachUniform:(MFKShaderProgramEnum) theType uniform:(MFKUniformEnum) theUniform name:(const GLchar *) theName;
- (BOOL) releaseShader:(MFKShaderProgramEnum) theType;
- (void) deleteShaders;

@end