Shader "Custom/ImCubeShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Color ("Color", Color) = (1,1,1,1)
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
			
			sampler2D _MainTex;
			float4 _Color;

			v2f vert (appdata v)
			{
				v2f o;
				
				float4 offset;

				if (v.vertex.x > 0)
				{
					if (v.vertex.y > 0)
					{
						if (v.vertex.z > 0)
							offset = float4(0,0.25,0,0);
						else
							offset = float4(0,-0.25,0,0);
					}
					else
					{
						if (v.vertex.z > 0)
							offset = float4(0,0.25,0,0);
						else
							offset = float4(0,-0.25,0,0);
					}
				}
				else
				{
					if (v.vertex.y > 0)
					{
						if (v.vertex.z > 0)
							offset = float4(0,-0.25,0,0);
						else
							offset = float4(0,0.25,0,0);
					}
					else
					{
						if (v.vertex.z > 0)
							offset = float4(0,-0.25,0,0);
						else
							offset = float4(0,0.25,0,0);
					}
				}

				v.vertex = v.vertex + offset;
				float4 tv = UnityObjectToClipPos(v.vertex);

				o.vertex = tv;
				o.uv = v.uv;

				//o.vertex = v.vertex;

				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				//fixed4 col = _Color;
				// just invert the colors
				//col.rgb = 1 - col.rgb;
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col * _Color;
			}
			ENDCG
		}
	}
}
