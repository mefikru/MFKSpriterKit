//
//  SCML.vsh
//  MFKSpriterKit
//
//  Created by mefik on 03.12.15.
//  Copyright (c) 2014 mefik-studio. All rights reserved.
//

attribute vec2 a_position;
attribute vec2 a_texture;

varying vec2 v_texture;
varying float v_textureUse;
varying vec4 v_color;

uniform mat4 u_projectionMatrix;
uniform sampler2D u_texture;
uniform float u_textureUse;
uniform vec4 u_color;
uniform vec2 u_pivot;
uniform vec2 u_translate;
uniform vec2 u_basicTranslate;
uniform float u_rotate;
uniform float u_basicRotate;
uniform vec2 u_scale;
uniform vec2 u_basicScale;
uniform vec2 u_scmlBaseScale;

void main() {
    v_texture = a_texture;
    v_textureUse = u_textureUse;
    v_color = u_color;

    //Pivot
    gl_Position = vec4(a_position, 0.0, 1.0);
    gl_Position = vec4(gl_Position.x + u_pivot.x,
                       gl_Position.y + u_pivot.y,
                       gl_Position.z,
                       gl_Position.w);

    //Scale
    highp mat4 scaleMatrix = mat4(u_scale.x * u_basicScale.x, 0.0, 0.0, 0.0,
                                  0.0, u_scale.y * u_basicScale.y, 0.0, 0.0,
                                  0.0, 0.0, 1.0, 0.0,
                                  0.0, 0.0, 0.0, 1.0);
    gl_Position *= scaleMatrix;

    //Rotate
    highp float rotate = radians(u_rotate);
    highp mat4 rotationMatrix = mat4(cos(rotate), -sin(rotate), 0.0, 0.0,
                                     sin(rotate), cos(rotate), 0.0, 0.0,
                                     0.0, 0.0, 1.0, 0.0,
                                     0.0, 0.0, 0.0, 1.0);
    gl_Position *= rotationMatrix;

    //Translation
    gl_Position = vec4(gl_Position.x + u_translate.x * u_basicScale.x * u_scmlBaseScale.x,
                       gl_Position.y + u_translate.y * u_basicScale.y * u_scmlBaseScale.y,
                       gl_Position.z,
                       gl_Position.w);

    //Basic rotate
    rotate = radians(u_basicRotate);
    rotationMatrix = mat4(cos(rotate), -sin(rotate), 0.0, 0.0,
                          sin(rotate), cos(rotate), 0.0, 0.0,
                          0.0, 0.0, 1.0, 0.0,
                          0.0, 0.0, 0.0, 1.0);
    gl_Position *= rotationMatrix;

    //Basic translation
    gl_Position = vec4(gl_Position.x + u_basicTranslate.x,
                       gl_Position.y + u_basicTranslate.y,
                       gl_Position.z,
                       gl_Position.w);

    //Projection
    gl_Position *= u_projectionMatrix;
}
