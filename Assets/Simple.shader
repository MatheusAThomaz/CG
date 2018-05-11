Shader "Custom/Simple"
{
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
		_Scale ("Scale", float) = 1.0
		_Rotationx ("Rotationx", float) = 0.0
		_Rotationy ("Rotationy", float) = 0.0
		_Rotationz ("Rotationz", float) = 0.0
		_flagOrder ("Flag", int) = 0
	}

	SubShader
	{

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
			
			float _Scale;
			float4 _Color;
			float _Rotationx;
			float _Rotationy;
			float _Rotationz;
			int _flagOrder;

			float4 RotateInX(float4 coord, float d)
			{
				float4x4 xrm = float4x4( 1.0,	 0.0,	  0.0, 0.0,
										 0.0, cos(d), -sin(d), 0.0,
										 0.0, sin(d),  cos(d), 0.0,
										 0.0,    0.0,     0.0, 1.0);

				return mul(xrm, coord);
			}

			float4 RotateInY(float4 coord, float d)
			{
				float4x4 yrm = float4x4(  cos(d),  0.0, sin(d),  0.0,
										     0.0,  1.0,    0.0,  0.0,
										 -sin(d),  0.0, cos(d),  0.0,
										     0.0,  0.0,    0.0,  1.0);

				return mul(yrm, coord);
			}

			float4 RotateInZ(float4 coord, float d)
			{
				float4x4 zrm = float4x4( cos(d), -sin(d), 0.0, 0.0,
										 sin(d),  cos(d), 0.0, 0.0,
										    0.0,     0.0, 1.0, 0.0,
										    0.0,     0.0, 0.0, 1.0);

				return mul(zrm, coord);
			}

			v2f vert (appdata v)
			{
				v2f o;
				
				v.vertex = RotateInX(v.vertex, _Rotationx);
				v.vertex = RotateInY(v.vertex, _Rotationy);
				v.vertex = RotateInZ(v.vertex, _Rotationz);

				o.vertex = UnityObjectToClipPos(v.vertex * _Scale);

				o.uv = v.uv;
				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = _Color;
				return col;
			}
			ENDCG
		}
	}
}

////			1	0		0		0
//// x axis =	0	cosa	-sena	0
////			0	sena	cosa	0
////			0	0		0		1
////
////			cosa	0	sena	0
//// y axis =	0		1	0		0
////			-sena	0	cosa	0
////			0		0	0		1
////
////			cosa	-sena	0	0
//// z axis =	sena	cosa	0	0
////			0		0		1	0
////			0		0		0	1
////
////
