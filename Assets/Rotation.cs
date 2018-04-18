using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotation : MonoBehaviour
{
    public float xRotation = 20.0f;
    public float yRotation = 20.0f;
    public float zRotation = 20.0f;

    void Update()
    {
        Vector3 rt = new Vector3(xRotation, yRotation, zRotation);
        gameObject.transform.Rotate(rt * Time.deltaTime);
    }
}
