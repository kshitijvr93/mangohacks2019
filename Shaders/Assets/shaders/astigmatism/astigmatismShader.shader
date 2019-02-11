Shader "Custom/astigmatismShader"
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
		_NoiseTex("Noise Texture", 2D) = "red" {}

	}

		SubShader
	{
		Tags { "RenderType" = "Opaque" }

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _CameraDepthTexture;

			struct v2f
			{
			   float4 pos : SV_POSITION;
			   float4 scrPos:TEXCOORD0;// can use 1 actually 1 was used....

			};

			//Vertex Shader
			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.scrPos = ComputeScreenPos(o.pos);
				//for some reason, the y position of the depth texture comes out inverted
				//o.scrPos.y = o.scrPos.y;

				return o;
			}
			sampler2D _MainTex;
			sampler2D _NoiseTex;
			//Fragment Shader

			half4 frag(v2f i) : COLOR
			{
				// farther the object value closer to 1
				   
			//depthValue = 1 - depthValue;


			half4 img = tex2D(_MainTex, i.scrPos.xy);
			float a = img.a;

			half4 noise = tex2D(_NoiseTex, i.scrPos.xy);

			float displacement = 0.008;
			


			half4 imgL = tex2D(_MainTex, i.scrPos.xy + float2(displacement, 0));
			half4 imgR = tex2D(_MainTex, i.scrPos.xy + float2(-displacement, 0));
			half4 imgT = tex2D(_MainTex, i.scrPos.xy + float2(0,displacement));
			half4 imgB = tex2D(_MainTex, i.scrPos.xy + float2(0,-displacement));

			half4 imgL1 = tex2D(_MainTex, i.scrPos.xy + float2(displacement * 2, 0));
			half4 imgR1 = tex2D(_MainTex, i.scrPos.xy + float2(-displacement * 2, 0));
			half4 imgT1 = tex2D(_MainTex, i.scrPos.xy + float2(0, displacement * 2));
			half4 imgB1 = tex2D(_MainTex, i.scrPos.xy + float2(0, -displacement * 2));

			half4 toPass;
			float noiseFactor = 0;
			float imgFactor = 1;
			float srFactor = 0;
			float depthThresh = 1;
			
			/*else if (depthValue < 11)
			{
				noiseFactor = 2*(11-depthValue);
				imgFactor = 2*(11 - depthValue);
				srFactor = 1 * (11 - depthValue);
				//return 1 - img;
			}
			else if (depthValue < 15)
			{
				noiseFactor = 3 * (15 - depthValue);
				imgFactor = 2 * (15 - depthValue);
				srFactor = 2 * (15 - depthValue);
				//return 1 - img;
			}*/
			
				noiseFactor = 1 ;
				imgFactor = 3 ;
				
				float vertFactor = 2;
				float horizontalFactor = 5;
			toPass = (imgFactor*img + noiseFactor * noise + horizontalFactor * (imgL + imgR) +vertFactor*( imgT + imgB) + srFactor * (imgL1 + imgR1 + imgT1 + imgB1)) / (10+imgFactor + noiseFactor + 4 * srFactor + (horizontalFactor+vertFactor));
			return toPass;




		}
	 ENDCG
	}
	}
		FallBack "Diffuse"
}
