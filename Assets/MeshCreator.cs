using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum MeshOption
{
    Cube, Tetrahedron, Model
}

public class MeshCreator : MonoBehaviour
{
    public MeshOption option;
    public GameObject prefab;

    private MeshOption lastOption;
    private Vector3[] vertices;
    private int[] triangles;
    private Mesh m;

    void Start() { m = GetComponent<MeshFilter>().mesh; CreateMesh(); }

    void Update() { if (option != lastOption) CreateMesh(); }

    void CreateMesh()
    {
        lastOption = option;

        switch (option)
        {
            case MeshOption.Cube:
                CubeVertices();
                CubeTriangles();
                break;

            case MeshOption.Tetrahedron:
                TetrahedronVertices();
                TetrahedronTriangles();
                break;

            case MeshOption.Model:
                ModelVertices();
                ModelTriangles();
                break;
        }

        m.Clear();
        m.vertices = vertices;
        m.triangles = triangles;
        m.RecalculateNormals();
    }

    void CubeVertices()
    {
        vertices = new Vector3[]
        {
            new Vector3( 1,  1,  1), //0
            new Vector3( 1,  1, -1), //1
            new Vector3( 1, -1,  1), //2
            new Vector3( 1, -1, -1), //3

            new Vector3( 1,  1, -1), //4
            new Vector3(-1,  1, -1), //5
            new Vector3( 1, -1, -1), //6
            new Vector3(-1, -1, -1),  //7

            new Vector3(-1,  1, -1), //8
            new Vector3(-1,  1,  1), //9
            new Vector3(-1, -1, -1), //10
            new Vector3(-1, -1,  1), //11

            new Vector3(-1,  1,  1), //12
            new Vector3( 1,  1,  1), //13
            new Vector3(-1, -1,  1), //14
            new Vector3( 1, -1,  1), //15

            new Vector3( 1,  1,  1), //16
            new Vector3(-1,  1,  1), //17
            new Vector3( 1,  1, -1), //18
            new Vector3(-1,  1, -1),  //19

            new Vector3( 1, -1, -1), //20
            new Vector3(-1, -1, -1), //21
            new Vector3( 1, -1,  1), //22
            new Vector3(-1, -1,  1) //23

        };
    }
    void CubeTriangles()
    {
        triangles = new int[]
        {
             0,  2,  1,
             1,  2,  3,

             4,  6,  5,
             5,  6,  7,

             8, 10,  9,
             9, 10, 11,

            12, 14, 13,
            13, 14, 15,

            16, 18, 17,
            17, 18, 19,

            20, 22, 21,
            21, 22, 23
        };
    }
    void TetrahedronVertices()
    {
        float sq89 = Mathf.Sqrt(8f / 9f) * 2f;
        float sq29 = Mathf.Sqrt(2f / 9f) * 2f;
        float sq23 = Mathf.Sqrt(2f / 3f) * 2f;

        vertices = new Vector3[]
        {
            new Vector3( sq89, -2/3,    0f), //0
            new Vector3(-sq29, -2/3, -sq23), //1
            new Vector3(   0f,   2f,    0f), //2

            new Vector3(-sq29, -2/3,  sq23), //3
            new Vector3(   0f,   2f,    0f), //4
            new Vector3(-sq29, -2/3, -sq23), //5

            new Vector3( sq89, -2/3,    0f), //6
            new Vector3(-sq29, -2/3,  sq23), //7
            new Vector3(-sq29, -2/3, -sq23), //8

            new Vector3( sq89, -2/3,    0f), //9
            new Vector3(   0f,   2f,    0f), //10
            new Vector3(-sq29, -2/3,  sq23)  //11
        };
    }
    void TetrahedronTriangles()
    {
        triangles = new int[]
        {
            0,  1,  2,
            3,  4,  5,
            6,  7,  8,
            9, 10, 11
        };
    }

    void ModelVertices()
    {
        Mesh mesh = prefab.GetComponent<MeshFilter>().sharedMesh;
        vertices = new Vector3[mesh.vertices.Length];

        for (int i = 0; i < mesh.vertices.Length; i++)
            vertices[i] = new Vector3(mesh.vertices[i].x, mesh.vertices[i].y, mesh.vertices[i].z);
    }
    void ModelTriangles()
    {
        Mesh mesh = prefab.GetComponent<MeshFilter>().sharedMesh;
        triangles = new int[mesh.triangles.Length];

        for (int i = 0; i < mesh.triangles.Length; i++)
            triangles[i] = mesh.triangles[i];
    }
}
