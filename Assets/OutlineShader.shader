Shader "Custom/OutlineShader"
{
	Properties
	{
		_Color ("Color", Color) = (1,0,0,1)
		_EdgeWidth ("EdgeWidth", Float) = .002
		_EdgeSmooth ("EdgeSmooth", Float) = .015
	}

	SubShader
	{
		Tags
		{
            "RenderType" = "Transparent"
            "IgnoreProjector" = "true"
            "PreviewType" = "Plane"
		}

		Pass
		{
            // ZTest On
            // BlendOp Add
            // Blend SrcAlpha OneMinusSrcAlpha
            // ZWrite Off

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

            uniform float4 _Color;
            uniform float _EdgeWidth;
            uniform float _EdgeSmooth;

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

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float4 k = i.vertex;
				float x = (.5-k.z) * (.5-k.z);
				// return float4(x,0,0,1);
    // float3 f  = frac (k * .1);
    // float3 df = fwidth(k * .1);

    // float3 g = smoothstep(0.05, 0.10, f);

    // float c = g.x * g.y * g.z;

    // float4 gl_FragColor = float4(c, c, c, 1.0);
	
	// return gl_FragColor;


	// 					float a =
	// 				smoothstep(
	// 					.5 - .002 *c - _EdgeSmooth,
	// 					.5 - .002 *c,
	// 					max(abs(i.uv.x - .5), abs(i.uv.y - .5))
	// 				);
	// 			return a * _Color;


				float e = _EdgeWidth * (x);
				float a =
					smoothstep(
						.5 - e - _EdgeSmooth,
						.5 - e,
						max(abs(i.uv.x - .5), abs(i.uv.y - .5))
					);
				return a * _Color;
			}
			ENDCG
		}
	}
}
