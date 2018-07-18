using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MaterialHandler : MonoBehaviour
{
    public Transform cam;
    private void Update()
    {
        GetComponent<Renderer>().sharedMaterial.SetVector("_CameraCoord", new Vector4(cam.position.x, cam.position.y, cam.position.z, 1));

        if (gameObject.name == "MeshCreatorFence")
            GetComponent<Renderer>().sharedMaterial.SetVector("_Doffset", new Vector4(1, 0, 0, 1));
    }
}
