shader_type canvas_item;




uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float horizon : hint_range(0.0,1.0); // The height of the horizon

uniform sampler2D noise; // add two noises. Play with these some time to get a decent result

uniform sampler2D noise2;

uniform float wave_frequency : hint_range(0.0, 100.0);

uniform float wave_magnitude : hint_range(0.0, .3);

uniform float tides_magnitude : hint_range(0.0, .3);

uniform float noise_wave : hint_range(0.0, 3.0); // add noisiness to waves

uniform float tides_speed : hint_range(0.0, 20.0);

uniform float wave_speed : hint_range(0.0, 20.0);




uniform float shine_position : hint_range(0.0, 1.0); // configure a sunshine if you want

uniform float shine_intensity : hint_range(0.0, 1.0);

uniform float shine_width : hint_range(0.0, 1.0);

uniform vec4 shine_color : source_color;




uniform vec4 water_color : source_color;




void fragment() {

  vec2 noise_uv = vec2(SCREEN_UV.x + TIME * 0.025, SCREEN_UV.y);

  float noise_val = texture(noise, noise_uv).r * texture(noise2, SCREEN_UV).r + 0.2;




  float wave = horizon;

  wave += sin(UV.x * wave_frequency + TIME * wave_speed) * wave_magnitude;

  wave += sin(TIME * tides_speed) * tides_magnitude;

  wave -= texture(noise2, SCREEN_UV).r * 0.05 * noise_wave;




  vec2 offset = vec2(0, (wave + (SCREEN_UV.y - wave)) - SCREEN_UV.y);

  offset += noise_val * 0.1 - 0.05;




  vec2 col_uv = SCREEN_UV;

  col_uv.y = col_uv.y + (offset.y * step(wave, SCREEN_UV.y));




  vec4 col = texture(SCREEN_TEXTURE, col_uv);

  col = mix(col, water_color, step(wave, SCREEN_UV.y) * 0.5);

  col = mix(col, shine_color, step(wave, SCREEN_UV.y) * step(noise_val + abs(SCREEN_UV.x - shine_position), shine_width) * shine_intensity);




 // Calculate reflection

  vec2 reflection_uv = vec2(col_uv.x, 2.0 * horizon - col_uv.y); // Reflect vertically around the horizon

  vec4 reflection_color = texture(SCREEN_TEXTURE, reflection_uv);




  // Blend reflection with water color only below horizon

  if (SCREEN_UV.y > horizon) {

    col = mix(col, reflection_color, 0.3); // Adjust blend factor as needed

  }




  COLOR = col;

}
