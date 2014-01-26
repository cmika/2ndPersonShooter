Shader "Custom/nextDithering" {
	Properties {
 _MainTex ("", 2D) = "white" {}
}
 
SubShader {
 
//ZTest Always Cull Off ZWrite Off Fog { Mode Off } //Rendering settings
 
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
  	float Max1 = max(max(c.r, c.g), c.b);
  	float Min1 = min(min(c.r, c.g), c.b);
  	float D1 = Max1 - Min1;
  	float H1;
  	float luma1 = c.r*0.299 + c.g*0.587 + c.b*0.114;
  	if(D1=0)
  		H1 = 0;
  	else if(c.r = Max1)
  		H1 = (c.g-c.b)/D1;
  	else if(c.g = Max1)
  		H1 = 2+(c.b-c.r)/D1;
  	else
  		H1 = 4+(c.r-c.g)/D1;
  		
  	float S1;
  	if(Max1 == 0)
  		S1 = 0;
  	else
  		S1 = D1/Max1;
  	float H1x = cos(1.04719755*H1)*S1*luma1;
  	float H1y = sin(1.04719755*H1)*S1*luma1;
  	
  	float4 dick = float4(20.0/255.0, 38.0/255.0, 20.0/255.0, 0.0);
  	
  	float Max2 = max(max(dick.r, dick.g), dick.b);
  	float Min2 = min(min(dick.r, dick.g), dick.b);
  	float D2 = Max2 - Min2;
  	float H2;
  	float luma2 = dick.r*0.299 + dick.g*0.587 + dick.b*0.114;
  	if(D2=0)
  		H2 = 0;
  	else if(dick.r == Max2)
  		H2 = (dick.g-dick.b)/D2;
  	else if(dick.g == Max2)
  		H2 = 2+(dick.b-dick.r)/D2;
  	else
  		H2 = 4+(dick.r-dick.g)/D2;
  		
  	float S2;
  	if(Max2 == 0)
  		S2 = 0;
  	else
  		S2 = D2/Max2;
  	float H2x = cos(1.04719755*H2)*S2*luma2;
  	float H2y = sin(1.04719755*H1)*S2*luma2;
  	
  	float diffOne = sqrt(pow(H2x-H1x,2) + pow(H2y-H1y,2) + pow(luma2 - luma1,2));
    
  	float4 colorOne = dick;
  	
  	float4 dickColor = float4(255.0/255.0,250.0/255.0,240.0/255.0,0.0); 
  	
  	Max2 = max(max(dickColor.r, dickColor.g), dickColor.b);
  	Min2 = min(min(dickColor.r, dickColor.g), dickColor.b);
  	D2 = Max2 - Min2;
  	H2;
  	luma2 = dickColor.r*0.299 + dickColor.g*0.587 + dickColor.b*0.114;
  	if(D2=0)
  		H2 = 0;
  	else if(dickColor.r == Max2)
  		H2 = (dickColor.g-dickColor.b)/D2;
  	else if(dickColor.g == Max2)
  		H2 = 2+(dickColor.b-dickColor.r)/D2;
  	else
  		H2 = 4+(dickColor.r-dickColor.g)/D2;
  		
  	if(Max2 == 0)
  		S2 = 0;
  	else
  		S2 = D2/Max2;
  	H2x = cos(1.04719755*H2)*S2*luma2;
  	H2y = sin(1.04719755*H1)*S2*luma2;
  	
  	float diffTwo = sqrt(pow(H2x-H1x,2) + pow(H2y-H1y,2) + pow(luma2 - luma1,2)); 
  	float4 colorTwo = dickColor;
  	
  	// fun time orange
  	float4 colorTemp = float4(246.0/255.0, 117.0/255.0 , 18.0/255.0, 0.0);
  	
  	Max2 = max(max(colorTemp.r, colorTemp.g), colorTemp.b);
  	Min2 = min(min(colorTemp.r, colorTemp.g), colorTemp.b);
  	D2 = Max2 - Min2;
  	luma2 = colorTemp.r*0.299 + colorTemp.g*0.587 + colorTemp.b*0.114;
  	if(D2=0)
  		H2 = 0;
  	else if(1 == Max2)
  		H2 = (1-1)/D2;
  	else if(1 == Max2)
  		H2 = 2+(1-1)/D2;
  	else
  		H2 = 4+(1-1)/D2;
  		
  	if(Max2 == 0)
  		S2 = 0;
  	else
  		S2 = D2/Max2;
  	H2x = cos(1.04719755*H2)*S2*luma2;
  	H2y = sin(1.04719755*H1)*S2*luma2;
  	
  	float temp = sqrt(pow(H2x-H1x,2) + pow(H2y-H1y,2) + pow(luma2 - luma1,2));
  	
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
  	colorTemp = float4(6.0/255.0, 174.0/255.0 , 231.0/255.0, 0.0);
  	Max2 = max(max(colorTemp.r, colorTemp.g), colorTemp.b);
  	Min2 = min(min(colorTemp.r, colorTemp.g), colorTemp.b);
  	D2 = Max2 - Min2;
  	luma2 = colorTemp.r*0.299 + colorTemp.g*0.587 + colorTemp.b*0.114;
  	if(D2=0)
  		H2 = 0;
  	else if(1 == Max2)
  		H2 = (1-1)/D2;
  	else if(1 == Max2)
  		H2 = 2+(1-1)/D2;
  	else
  		H2 = 4+(1-1)/D2;
  		
  	if(Max2 == 0)
  		S2 = 0;
  	else
  		S2 = D2/Max2;
  	H2x = cos(1.04719755*H2)*S2*luma2;
  	H2y = sin(1.04719755*H1)*S2*luma2;
  	
  	temp = sqrt(pow(H2x-H1x,2) + pow(H2y-H1y,2) + pow(luma2 - luma1,2));
  	
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
  	colorTemp = float4(.5, .5, .5, 0.0);
  	Max2 = max(max(colorTemp.r, colorTemp.g), colorTemp.b);
  	Min2 = min(min(colorTemp.r, colorTemp.g), colorTemp.b);
  	D2 = Max2 - Min2;
  	luma2 = colorTemp.r*0.299 + colorTemp.g*0.587 + colorTemp.b*0.114;
  	if(D2=0)
  		H2 = 0;
  	else if(1 == Max2)
  		H2 = (1-1)/D2;
  	else if(1 == Max2)
  		H2 = 2+(1-1)/D2;
  	else
  		H2 = 4+(1-1)/D2;
  		
  	if(Max2 == 0)
  		S2 = 0;
  	else
  		S2 = D2/Max2;
  	H2x = cos(1.04719755*H2)*S2*luma2;
  	H2y = sin(1.04719755*H1)*S2*luma2;
  	
  	temp = sqrt(pow(H2x-H1x,2) + pow(H2y-H1y,2) + pow(luma2 - luma1,2));
  	
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
  	
  	// 'the struggle' blue
  	
  	colorTemp = float4(26.0/255.0, 159.0/255.0 , 238.0/255.0, 0.0);
  	Max2 = max(max(colorTemp.r, colorTemp.g), colorTemp.b);
  	Min2 = min(min(colorTemp.r, colorTemp.g), colorTemp.b);
  	D2 = Max2 - Min2;
  	luma2 = colorTemp.r*0.299 + colorTemp.g*0.587 + colorTemp.b*0.114;
  	if(D2=0)
  		H2 = 0;
  	else if(1 == Max2)
  		H2 = (1-1)/D2;
  	else if(1 == Max2)
  		H2 = 2+(1-1)/D2;
  	else
  		H2 = 4+(1-1)/D2;
  		
  	if(Max2 == 0)
  		S2 = 0;
  	else
  		S2 = D2/Max2;
  	H2x = cos(1.04719755*H2)*S2*luma2;
  	H2y = sin(1.04719755*H1)*S2*luma2;
  	
  	temp = sqrt(pow(H2x-H1x,2) + pow(H2y-H1y,2) + pow(luma2 - luma1,2));
  		
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
  	//colorTemp = float4(237.0/255.0, 24.0/255.0 , 17.0/255.0, 0.0);
  	//Max2 = max(max(colorTemp.r, colorTemp.g), colorTemp.b);
  	//Min2 = min(min(colorTemp.r, colorTemp.g), colorTemp.b);
  	//D2 = Max2 - Min2;
  	//luma2 = colorTemp.r*0.299 + colorTemp.g*0.587 + colorTemp.b*0.114;
  	//if(D2=0)
  	//	H2 = 0;
  	//else if(1 == Max2)
  	//	H2 = (1-1)/D2;
  	//else if(1 == Max2)
  	//	H2 = 2+(1-1)/D2;
  	//else
  	//	H2 = 4+(1-1)/D2;
  		
  	//if(Max2 == 0)
  	//	S2 = 0;
  	//else
  	//	S2 = D2/Max2;
  	//H2x = cos(1.04719755*H2)*S2*luma2;
  	//H2y = sin(1.04719755*H1)*S2*luma2;
  	
  	//temp = sqrt(pow(H2x-H1x,2) + pow(H2y-H1y,2) + pow(luma2 - luma1,2));
  		
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
  		
  	if(diffOne > diffTwo)
  		return float4x4(colorOne, colorTwo, diffOne,0,0,0,diffTwo,0,0,0);
 	return float4x4(colorTwo, colorOne, diffTwo,0,0,0,diffOne,0,0,0);
  } 
    
  sampler2D _MainTex; //Reference in Pass is necessary to let us use this variable in shaders
                              
  
  //Our Fragment Shader
  fixed4 frag (v2f i, float4 sp : WPOS) : COLOR {
  	fixed4 orgCol = tex2D(_MainTex, i.uv); //Get the orginal rendered color 
  	
  	float4x4 ditherM = float4x4( 0.0, 5.0, 2.0,0.0,
                              3.0, 8.0,7.0, 0.0,
                               6.0,1.0, 4.0,0.0,
                              0.0, 0.0,0.0, 0.0);
  	
  //lookup the dither thingy
  float4 row;
  int rowi = fmod(sp.x, 3);
  int col = fmod(sp.y, 3);
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
  
  float Max1 = max(max(closeColors[0].r, closeColors[0].g), closeColors[0].b);
  	float Min1 = min(min(closeColors[0].r, closeColors[0].g), closeColors[0].b);
  	float D1 = Max1 - Min1;
  	float H1;
  	float luma1 = closeColors[0].r*0.299 + closeColors[0].g*0.587 + closeColors[0].b*0.114;
  	if(D1=0)
  		H1 = 0;
  	else if(closeColors[0].r = Max1)
  		H1 = (closeColors[0].g-closeColors[0].b)/D1;
  	else if(closeColors[0].g = Max1)
  		H1 = 2+(closeColors[0].b-closeColors[0].r)/D1;
  	else
  		H1 = 4+(closeColors[0].r-closeColors[0].g)/D1;
  		
  	float S1;
  	if(Max1 == 0)
  		S1 = 0;
  	else
  		S1 = D1/Max1;
  	float H1x = cos(1.04719755*H1)*S1*luma1;
  	float H1y = sin(1.04719755*H1)*S1*luma1;
  	
  	float Max2 = max(max(closeColors[1].r, closeColors[1].g), closeColors[1].b);
  	float Min2 = min(min(closeColors[1].r, closeColors[1].g), closeColors[1].b);
  	float D2 = Max2 - Min2;
  	float H2;
  	float luma2 = closeColors[1]*0.299 + closeColors[1]*0.587 + closeColors[1]*0.114;
  	if(D2=0)
  		H2 = 0;
  	else if(closeColors[1].r == Max2)
  		H2 = (closeColors[1].g-closeColors[1].b)/D2;
  	else if(closeColors[1].g == Max2)
  		H2 = 2+(closeColors[1].b-closeColors[1].r)/D2;
  	else
  		H2 = 4+(closeColors[1].r-closeColors[1].g)/D2;
  		
  	float S2;
  	if(Max2 == 0)
  		S2 = 0;
  	else
  		S2 = D2/Max2;
  	float H2x = cos(1.04719755*H2)*S2*luma2;
  	float H2y = sin(1.04719755*H1)*S2*luma2;
  	
  	float gap = sqrt(pow(H2x-H1x,2) + pow(H2y-H1y,2) + pow(luma2 - luma1,2));
  
  
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
