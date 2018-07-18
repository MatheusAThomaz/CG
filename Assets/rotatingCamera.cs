using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class rotatingCamera : MonoBehaviour
{
    private float sensibility = 5f;
	// Update is called once per frame
	void Update ()
    {
        if (Input.GetMouseButton(0))
            transform.Rotate(new Vector3(0f, Input.GetAxis("Mouse X") * sensibility, 0f));
            //transform.Rotate(new Vector3(-Input.GetAxis("Mouse Y") * sensibility, Input.GetAxis("Mouse X") * sensibility, 0f));
        
        if (Input.GetKeyDown(KeyCode.Z))
            transform.rotation = Quaternion.Euler(0f, 0f, 0f);

        if (Input.GetKeyDown(KeyCode.X))
            transform.rotation = Quaternion.Euler(0f, 180f, 0f);
    }
}
