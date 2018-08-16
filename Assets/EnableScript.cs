using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnableScript : MonoBehaviour {

	public GameObject object_game;

	// Use this for initialization
	void Start () {
			MoveToTarget script;
      
    		script = object_game.GetComponent<MoveToTarget>();
     		script.enabled = false;
	}
	
	// Update is called once per frame
	void Update () {
		if(Input.GetKey("space")) {
			MoveToTarget script;
    		script = object_game.GetComponent<MoveToTarget>();
     		script.enabled = true;
		}
	}
}
