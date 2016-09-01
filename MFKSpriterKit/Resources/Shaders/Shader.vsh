//
//  Shader.vsh
//  MFKSpriterKit
//
//  Created by mefik on 03.11.14.
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

void main() {
    v_texture = a_texture;
    v_textureUse = u_textureUse;
    v_color = u_color;
    
    gl_Position = u_projectionMatrix * vec4(a_position, 0.0, 1.0);
}
