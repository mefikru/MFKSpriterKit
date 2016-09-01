//
//  GameViewController.m
//  MFKSpriterKit
//
//  Created by mefik on 03.11.14.
//  Copyright (c) 2014 mefik-studio. All rights reserved.
//

#import "GameViewController.h"
#import "SCMLObject.h"
#import "MFKTypes.h"
#import "MFKGLText.h"
#import "MFKGLTextController.h"
#import "MFKMenu.h"
#import "MFKTouchMulti.h"
#import "MFKShaderPrograms.h"

#import <OpenGLES/ES2/glext.h>

#define BUFFER_OFFSET(i) ((char *)NULL + (i))

@interface GameViewController () {
    GLKMatrix4 modelViewProjectionMatrix;
    NSTimeInterval currentTime;
    int currentAnimation;
    int currentEntity;
    int currentSCML;
    NSString *currentSCMLName;

    MFKShaderPrograms *shaderPrograms;

    GLfloat nScale;
    GLfloat nPixel;
    GLfloat nTouchXScale;
    GLfloat nTouchYScale;
    CGSize screenSize;
    CGSize screenRatio;
    NSString *textureScale;

    GLuint fontTahoma;
    struct GL_FONTS fonts[MAX_TEXTUREFONTS];
    MFKGLTextController *textController;

    GLfloat *lines;

    NSMutableArray *touchesCurrent; //array of MFKTouchMulti classes

    MFKMenu *menu;

    NSMutableArray *scmlList;

    SCMLTextures *scmlTextures;
    SCMLObject *scmlObject;
    bool flipHorizontal;
    GLfloat basicRotate;

#ifdef SCML_BONES_DRAW
    bool showBones;
#endif
}
@property (strong, nonatomic) EAGLContext *context;

- (void) setupGL;
- (void) tearDownGL;

@end

@implementation GameViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];

    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    screenSize = CGSizeMake(screenBounds.size.width * screenScale, screenBounds.size.height * screenScale);

    //Magic
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        screenSize = CGSizeMake(screenSize.height, screenSize.width);
    }
    if (screenBounds.size.height > screenBounds.size.width) {
        screenBounds.size = CGSizeMake(screenBounds.size.height, screenBounds.size.width);
    }

    //Calculate screen ratio and pixel size
    unsigned long n = round(screenSize.width);
    unsigned long d = round(screenSize.height);
    unsigned long mcm = d;
    while (mcm > 1) {
        if ((n % mcm) == 0 && (d % mcm) == 0) break;
        mcm--;
    }
    nPixel = 1.0f;
    if (mcm != d && mcm > 1) {
        n /= mcm;
        d /= mcm;
        nPixel = (CGFloat) n / screenSize.width;
    }
    screenRatio.width = n;
    screenRatio.height = d;

    //Calculate the scale factor
    unsigned short scaleFactor = 1 << (unsigned int) round(screenScale - 1);
    //If the screen is large enough (iPad for example), just increase the scaleFactor to load better quality texture and increase size.
    if (screenSize.width > 512 * scaleFactor) {
        scaleFactor <<= 1;
    }
    textureScale = [NSString stringWithFormat:@"%@", scaleFactor ==  1 ? @"" : [NSString stringWithFormat:@"@%ix", scaleFactor]];

    //Calculate the touch scale
    nTouchXScale = (screenSize.width / scaleFactor) / screenBounds.size.width;
    nTouchYScale = (screenSize.height / scaleFactor) / screenBounds.size.height;
    //Touches engine
    touchesCurrent = [[NSMutableArray alloc] init];

    //Setup GL
    [self setupGL];

    //Cross lines
    GLfloat line[] = {
        -nPixel, nPixel * screenSize.height,
        -nPixel, -nPixel * screenSize.height,
        nPixel, -nPixel * screenSize.height,
        -nPixel, nPixel * screenSize.height,
        nPixel, -nPixel * screenSize.height,
        nPixel, nPixel * screenSize.height,

        -nPixel * screenSize.width, nPixel,
        -nPixel * screenSize.width, -nPixel,
        nPixel * screenSize.width, -nPixel,
        -nPixel * screenSize.width, nPixel,
        nPixel * screenSize.width, -nPixel,
        nPixel * screenSize.width, nPixel,
    };
    lines = malloc(sizeof(line));
    memcpy(lines, line, sizeof(line));

    //Shaders
    shaderPrograms = [MFKShaderPrograms newShaderPrograms];
    [shaderPrograms loadShader:@"Shader" type:SP_MAIN];
    [shaderPrograms attachAttribute:SP_MAIN index:GLKVertexAttribPosition name:"a_position"];
    [shaderPrograms attachAttribute:SP_MAIN index:GLKVertexAttribTexCoord0 name:"a_texture"];
    if ([shaderPrograms linkShader:SP_MAIN]) {
        [shaderPrograms attachUniform:SP_MAIN uniform:U_MODELVIEWPROJECTION_MATRIX name:"u_projectionMatrix"];
        [shaderPrograms attachUniform:SP_MAIN uniform:U_TEXTURE name:"u_texture"];
        [shaderPrograms attachUniform:SP_MAIN uniform:U_TEXTUREUSE name:"u_textureUse"];
        [shaderPrograms attachUniform:SP_MAIN uniform:U_COLOR name:"u_color"];
        [shaderPrograms releaseShader:SP_MAIN];
    }
    [shaderPrograms loadShader:@"SCML" type:SP_SCML];
    [shaderPrograms attachAttribute:SP_SCML index:GLKVertexAttribPosition name:"a_position"];
    [shaderPrograms attachAttribute:SP_SCML index:GLKVertexAttribTexCoord0 name:"a_texture"];
    if ([shaderPrograms linkShader:SP_SCML]) {
        [shaderPrograms attachUniform:SP_SCML uniform:U_MODELVIEWPROJECTION_MATRIX name:"u_projectionMatrix"];
        [shaderPrograms attachUniform:SP_SCML uniform:U_TEXTURE name:"u_texture"];
        [shaderPrograms attachUniform:SP_SCML uniform:U_TEXTUREUSE name:"u_textureUse"];
        [shaderPrograms attachUniform:SP_SCML uniform:U_COLOR name:"u_color"];
        [shaderPrograms attachUniform:SP_SCML uniform:U_PIVOT name:"u_pivot"];
        [shaderPrograms attachUniform:SP_SCML uniform:U_TRANSLATE name:"u_translate"];
        [shaderPrograms attachUniform:SP_SCML uniform:U_BASIC_TRANSLATE name:"u_basicTranslate"];
        [shaderPrograms attachUniform:SP_SCML uniform:U_ROTATE name:"u_rotate"];
        [shaderPrograms attachUniform:SP_SCML uniform:U_BASIC_ROTATE name:"u_basicRotate"];
        [shaderPrograms attachUniform:SP_SCML uniform:U_SCALE name:"u_scale"];
        [shaderPrograms attachUniform:SP_SCML uniform:U_BASIC_SCALE name:"u_basicScale"];
        [shaderPrograms attachUniform:SP_SCML uniform:U_SCML_BASE_SCALE name:"u_scmlBaseScale"];
        [shaderPrograms releaseShader:SP_SCML];
    }

    //SCML Textures engine
    scmlTextures = [SCMLTextures newScmlTextures];
    [scmlTextures setScalePrefix:textureScale];
    [scmlTextures setScaleFactor:scaleFactor];

    //Menu
    menu = [MFKMenu newMenu];
    [menu setScreenSize:screenSize];
    [menu setScreenScale:scaleFactor];
    [menu setPixelSize:nPixel * scaleFactor];
    [menu setTexturesController:scmlTextures];
    [menu setUniformTexture:[[shaderPrograms program:SP_MAIN] uniform:U_TEXTURE]];
    [menu setUniformProjectionMatrix:[[shaderPrograms program:SP_MAIN] uniform:U_MODELVIEWPROJECTION_MATRIX]];
    [menu setTouchMenuCallback:self withSelector:@selector(menuTouch:)];
    [menu setProbeMenuCallback:self withSelector:@selector(menuProbe:)];
    [menu loadGameMenus:@"menus"];

    //Fonts
    fontTahoma = [scmlTextures addTexture:@"tahoma.png" useScalePrefix:YES];
    fonts[FONT_TAHOMA].font = (struct GL_FONT *) malloc(sizeof(struct GL_FONT) * 96);
    [self loadData:@"tahoma" :@"bin" :fonts[FONT_TAHOMA].font];
    textController = [MFKGLTextController newWithFonts:(struct GL_FONTS *) &fonts];
    [textController setPx:nPixel];
    [textController setPy:nPixel];
    [textController setUniformColor:[[shaderPrograms program:SP_MAIN] uniform:U_COLOR]];
    [textController setUniformTexture:[[shaderPrograms program:SP_MAIN] uniform:U_TEXTURE]];
    [textController setTexture:fontTahoma index:FONT_TAHOMA];
    [textController setScale:scaleFactor];
    Rect r1 = {40,0,860,840};
    [[textController textObjects] addObject: [MFKGLText newWithText:@"" font:FONT_TAHOMA justify:TJ_LEFT mapCoords:false rect:r1 R:1.0f G:1.0f B:1.0f A:1.0f]];
    Rect r2 = {0,0,860,840};
    [[textController textObjects] addObject: [MFKGLText newWithText:@"" font:FONT_TAHOMA justify:TJ_LEFT mapCoords:false rect:r2 R:1.0f G:1.0f B:1.0f A:1.0f]];
    Rect r3 = {80,0,860,840};
    [[textController textObjects] addObject: [MFKGLText newWithText:@"" font:FONT_TAHOMA justify:TJ_LEFT mapCoords:false rect:r3 R:1.0f G:1.0f B:1.0f A:1.0f]];

    //The list of SCML objects
    scmlList = [[NSMutableArray alloc] init];
    [scmlList addObject:@"WonkySkeleton"];
    [scmlList addObject:@"Goblin_enemy"];
    [scmlList addObject:@"player"];
    [scmlList addObject:@"female_player"];
    [scmlList addObject:@"MegaEnemy"];
    [scmlList addObject:@"BasicTests"];
    currentSCML = 0;
    currentSCMLName = [scmlList objectAtIndex:currentSCML];

    //SCML Object initialize
    scmlObject = [SCMLObject newScmlObject];
    [scmlObject setTextures:scmlTextures];
    [scmlObject setPixelSizeX:nPixel];
    [scmlObject setPixelSizeY:nPixel];
    //Base scale is the ratio between SCML pixel size and texture pixel size. 4 in here - it is base SCML scale relatively texture, mean texture with scale 4 is 1:1 texture with use in SCML.
    [scmlObject setBaseScale:(GLfloat) [scmlTextures scaleFactor] / 4];
    [scmlObject openSCML:[[NSBundle mainBundle] pathForResource:currentSCMLName ofType:@"scml"] textureAtlas:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%@", currentSCMLName, [scmlTextures scalePrefix]] ofType:@"xml"]];
    if (![[scmlObject entities] count]) {
        [[[textController textObjects] objectAtIndex:0] setText:[NSString stringWithFormat:@"%@ %@", currentSCMLName, @"No entities"]];
    } else {
        currentEntity = 0;
        [scmlObject setCurrentEntity:[[scmlObject entities] objectAtIndex:currentEntity]];
        [scmlObject setCurrentAnimation:nil];
        currentAnimation = 0;
        if (![[[scmlObject currentEntity] animations] count]) {
            [[[textController textObjects] objectAtIndex:0] setText:[NSString stringWithFormat:@"%@\\%@ %@", currentSCMLName, [[scmlObject currentEntity] name], @"No animations"]];
        } else {
            [scmlObject setCurrentAnimation:[[[scmlObject currentEntity] animations] objectAtIndex:currentAnimation]];
            [[[textController textObjects] objectAtIndex:0] setText:[NSString stringWithFormat:@"%@\\%@\\%@", currentSCMLName, [[scmlObject currentEntity] name], [[scmlObject currentAnimation] name]]];
            [scmlObject setCurrentTime:0];
        }
    }

    flipHorizontal = false;
    nScale = 1.0f;
    basicRotate = 0.0f;
    currentTime = 0;
    [[[textController textObjects] objectAtIndex:1] setText:[NSString stringWithFormat:@"Scale %0.1f, Angle %0.0f", nScale, basicRotate]];
#ifdef SCML_BONES_DRAW
    showBones = true;
#endif
}

- (void) dealloc {
    [self tearDownGL];

    SAFE_ARC_RELEASE(scmlList);

    SAFE_ARC_RELEASE(touchesCurrent);

    SAFE_ARC_RELEASE(menu);

    SAFE_ARC_RELEASE(textController);
    for (int i = 0; i < MAX_TEXTUREFONTS; i++) free(fonts[i].font);

    SAFE_ARC_RELEASE(scmlTextures);
    SAFE_ARC_RELEASE(scmlObject);

    SAFE_ARC_RELEASE(shaderPrograms);

    free(lines);
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    SAFE_ARC_SUPER_DEALLOC();
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        [self tearDownGL];
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

- (void) loadData:(NSString *)fileName :(NSString *)fileExt :(void *)buf {
    NSString *file_path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileExt];
    NSFileHandle *file = [NSFileHandle fileHandleForReadingAtPath:file_path];
    if (file == nil) {
        NSLog(@"Cannot open file %@.%@", fileName, fileExt);
        return;
    }
    NSData *buffer = [file readDataToEndOfFile];
    [buffer getBytes: buf];
    [file closeFile];
}

- (void) setupGL {
    [EAGLContext setCurrentContext:self.context];
    
    glViewport(0, 0, screenSize.width, screenSize.height);

    NSLog(@"Start");
    
    CGFloat w = screenRatio.width / 2;
    CGFloat h = screenRatio.height / 2;
    modelViewProjectionMatrix = GLKMatrix4MakeOrtho(-w, w, h, -h, -1.0f, 1.0f);
}

- (void) tearDownGL {
    [EAGLContext setCurrentContext:self.context];

    [shaderPrograms deleteShaders];
}

- (void) update {
    [scmlObject setCurrentTime:currentTime * 1000];
    currentTime +=  self.timeSinceLastUpdate;

    switch ([[scmlObject currentAnimation] loopType]) {
        case LT_NO_LOOPING:
            [[[textController textObjects] objectAtIndex:2] setText:[NSString stringWithFormat:@"%ld/%d", (long) fmin(currentTime * 1000, [[scmlObject currentAnimation] length]), [[scmlObject currentAnimation] length]]];
            break;

        case LT_LOOPING:
        default:
            [[[textController textObjects] objectAtIndex:2] setText:[NSString stringWithFormat:@"%ld/%d", (long) fmod(currentTime * 1000, [[scmlObject currentAnimation] length]), [[scmlObject currentAnimation] length]]];
            break;
    }
}

- (void) glkView:(GLKView *) view drawInRect:(CGRect) rect {
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    glUseProgram([[shaderPrograms program:SP_MAIN] program]);
    //Non-VBO
    glBindVertexArrayOES(0);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    //Lines
    glUniformMatrix4fv([[shaderPrograms program:SP_MAIN] uniform:U_MODELVIEWPROJECTION_MATRIX], 1, 0, modelViewProjectionMatrix.m);
    glUniform1f([[shaderPrograms program:SP_MAIN] uniform:U_TEXTUREUSE], 0.0f);
    glUniform4f([[shaderPrograms program:SP_MAIN] uniform:U_COLOR], 0.0f, 0.0f, 0.0f, 1.0f);
    glUniform1i([[shaderPrograms program:SP_MAIN] uniform:U_TEXTURE], 0);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, 0, lines);
    glDrawArrays(GL_TRIANGLES, 0, 12);
    glDisableVertexAttribArray(GLKVertexAttribPosition);


    //SCML
    glUseProgram([[shaderPrograms program:SP_SCML] program]);
    for (SCMLSpriteTimelineKey *key in [scmlObject spritesToDraw]) {
        SCMLFile *file = [key file];
        glActiveTexture(GL_TEXTURE0);
        glBindTexture(GL_TEXTURE_2D, [file texture]);
        //VBO
        glBindVertexArrayOES(flipHorizontal ? [file vah] : [file va]);
        glUniformMatrix4fv([[shaderPrograms program:SP_SCML] uniform:U_MODELVIEWPROJECTION_MATRIX], 1, 0, modelViewProjectionMatrix.m);
        glUniform1f([[shaderPrograms program:SP_SCML] uniform:U_TEXTUREUSE], 1.0f);
        glUniform4f([[shaderPrograms program:SP_SCML] uniform:U_COLOR], 1.0f, 1.0f, 1.0f, [[key info] a]);
        glUniform1i([[shaderPrograms program:SP_SCML] uniform:U_TEXTURE], 0);
        if (flipHorizontal) {
            glUniform2f([[shaderPrograms program:SP_SCML] uniform:U_PIVOT], -([file w] * (1.0f - [key pivotX])) * nPixel, -([file h] * [key pivotY]) * nPixel);
            glUniform2f([[shaderPrograms program:SP_SCML] uniform:U_TRANSLATE], -[[key info] x] * nPixel, [[key info] y] * nPixel);
            glUniform1f([[shaderPrograms program:SP_SCML] uniform:U_ROTATE], [[key info] angle]);
        } else {
            glUniform2f([[shaderPrograms program:SP_SCML] uniform:U_PIVOT], -([file w] * [key pivotX]) * nPixel, -([file h] * [key pivotY]) * nPixel);
            glUniform2f([[shaderPrograms program:SP_SCML] uniform:U_TRANSLATE], [[key info] x] * nPixel, [[key info] y] * nPixel);
            glUniform1f([[shaderPrograms program:SP_SCML] uniform:U_ROTATE], -[[key info] angle]);
        }
        glUniform2f([[shaderPrograms program:SP_SCML] uniform:U_BASIC_TRANSLATE], 0.0f, 0.0f);
        glUniform2f([[shaderPrograms program:SP_SCML] uniform:U_SCALE], [[key info] scaleX], [[key info] scaleY]);
        glUniform2f([[shaderPrograms program:SP_SCML] uniform:U_BASIC_SCALE], nScale, nScale);
        glUniform1f([[shaderPrograms program:SP_SCML] uniform:U_BASIC_ROTATE], basicRotate);
        glUniform2f([[shaderPrograms program:SP_SCML] uniform:U_SCML_BASE_SCALE], [scmlObject baseScale], [scmlObject baseScale]);
        glDrawArrays(GL_TRIANGLES, 0, 6);
    }
 #ifdef SCML_BONES_DRAW
    if (showBones) {
        for (SCMLBoneTimelineKey *key in [scmlObject bonesToDraw]) {
            //VBO
            glBindVertexArrayOES([[key bone] va]);
            glUniformMatrix4fv([[shaderPrograms program:SP_SCML] uniform:U_MODELVIEWPROJECTION_MATRIX], 1, 0, modelViewProjectionMatrix.m);
            glUniform1f([[shaderPrograms program:SP_SCML] uniform:U_TEXTUREUSE], 0.0f);
            glUniform4f([[shaderPrograms program:SP_SCML] uniform:U_COLOR], 0.0f, 1.0f, 0.0f, 0.5f);
            glUniform1i([[shaderPrograms program:SP_SCML] uniform:U_TEXTURE], 0);
            glUniform2f([[shaderPrograms program:SP_SCML] uniform:U_PIVOT], 0.0f, (-([key width] / 2) * nPixel));
            if (flipHorizontal) {
                glUniform2f([[shaderPrograms program:SP_SCML] uniform:U_TRANSLATE], -[[key info] x] * nPixel, [[key info] y] * nPixel);
                glUniform1f([[shaderPrograms program:SP_SCML] uniform:U_ROTATE], [[key info] angle] + 180);
            } else {
                glUniform2f([[shaderPrograms program:SP_SCML] uniform:U_TRANSLATE], [[key info] x] * nPixel, [[key info] y] * nPixel);
                glUniform1f([[shaderPrograms program:SP_SCML] uniform:U_ROTATE], -[[key info] angle]);
            }
            glUniform2f([[shaderPrograms program:SP_SCML] uniform:U_BASIC_TRANSLATE], 0.0f, 0.0f);
            glUniform2f([[shaderPrograms program:SP_SCML] uniform:U_SCALE], [[key info] scaleX], [[key info] scaleY]);
            glUniform2f([[shaderPrograms program:SP_SCML] uniform:U_BASIC_SCALE], nScale, nScale);
            glUniform1f([[shaderPrograms program:SP_SCML] uniform:U_BASIC_ROTATE], basicRotate);
            glUniform2f([[shaderPrograms program:SP_SCML] uniform:U_SCML_BASE_SCALE], [scmlObject baseScale], [scmlObject baseScale]);
            glDrawArrays(GL_TRIANGLES, 0, 6);
        }
    }
#endif

    glUseProgram([[shaderPrograms program:SP_MAIN] program]);
    //Non-VBO
    glBindVertexArrayOES(0);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    //Get 0,0 as left-top corner
    GLKMatrix4 modelViewMatrix = modelViewProjectionMatrix;
    modelViewMatrix = GLKMatrix4Translate(modelViewMatrix, -(screenRatio.width / 2), -(screenRatio.height / 2),  0.0f);
    //Text
    glBindVertexArrayOES(0);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glUniformMatrix4fv([[shaderPrograms program:SP_MAIN] uniform:U_MODELVIEWPROJECTION_MATRIX], 1, 0, modelViewMatrix.m);
    glUniform1f([[shaderPrograms program:SP_MAIN] uniform:U_TEXTUREUSE], 1.0f);
    [textController renderTextFromArray:[textController textObjects]];
    //Menu
    glBindVertexArrayOES(0);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glActiveTexture(GL_TEXTURE0);
    [menu setMatrixProjection:modelViewMatrix];
    glUniform1f([[shaderPrograms program:SP_MAIN] uniform:U_TEXTUREUSE], 1.0f);
    glUniform4f([[shaderPrograms program:SP_MAIN] uniform:U_COLOR], 1.0f, 1.0f, 1.0f, 1.0f);
    glUniform1i([[shaderPrograms program:SP_MAIN] uniform:U_TEXTURE], 0);
    [menu renderMenus];
}

- (void) menuProbe:(MFKGameMenu*) theMenu {
    MFKGameMenuTypeEnum menuId = [theMenu type];
    switch (menuId) {
        case GMT_PREV:
        case GMT_NEXT:
            [[theMenu probe] setRender: [[[scmlObject currentEntity] animations] count] > 1];
            break;

        case GMT_PREV2:
        case GMT_NEXT2:
            [[theMenu probe] setRender: [[scmlObject entities] count] > 1];
            break;

        case GMT_BONES:
#ifndef SCML_BONES_DRAW
            [[theMenu probe] setRender: false];
#endif
            break;

        default:
            break;
    }
}

- (void) menuTouch:(MFKGameMenu*) theMenu {
    MFKGameMenuTypeEnum menuId = [theMenu type];
    switch (menuId) {
        case GMT_PREV:
            if (--currentAnimation < 0) currentAnimation = (int) [[[scmlObject currentEntity] animations] count] - 1;

        case GMT_NEXT:
            if (menuId == GMT_NEXT)
                if (++currentAnimation >= [[[scmlObject currentEntity] animations] count]) currentAnimation = 0;

            [scmlObject setCurrentAnimation:[[[scmlObject currentEntity] animations] objectAtIndex:currentAnimation]];
            [[[textController textObjects] objectAtIndex:0] setText:[NSString stringWithFormat:@"%@\\%@\\%@", currentSCMLName, [[scmlObject currentEntity] name], [[scmlObject currentAnimation] name]]];
            currentTime = 0;

            break;

        case GMT_PREV2:
            if (--currentEntity < 0) currentEntity = (int) [[scmlObject entities] count] - 1;

        case GMT_NEXT2:
            if (menuId == GMT_NEXT2)
                if (++currentEntity >= [[scmlObject entities] count]) currentEntity = 0;
            [scmlObject setCurrentEntity:[[scmlObject entities] objectAtIndex:currentEntity]];
            [scmlObject setCurrentAnimation:nil];
            currentAnimation = 0;
            if (![[[scmlObject currentEntity] animations] count]) {
                [[[textController textObjects] objectAtIndex:0] setText:[NSString stringWithFormat:@"%@\\%@ %@", currentSCMLName, [[scmlObject currentEntity] name], @"No animations"]];
            } else {
                [scmlObject setCurrentAnimation:[[[scmlObject currentEntity] animations] objectAtIndex:currentAnimation]];
                [[[textController textObjects] objectAtIndex:0] setText:[NSString stringWithFormat:@"%@\\%@\\%@", currentSCMLName, [[scmlObject currentEntity] name], [[scmlObject currentAnimation] name]]];
                [scmlObject setCurrentTime:0];
                currentTime = 0;
            }

            break;

        case GMT_PREV3:
            if (--currentSCML < 0) currentSCML = (int) [scmlList count] - 1;

        case GMT_NEXT3:
            if (menuId == GMT_NEXT3)
                if (++currentSCML >= [scmlList count]) currentSCML = 0;
            currentSCMLName = [scmlList objectAtIndex:currentSCML];

            //Remove and free all textures
            for (SCMLFolder *folder in [scmlObject folders])
                for (SCMLFile *file in [folder files])
                    [scmlTextures removeTexture:[file texture]];
            //Call releaseMain to release all objects, because the scmlObjct is main object, not duplicate.
            [scmlObject releaseMain];
            //Release scmlObject
            SAFE_ARC_RELEASE(scmlObject);
            scmlObject = nil;

            //Load another one
            scmlObject = [SCMLObject newScmlObject];
            [scmlObject setTextures:scmlTextures];
            [scmlObject setPixelSizeX:nPixel];
            [scmlObject setPixelSizeY:nPixel];
            [scmlObject setBaseScale:(GLfloat) [scmlTextures scaleFactor] / 4];
            [scmlObject openSCML:[[NSBundle mainBundle] pathForResource:currentSCMLName ofType:@"scml"] textureAtlas:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%@", currentSCMLName, [scmlTextures scalePrefix]] ofType:@"xml"]];
            if (![[scmlObject entities] count]) {
                [[[textController textObjects] objectAtIndex:0] setText:[NSString stringWithFormat:@"%@ %@", currentSCMLName, @"No entities"]];
            } else {
                currentEntity = 0;
                [scmlObject setCurrentEntity:[[scmlObject entities] objectAtIndex:currentEntity]];
                [scmlObject setCurrentAnimation:nil];
                currentAnimation = 0;
                if (![[[scmlObject currentEntity] animations] count]) {
                    [[[textController textObjects] objectAtIndex:0] setText:[NSString stringWithFormat:@"%@\\%@ %@", currentSCMLName, [[scmlObject currentEntity] name], @"No animations"]];
                } else {
                    [scmlObject setCurrentAnimation:[[[scmlObject currentEntity] animations] objectAtIndex:currentAnimation]];
                    [[[textController textObjects] objectAtIndex:0] setText:[NSString stringWithFormat:@"%@\\%@\\%@", currentSCMLName, [[scmlObject currentEntity] name], [[scmlObject currentAnimation] name]]];
                    [scmlObject setCurrentTime:0];
                }
            }
            currentTime = 0;
            break;

        case GMT_SCALEPLUS:
            nScale = lroundf(nScale * 10.0f) / 10.0f;
            if (nScale < 1.0f) nScale += 0.1f; else if (nScale < 10.0f) nScale += 0.2f;
            [[[textController textObjects] objectAtIndex:1] setText:[NSString stringWithFormat:@"Scale %0.1f, Angle %0.0f", nScale, basicRotate]];
            break;

        case GMT_SCALEMINUS:
            nScale = lroundf(nScale * 10.0f) / 10.0f;
            if (nScale >= 1.2f) nScale -= 0.2f; else if (nScale > 0.1f) nScale -= 0.1f;
            [[[textController textObjects] objectAtIndex:1] setText:[NSString stringWithFormat:@"Scale %0.1f, Angle %0.0f", nScale, basicRotate]];
            break;

        case GMT_BONES:
#ifdef SCML_BONES_DRAW
            showBones = !showBones;
#endif
            break;

        case GMT_FLIPHOR:
            flipHorizontal = !flipHorizontal;
            break;

        case GMT_ROTATE:
            basicRotate += 5.0f;
            if (basicRotate >= 360.0f) basicRotate = 0.0f;
            [[[textController textObjects] objectAtIndex:1] setText:[NSString stringWithFormat:@"Scale %0.1f, Angle %0.0f", nScale, basicRotate]];
            break;

        default:
            break;
    }
}

- (CGPoint) recalcPoint:(CGPoint) thePoint {
    CGPoint p = thePoint;
    p.x *= nTouchXScale;
    p.y *= nTouchYScale;
    return p;
}

- (MFKTouchMulti *) findTouchMulti:(UITouch *) theTouch {
    for (MFKTouchMulti *tm in touchesCurrent)
        if ([tm touchBegin] == theTouch) return tm;
    return nil;
}

- (void) touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event {
    for (UITouch *touch in [touches allObjects]) {
        MFKTouchMulti *tm = [MFKTouchMulti newTouchMulti:touch];
        [tm setLastLocation:[touch locationInView:self.view]];
        [touchesCurrent addObject:tm];
        if ([menu touchMenu:UIMYTouchBegan :[self recalcPoint:[touch locationInView:touch.view]] screenBounds:[self.view bounds]]) {
            [tm setTouchMenu:true];
        } else {
            [tm setBeginLocation:[touch locationInView:touch.view]];
            [tm setSwipeDirection:UIMYSwipeGestureUndefined];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in [touches allObjects]) {
        MFKTouchMulti *tm = [self findTouchMulti:touch];
        [tm setLastLocation:[touch locationInView:touch.view]];
        if (tm != nil)
            [menu touchMenu:UIMYTouchMove :[self recalcPoint:[tm lastLocation]] screenBounds:[self.view bounds]];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in [touches allObjects]) {
        MFKTouchMulti *tm = [self findTouchMulti:touch];
        if (tm != nil) {
            if (![tm touchEnded]) {
                if ([tm touchMenu]) {
                    [menu touchMenu:UIMYTouchEnd :[self recalcPoint:[tm lastLocation]] screenBounds:[self.view bounds]];
                }
            }
            [touchesCurrent removeObject:tm];
            SAFE_ARC_RELEASE(tm);
        }
    }
}

@end
