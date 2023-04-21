Shader "Custom/LectureVertex"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Glossiness("Smoothness", Range(0,1)) = 0.5
        _Metallic("Metallic", Range(0,1)) = 0.0
        _DisplacementMap("DisplacementMap", 2D) = "black" {}
        _DisplacementStrength("DisplacementStrength", Range(0,1)) = 0.5
    }
        SubShader
        {
            Pass
            {

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog
            #include "UnityCG.cginc"

            struct Input {
                float2 uv_MainTex;
            };

            struct appdata {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f {
                float2 uv :TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            half _Glossiness;
            half _Metallic;
            half _DisplacementStrength;
            fixed4 _Color;
            sampler2D _MainTex;
            sampler2D _DisplacementMap;
            float4 _MainTex_ST;
            float4 _DisplacementMap_ST;

            

            UNITY_INSTANCING_BUFFER_START(Props)
                // put more per-instance properties here
            UNITY_INSTANCING_BUFFER_END(Props)

            v2f vert(appdata v) {
                v2f o;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o, o.vertex);
                float displacement = tex2Dlod(_DisplacementMap, float4(o.uv, 0, 0)).r;
                //float displacement = 0;
                float4 temp = float4(v.vertex.x, v.vertex.y, v.vertex.z, 1.0);
                temp.xyz += displacement * v.normal * _DisplacementStrength;
                o.vertex = UnityObjectToClipPos(temp);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target{
            fixed4 col = tex2D(_MainTex, i.uv);
            UNITY_APPLY_FOG(i.fogCoord, col)
            return col;

            }
            ENDCG
            }
        }
}
