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
  
  float4x4 closestTwoColors (float4 c) {
  	// initial black
  	float diffOne = c.r + c.g + c.b;
  	float4 colorOne = float4(0.0, 0.0, 0.0, 0.0);
  	
  	// initial white 
  	float diffTwo = 1.0 - c.r + 1.0 - c.g + 1.0 - c.b;
  	float4 colorTwo = float4(1.0, 1.0, 1.0, 0.0);
  	
  	// fun time orange
  	float temp = sqrt(pow(246.0/255.0 - c.r,2) + pow(117.0/255.0 - c.g,2) + pow(18.0/255.0 - c.b,2));
  	float4 colorTemp = float4(246.0/255.0, 117.0/255.0 , 18.0/255.0, 0.0);
  	
  	if(diffOne > temp)
  	{
  		colorOne = colorTemp;
  		diffOne = temp;
  	}
  	else if (diffTwo > temp)
  	{
  		colorTwo = colorTemp;
  		diffTwo = temp;
  	}
  	
  	// unique deals low prices green
  	temp = sqrt(pow(26.0/255.0 - c.r,2) + pow(246.0/255.0 - c.g,2) + pow(18.0/255.0 - c.b,2));
  	colorTemp = float4(26.0/255.0, 246.0/255.0 , 18.0/255.0, 0.0);
  	
  	if(diffOne > temp)
  	{
  		colorOne = colorTemp;
  		diffOne = temp;
  	}
  	else if (diffTwo > temp)
  	{
  		colorTwo = colorTemp;
  		diffTwo = temp;
  	}
  		
  	// german rural misery chic grey
  	//temp = sqrt(pow(84.0/255.0 - c.r,2) + pow(84.0/255.0 - c.g,2) + pow(84.0/255.0 - c.b,2));
  	//colorTemp = float4(84.0/255.0, 84.0/255.0 , 84.0/255.0, 0.0);
  		
  	//if(diffOne > temp)
  	//{
  	//	colorOne = colorTemp;
  	//	diffOne = temp;
  	//}
  	//else if (diffTwo > temp)
  	//{
  	//	colorTwo = colorTemp;
  	//	diffTwo = temp;
  	//}
  	
  	// 'the struggle' blue
  	temp = sqrt(pow(26.0/255.0 - c.r,2) + pow(159.0/255.0 - c.g,2) + pow(238.0/255.0 - c.b,2));
  	colorTemp = float4(26.0/255.0, 159.0/255.0 , 238.0/255.0, 0.0);
  		
  	if(diffOne > temp)
  	{
  		colorOne = colorTemp;
  		diffOne = temp;
  	}
  	else if (diffTwo > temp)
  	{
  		colorTwo = colorTemp;
  		diffTwo = temp;
  	}
  	
  	// fuck you red
  	temp = sqrt(pow(237.0/255.0 - c.r,2) + pow(24.0/255.0 - c.g,2) + pow(17.0/255.0 - c.b,2));
  	colorTemp = float4(237.0/255.0, 24.0/255.0 , 17.0/255.0, 0.0);
  		
  	if(diffOne > temp)
  	{
  		colorOne = colorTemp;
  		diffOne = temp;
  	}
  	else if (diffTwo > temp)
  	{
  		colorTwo = colorTemp;
  		diffTwo = temp;
  	}
  		
  	if(diffOne > diffTwo)
  		return float4x4(colorOne, colorTwo, diffOne,0,0,0,diffTwo,0,0,0);
 	return float4x4(colorTwo, colorOne, diffTwo,0,0,0,diffOne,0,0,0);
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
  float4x4 closeColors = closestTwoColors(orgCol);
  
  float gap = sqrt(pow(closeColors[0].r - closeColors[1].r,2) + pow(closeColors[0].g - closeColors[1].g,2) + pow(closeColors[0].b - closeColors[1].b,2));
  
  float ditherGap = gap*dither;
 
  if(ditherGap > closeColors[2][0]) 
  	return closeColors[1];
  return closeColors[0];
  
  
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
