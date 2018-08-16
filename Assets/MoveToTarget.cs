using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveToTarget : MonoBehaviour
{
    public float speed = 10f;
    public float close = 0.1f;
    public Transform[] points;
    private Vector3 target;
    private bool flag = false;
    private int point = 0;

    void Start ()
    {
        target = points[point].position;
        flag = true;
    }

    void Update ()
    {
        PointUpdate();

        if (flag)
            gameObject.transform.position = Vector3.MoveTowards(gameObject.transform.position, target, Time.deltaTime * speed);
            //gameObject.transform.position = Vector3.Lerp(gameObject.transform.position, target, Time.deltaTime * speed);
    }

    void PointUpdate()
    {
        if ((gameObject.transform.position - target).magnitude < close)
        {
            if (point >= points.Length - 1)
                flag = false;
            else
                point++;

            target = points[point].position;
        }
        else
            target = points[point].position;
    }
}
