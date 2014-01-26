Shader "Custom/nextDithering" {
	Properties {
 _MainTex ("", 2D) = "white" {}
}
 
SubShader {
 
ZTest Always Cull Off ZWrite Off Fog { Mode Off } //Rendering settings
 
 Pass{
  CGPROGRAM
  #pragma vertex vert
  #pragma fragment frag
  #pragma target 3.0
  #include "UnityCG.cginc" 
  //we include "UnityCG.cginc" to use the appdata_img struct
    
  struct v2f {
   float4 pos : POSITION;
   half2 uv : TEXCOORD0;
  };
   
  //Our Vertex Shader 
  v2f vert (appdata_img v){
   v2f o;
   o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
   o.uv = MultiplyUV (UNITY_MATRIX_TEXTURE0, v.texcoord.xy);
   return o; 
  }
    
  sampler2D _MainTex; //Reference in Pass is necessary to let us use this variable in shaders
  float4x4 ditherfuck = float4x4( 1.0, 9.0, 3.0,11.0,
                              13.0, 5.0,15.0, 7.0,
                               4.0,12.0, 2.0,10.0,
                              16.0, 8.0,14.0, 6.0);
                              
  
  //Our Fragment Shader
  fixed4 frag (v2f i, float4 sp : WPOS) : COLOR {
  	fixed4 orgCol = tex2D(_MainTex, i.uv); //Get the orginal rendered color 
  	
  	float4x4 ditherM = float4x4( 1.0, 9.0, 3.0,11.0,
                              13.0, 5.0,15.0, 7.0,
                               4.0,12.0, 2.0,10.0,
                              16.0, 8.0,14.0, 6.0);
  	
  //lookup the dither thingy
  float4 row;
  int rowi = fmod(sp.x, 4);
  int col = fmod(sp.y, 4);
  float dither;
  if(rowi == 0) {
  	row = ditherM[0];
  } else if(rowi == 1) {
  	row = ditherM[1];
  } else if(rowi == 2) {
  	row = ditherM[2];
  } else {
  	row = ditherM[3];
  }
  	
  if(col == 0) {
  	dither = row[0];
  } else if(col == 1) {
  	dither = row[1];
  } else if(col == 2) {
  	dither = row[2];
  } else {
  	dither = row[3];
  } 
  
  // get the greyscale color
  float grey = (orgCol.r + orgCol.g + orgCol.b)/3.0;
  // adjust dither to be between colors
  dither /= 16;
  if((grey + dither)/2 > .5)
  	return fixed4(1.0, 1.0, 1.0, 0.0);
  return fixed4(0.0, 0.0, 0.0, 0.0);
  }
  
  ENDCG
 }
} 
 FallBack "Diffuse"
}
