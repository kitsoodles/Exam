Shader "Custom/HelloShader"
{
	Properties
	{
		_Color("Color", Color) = (1, 1, 1, 1)
		_MetallicTex("Metallic (R)", 2D) = "white" {}
		_Metallic("Metallic", Range(0.0, 1.0)) = 0.0
		_myCube("Reflection Map", Cube) = "grey" {}
	}

		SubShader
	{
		Tags
		{
			"Queue" = "Geometry"
		}

		CGPROGRAM
		#pragma surface surf StandardSpecular
		sampler2D _MetallicTex;
		samplerCUBE _myCube;
		half _Metallic;
		fixed4 _Color;

		struct Input
		{
			float2 uv_MetallicTex;
			float3 worldRefl;
		};

		void surf(Input IN, inout SurfaceOutputStandardSpecular o)
		{
			o.Albedo = _Color.rgb;
			o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).r;
			o.Emission = texCUBE(_myCube, IN.worldRefl).rgb;
			o.Specular = _Metallic;
		}
			ENDCG
	}
}
