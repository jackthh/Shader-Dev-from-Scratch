Shader "JackShader/TestingVerticalFog"
{

    Properties
    {
        _BaseColor ("Base Color", Color) = (1,1,1,1)
        _BaseTexture ("Base Texture", 2D) = "white" {}
        _FogColor ("Fog Color", Color) = (1,1,1,1)
        _FogStartPos ("Fog Start Pos", float) = 0
        _FogEndPos ("Fog Ending Pos", float) = 0
    }

    SubShader
    {
        CGPROGRAM
			#pragma surface surf Lambert

			float4 _BaseColor;
			sampler2D _BaseTexture;
			float4 _FogColor;
			float _FogStartPos;
			float _FogEndPos;

		
			struct Input {
				float2 uv_BaseTexture;
				float3 worldPos;
			};

		
			void surf (Input IN, inout SurfaceOutput o){
				float4 color = tex2D (_BaseTexture, IN.uv_BaseTexture) * _BaseColor;
				
				[branch] if( IN.worldPos.y > _FogStartPos || _FogStartPos == _FogEndPos)
				{
					o.Albedo = color.rgb;
				}
				else
				{
					float lerpPos = (IN.worldPos.y - _FogStartPos) / (_FogEndPos - _FogStartPos);

					float4 blendedColor = lerp(color, _FogColor, lerpPos);
					
					o.Albedo = blendedColor;	
				}
			}
		
		ENDCG
    }

    FallBack "Diffuse"
}