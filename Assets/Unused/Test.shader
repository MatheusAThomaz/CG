Shader "Custom/Vertex Modifier"
{
    Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Color ("Color", Color) = (1,1,1,1)
    }

	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert
		struct Input {
			float2 uv_MainTex;
		};
 
		// Access the shaderlab properties
		sampler2D _MainTex;
		float4 _Color;
 
		// Vertex modifier function
		void vert (inout appdata_full v) {
			// Do whatever you want with the "vertex" property of v here
				
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

				float4 tv = v.vertex + offset;

				v.vertex = tv;
		}
 
		// Surface shader function
		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb * _Color;
		}
		ENDCG
	}
}