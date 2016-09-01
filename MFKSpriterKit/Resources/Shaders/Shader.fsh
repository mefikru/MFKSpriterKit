//
//  Shader.fsh
//  MFKSpriterKit
//
//  Created by mefik on 03.11.14.
//  Copyright (c) 2014 mefik-studio. All rights reserved.
//

uniform sampler2D u_texture;

varying lowp vec2 v_texture;
varying lowp float v_textureUse;
varying lowp vec4 v_color;

void main() {
    lowp vec4 textureColor;
    textureColor = mix(vec4(1.0, 1.0, 1.0, 1.0), texture2D(u_texture, v_texture), v_textureUse) * v_color;
    gl_FragColor = textureColor;
}
