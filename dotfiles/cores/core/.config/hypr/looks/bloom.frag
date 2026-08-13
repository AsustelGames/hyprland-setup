#version 300 es
precision mediump float;

in vec2 v_texcoord;
layout(location = 0) out vec4 fragColor;

uniform sampler2D tex;

// ── Bloom settings ──────────────────────────────
const float THRESHOLD = 0.70;  // brightness needed to bloom
const float INTENSITY = 1.22;  // overall glow strength
const float RADIUS    = 2.0;   // glow radius
const float EXPOSURE  = 1.0;

// Approximate screen resolution.
// Increase/decrease if the glow is too tight/wide.
const vec2 PIXEL = vec2(1.0 / 1920.0, 1.0 / 1080.0);

vec3 sampleBloom(vec2 uv) {
    vec3 result = vec3(0.0);

    // 13-tap soft kernel
    result += texture(tex, uv + vec2(-2.0, -2.0) * PIXEL * RADIUS).rgb * 0.05;
    result += texture(tex, uv + vec2( 0.0, -2.0) * PIXEL * RADIUS).rgb * 0.08;
    result += texture(tex, uv + vec2( 2.0, -2.0) * PIXEL * RADIUS).rgb * 0.05;

    result += texture(tex, uv + vec2(-2.0,  0.0) * PIXEL * RADIUS).rgb * 0.08;
    result += texture(tex, uv).rgb * 0.12;
    result += texture(tex, uv + vec2( 2.0,  0.0) * PIXEL * RADIUS).rgb * 0.08;

    result += texture(tex, uv + vec2(-2.0,  2.0) * PIXEL * RADIUS).rgb * 0.05;
    result += texture(tex, uv + vec2( 0.0,  2.0) * PIXEL * RADIUS).rgb * 0.08;
    result += texture(tex, uv + vec2( 2.0,  2.0) * PIXEL * RADIUS).rgb * 0.05;

    // Wider secondary samples
    result += texture(tex, uv + vec2(-4.0,  0.0) * PIXEL * RADIUS).rgb * 0.04;
    result += texture(tex, uv + vec2( 4.0,  0.0) * PIXEL * RADIUS).rgb * 0.04;
    result += texture(tex, uv + vec2( 0.0, -4.0) * PIXEL * RADIUS).rgb * 0.04;
    result += texture(tex, uv + vec2( 0.0,  4.0) * PIXEL * RADIUS).rgb * 0.04;

    return result;
}

void main() {
    vec4 original = texture(tex, v_texcoord);

    // Extract bright areas.
    float brightness = max(
        max(original.r, original.g),
        original.b
    );

    float bloomMask = smoothstep(
        THRESHOLD,
        1.0,
        brightness
    );

    // Sample surrounding light.
    vec3 glow = sampleBloom(v_texcoord);

    // Prevent dark areas from contributing too much.
    glow *= bloomMask;

    // Soft exposure curve.
    glow = 1.0 - exp(-glow * EXPOSURE);

    vec3 color = original.rgb + glow * INTENSITY;

    fragColor = vec4(color, original.a);
}
