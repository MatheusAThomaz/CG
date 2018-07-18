Shader "Custom/Mixed"
{
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
		_Scale ("Scale", float) = 1.0
		_Rotationx ("Rotationx", float) = 0.0
		_Rotationy ("Rotationy", float) = 0.0
		_Rotationz ("Rotationz", float) = 0.0
		_Position ("Translation", Vector) = (0.0, 0.0, 0.0, 1.0)

        _Tex ("Pattern", 2D) = "white" {} //Optional texture
        _Shininess ("Shininess", Float) = 10 //Shininess
        _SpecColor ("Specular Color", Color) = (1, 1, 1, 1) //Specular highlights color

		[HideInInspector] _Distortion ("Distortion", float) = 10
		[HideInInspector] _Doffset ("Distortion Offset", Vector) = (0.0, 0.0, 0.0, 1.0)

		[HideInInspector] _CameraCoord ("Camera Coordinates", Vector) = (0.0, 0.0, 0.0, 1.0)
	}

	SubShader
	{
		Tags { "RenderType" = "Opaque" } //We're not rendering any transparent objects
        LOD 200 //Level of detail

		Cull Off

		Pass
		{
			Tags { "LightMode" = "ForwardBase" } //For the first light

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;

				float3 normal : NORMAL;
                float4 posWorld : TEXCOORD1;
			};
			
			float _Scale;
			float4 _Color;
			float _Rotationx;
			float _Rotationy;
			float _Rotationz;
			float3 _Position;
			float _Distortion;
			float4 _Doffset;
			float4 _CameraCoord;

			uniform float4 _LightColor0; //From UnityCG

			sampler2D _Tex; //Used for texture
            float4 _Tex_ST; //For tiling
            //uniform float4 _Color; //Use the above variables in here
            uniform float4 _SpecColor;
            uniform float _Shininess;


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

				v.vertex = v.vertex * _Scale;
				
				v.vertex = RotateInX(v.vertex, _Rotationx);
				v.vertex = RotateInY(v.vertex, _Rotationy);
				v.vertex = RotateInZ(v.vertex, _Rotationz);

				v.vertex.x = v.vertex.x + _Position.x;
				v.vertex.y = v.vertex.y + _Position.y;
				v.vertex.z = v.vertex.z + _Position.z;

				if (_Doffset.x == 1)
					v.vertex.y += sin(v.vertex.x*_Distortion + distance( v.vertex , _CameraCoord));

				o.vertex = UnityObjectToClipPos(v.vertex);

				//o.uv = v.uv;



                o.posWorld = mul(unity_ObjectToWorld, v.vertex); //Calculate the world position for our point
                o.normal = normalize(mul(float4(v.normal, 0.0), unity_WorldToObject).xyz); //Calculate the normal
                //o.vertex = UnityObjectToClipPos(v.vertex); //And the position
                o.uv = TRANSFORM_TEX(v.uv, _Tex);

				//o.vertex.y += sin(o.vertex.x*_Distortion);
				return o;
			}

			fixed4 frag(v2f i) : COLOR
            {
				
                float3 normalDirection = normalize(i.normal);
                float3 viewDirection = normalize(_WorldSpaceCameraPos - i.posWorld.xyz);

                float3 vert2LightSource = _WorldSpaceLightPos0.xyz - i.posWorld.xyz;
                float oneOverDistance = 1.0 / length(vert2LightSource);
                float attenuation = lerp(1.0, oneOverDistance, _WorldSpaceLightPos0.w); //Optimization for spot lights. This isn't needed if you're just getting started.
                float3 lightDirection = _WorldSpaceLightPos0.xyz - i.posWorld.xyz * _WorldSpaceLightPos0.w;

                float3 ambientLighting = UNITY_LIGHTMODEL_AMBIENT.rgb * _Color.rgb; //Ambient component
                float3 diffuseReflection = attenuation * _LightColor0.rgb * _Color.rgb * max(0.0, dot(normalDirection, lightDirection)); //Diffuse component
                float3 specularReflection;
                if (dot(i.normal, lightDirection) < 0.0) //Light on the wrong side - no specular
                {
                    specularReflection = float3(0.0, 0.0, 0.0);
                	}
                else
                {
                    //Specular component
                    specularReflection = attenuation * _LightColor0.rgb * _SpecColor.rgb * pow(max(0.0, dot(reflect(-lightDirection, normalDirection), viewDirection)), _Shininess);
                }

                float3 color = (ambientLighting + diffuseReflection) * tex2D(_Tex, i.uv) + specularReflection; //Texture is not applient on specularReflection
                return float4(color, 1.0);
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
