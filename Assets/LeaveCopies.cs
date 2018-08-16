using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LeaveCopies : MonoBehaviour
{
    public float rate;

    void Start()
    {
        InvokeRepeating("LeaveCopy", 0f, 1f/rate);
    }

    private void LeaveCopy ()
    {
        GameObject go = Instantiate(gameObject, gameObject.transform.position, gameObject.transform.rotation);
        //go.GetComponent<MoveToClick>().enabled = false;
        //go.GetComponent<MoveToParent>().enabled = false;
        go.GetComponent<MoveToTarget>().enabled = false;
        go.GetComponent<LeaveCopies>().enabled = false;
    }
}
