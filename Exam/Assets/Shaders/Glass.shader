Shader "Custom/Glass" 
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _ScaleUV("Scale", Range(1,20)) = 1
    }

    SubShader
    {
        Tags{ "Queue" = "Transparent" }
        GrabPass{}
        Pass
        {
            CGPROGRAM
            #pragma exclude_renderers d3d11

            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float4 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 uvgrab : TEXCOORD1;
                float4 vertex : SV_POSITION;
            };

            sampler2D _GrabTexture;
            float4 _GrabTexture_TexelSize;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _ScaleUV;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);

                # if UNITY_UV_STARTS_AT_TOP
                float scale = -1.0;
                # else
                float scale = 1.0;
                # endif

                o.uvgrab.xy = (float2(o.vertex.x, o.vertex.y * scale) + o.vertex.w) * 0.5;
                o.uvgrab.zw = o.vertex.zw;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                i.uvgrab.xy = i.uvgrab.z + i.uvgrab.xy;
                fixed4 col = tex2D(_GrabTexture, i.uvgrab.xy / i.uvgrab.w);
                fixed4 tint = tex2D(_MainTex, i.uv * _MainTex_ST.xy + _MainTex_ST.zw);
                col *= tint;
                return col;
            }
            ENDCG
        }
    }

    FallBack "Diffuse"
}
