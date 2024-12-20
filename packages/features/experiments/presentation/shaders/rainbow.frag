#version 460 core
#include <flutter/runtime_effect.glsl>

uniform vec3 iResolution;           // viewport resolution (in pixels)
uniform float iTime;                 // shader playback time (in seconds)

out vec4 fragColor;

void main() {
    vec2 fragCoord = FlutterFragCoord().xy;

    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;

    // Time varying pixel color
    vec3 col = 0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4));

    // Output to screen
    fragColor = vec4(col,1.0);
}