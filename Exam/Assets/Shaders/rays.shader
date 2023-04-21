Shader "Custom/rays" {
    Properties{
        _MainTex("Input Texture", 2D) = "white" {}
        _SunScreenPos("Sun Screen Position", Vector) = (0.5, 0.5, 0.0, 0.0)
        _Density("Density", Range(0.0, 5.0)) = 1.0
        _Weight("Weight", Range(0.0, 5.0)) = 1.0
        _Decay("Decay", Range(0.0, 1.0)) = 1.0
        _Exposure("Exposure", Range(0.0, 5.0)) = 1.0
        _NumSamples("Number of Samples", Range(1, 200)) = 100
    }
        SubShader{
            Pass {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"

                uniform sampler2D _MainTex;
                uniform float3 _SunScreenPos;
                uniform float _Density;
                uniform float _Weight;
                uniform float _Decay;
                uniform float _Exposure;
                uniform int _NumSamples;

                struct appdata {
                    float4 vertex : POSITION;
                    float2 uv : TEXCOORD0;
                };

                struct v2f {
                    float2 uv : TEXCOORD0;
                    float4 vertex : SV_POSITION;
                };

                v2f vert(appdata v) {
                    v2f o;
                    o.vertex = UnityObjectToClipPos(v.vertex);
                    o.uv = v.uv;
                    return o;
                }

                float4 frag(v2f i) : SV_Target {
                    float2 texCoords = i.uv;
                    float2 delta = (texCoords - _SunScreenPos.xy) * _Density / _NumSamples;
                    float4 colour = tex2D(_MainTex, texCoords);
                    float illuminationDecay = 1.0;
                    for (int j = 0; j < _NumSamples; j++) {
                        texCoords -= delta;
                        float4 sampleColour = tex2D(_MainTex, texCoords);
                        sampleColour *= illuminationDecay * _Weight;
                        colour += sampleColour;
                        illuminationDecay *= _Decay;
                    }
                    colour *= _Exposure;
                    return colour;
                }
                ENDCG
            }
        }
            FallBack "Diffuse"
}
