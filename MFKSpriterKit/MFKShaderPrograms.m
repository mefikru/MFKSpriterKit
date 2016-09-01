//
//  MFKShaderPrograms.m
//  MFKSpriterKit
//
//  Created by mefik on 04.02.15.
//  Copyright (c) 2015 mefik-studio. All rights reserved.
//

#import "MFKShaderPrograms.h"
#import "MFKTypes.h"

#import <OpenGLES/ES2/glext.h>

@implementation MFKShaderProgram

@synthesize program;
@synthesize vertShader;
@synthesize fragShader;
@synthesize uniforms;

+ (MFKShaderProgram *) newShaderProgram {
    MFKShaderProgram *sp = [[MFKShaderProgram alloc] init];
    [sp setUniforms:[[NSMutableDictionary alloc] init]];
    return sp;
}

- (void) dealloc {
    SAFE_ARC_RELEASE(uniforms);
    SAFE_ARC_SUPER_DEALLOC();
}

- (GLuint *) getVertShader {
    return &vertShader;
}

- (GLuint *) getFragShader {
    return &fragShader;
}

- (GLuint) uniform:(MFKUniformEnum) theUniform {
    NSNumber *uniform = [uniforms objectForKey:[NSNumber numberWithInt:theUniform]];
    if (uniform)
        return [uniform intValue];
    else
        return 0;
}

@end


@implementation MFKShaderPrograms

@synthesize programs;

+ (MFKShaderPrograms *) newShaderPrograms {
    MFKShaderPrograms *sp = [[MFKShaderPrograms alloc] init];
    [sp setPrograms:[[NSMutableDictionary alloc] init]];
    return sp;
}

- (void) dealloc {
    for (MFKShaderProgram *sp in programs) {
        glDeleteProgram([sp program]);
        SAFE_ARC_RELEASE(sp);
    }
    SAFE_ARC_RELEASE(programs);
    SAFE_ARC_SUPER_DEALLOC();
}

- (MFKShaderProgram *) program:(MFKShaderProgramEnum) theType {
    return [programs objectForKey:[NSNumber numberWithInt:theType]];
}

- (void) attachAttribute:(MFKShaderProgramEnum) theType index:(GLuint) theIndex name:(const GLchar *) theName {
    MFKShaderProgram *program = [programs objectForKey:[NSNumber numberWithInt:theType]];
    GLuint glProgram;
    if (program) {
        glProgram = [program program];
    } else {
        return;
    }
    glBindAttribLocation(glProgram, theIndex, theName);
}

- (void) attachUniform:(MFKShaderProgramEnum) theType uniform:(MFKUniformEnum) theUniform name:(const GLchar *) theName {
    MFKShaderProgram *program = [programs objectForKey:[NSNumber numberWithInt:theType]];
    GLuint glProgram;
    if (program) {
        glProgram = [program program];
    } else {
        return;
    }

    GLint uniform = glGetUniformLocation(glProgram, theName);
    [[program uniforms] setObject:[NSNumber numberWithInt:uniform] forKey:[NSNumber numberWithInt:theUniform]];
}


- (BOOL) linkShader:(MFKShaderProgramEnum) theType {
    MFKShaderProgram *program = [programs objectForKey:[NSNumber numberWithInt:theType]];
    if (program) {
        if (![self linkProgram:[program program]]) {
            NSLog(@"Failed to link program: %d", [program program]);

            if ([program vertShader]) {
                glDeleteShader([program vertShader]);
                [program setVertShader: 0];
            }
            if ([program fragShader]) {
                glDeleteShader([program fragShader]);
                [program setFragShader: 0];
            }
            if ([program program]) {
                glDeleteProgram([program program]);
                [program setProgram: 0];
            }
            [programs delete:program];
            SAFE_ARC_RELEASE(program);
            return NO;
        }
    } else
        return NO;
    return YES;
}

- (BOOL) releaseShader:(MFKShaderProgramEnum) theType {
    MFKShaderProgram *program = [programs objectForKey:[NSNumber numberWithInt:theType]];
    if (program) {
        if ([program vertShader]) {
            glDetachShader([program program], [program vertShader]);
            glDeleteShader([program vertShader]);
        }
        if ([program fragShader]) {
            glDetachShader([program program], [program fragShader]);
            glDeleteShader([program fragShader]);
        }
    } else
        return NO;
    return YES;
}

- (void) deleteShaders {
    for (MFKShaderProgram *sp in programs) {
        glDeleteProgram([sp program]);
        SAFE_ARC_RELEASE(sp);
    }
    [programs removeAllObjects];
}

- (BOOL) loadShader:(NSString *) theShaderName type:(MFKShaderProgramEnum) theType {
    NSString *vertShaderPathname, *fragShaderPathname;

    MFKShaderProgram *program = [programs objectForKey:[NSNumber numberWithInt:theType]];
    GLuint glProgram;
    if ([programs objectForKey:[NSNumber numberWithInt:theType]]) {
        glProgram = [program program];
    } else {
        glProgram = glCreateProgram();
        program = [MFKShaderProgram newShaderProgram];
        [program setProgram:glProgram];
        [programs setObject:program forKey:[NSNumber numberWithInt:theType]];
    }

    // Create and compile vertex shader.
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:theShaderName ofType:@"vsh"];
    if (![self compileShader:[program getVertShader] type:GL_VERTEX_SHADER file:vertShaderPathname]) {
        NSLog(@"Failed to compile vertex shader");
        return NO;
    }

    // Create and compile fragment shader.
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:theShaderName ofType:@"fsh"];
    if (![self compileShader:[program getFragShader] type:GL_FRAGMENT_SHADER file:fragShaderPathname]) {
        NSLog(@"Failed to compile fragment shader");
        return NO;
    }

    // Attach vertex shader to program.
    glAttachShader(glProgram, [program vertShader]);

    // Attach fragment shader to program.
    glAttachShader(glProgram, [program fragShader]);

    return YES;
}

- (BOOL) compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file {
    GLint status;
    const GLchar *source;

    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source) {
        NSLog(@"Failed to load vertex shader");
        return NO;
    }

    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);

#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif

    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0) {
        glDeleteShader(*shader);
        return NO;
    }

    return YES;
}

- (BOOL) linkProgram:(GLuint)prog {
    GLint status;
    glLinkProgram(prog);

#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif

    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0) {
        return NO;
    }

    return YES;
}

- (BOOL) validateProgram:(GLuint)prog {
    GLint status;

    glValidateProgram(prog);
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
#endif

    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0) {
        return NO;
    }

    return YES;
}

@end
