// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/DepthGrayscale" {
	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
	}
	
	SubShader{
	Tags { "RenderType" = "Opaque" }

	Pass{
	CGPROGRAM
	#pragma vertex vert
	#pragma fragment frag
	#include "UnityCG.cginc"

	sampler2D _CameraDepthTexture;

	struct v2f {
	   float4 pos : SV_POSITION;
	   float4 scrPos:TEXCOORD1;
	   
	};

	//Vertex Shader
	v2f vert(appdata_base v) {
		v2f o;
		o.pos = UnityObjectToClipPos(v.vertex);
		o.scrPos = ComputeScreenPos(o.pos);
		//for some reason, the y position of the depth texture comes out inverted
		o.scrPos.y = o.scrPos.y;
		
		return o;
	}
	sampler2D _MainTex;
	//Fragment Shader
	half4 frag(v2f i) : COLOR{
	   float depthValue = Linear01Depth(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.scrPos)).r);
		//fixed4 col = tex2D(_MainTex, i.rg);
	   half4 depth;
	  // half4 col = tex2D(_MainTex, i.uv);
	   depth.r = 1-depthValue;
	   depth.g = 1-depthValue;
	   depth.b = 1-depthValue;

	   depth.a = 1;
	   half4 col = tex2D(_MainTex, i.scrPos);
	    col =(col + tex2D(_MainTex, i.scrPos+0.01))/2;

	   return col;
	}
	ENDCG
	}
	}
		FallBack "Diffuse"
}