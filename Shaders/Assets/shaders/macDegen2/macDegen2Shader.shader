Shader "Custom/macDegen2Shader"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_macDegTex("Texture", 2D) = "black" {}
	}
		SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			sampler2D _MainTex;
			sampler2D _macDegTex;

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				fixed4 col1 = tex2D(_macDegTex, i.uv);
				
				float displacement = (1-col1.r)*0.2;
				half4 imgL = col;
				half4 imgR = col;
				half4 imgT = col;
				half4 imgB = col;
				half4 imgL1 = col;
				half4 imgR1 = col;
				half4 imgT1 = col;
				half4 imgB1 = col;

				if (col1.r <1)
				{
					 imgL = tex2D(_MainTex, i.uv.xy + float2(displacement + 0.05, 0));

					 imgR = tex2D(_MainTex, i.uv.xy + float2(-displacement + 0.1, 0));
					 imgT = tex2D(_MainTex, i.uv.xy + float2(0, displacement + 0.07));
					 imgB = tex2D(_MainTex, i.uv.xy + float2(0, -displacement - 0.01));

					 imgL1 = tex2D(_MainTex, i.uv.xy + float2(displacement * 2 + 0.05, 0));
					 imgR1 = tex2D(_MainTex, i.uv.xy + float2(-displacement * 2 + 0.01, 0));
					 imgT1 = tex2D(_MainTex, i.uv.xy + float2(0, displacement * 2));
					 imgB1 = tex2D(_MainTex, i.uv.xy + float2(0, -displacement * 2));
				}



				return (col+imgL+imgR +imgT+imgB +imgL1+imgR1+imgT1+imgB1)/9;
			}
			ENDCG
		}
	}
}