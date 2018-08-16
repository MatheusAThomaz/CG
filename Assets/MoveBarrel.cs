using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveBarrel : MonoBehaviour {
	
	int speed = 10;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		 if (Input.GetButton("Vertical")) {
			 if(Input.GetAxis("Vertical") > 0) {
				transform.Translate(new Vector3(0, speed, 0) * Time.deltaTime);
			 }
			 else {
				transform.Translate(new Vector3(0, -speed, 0) * Time.deltaTime);
			 }
		 }

		 if (Input.GetButton("Horizontal")) {
			 if(Input.GetAxis("Horizontal") > 0) {
				transform.Translate(new Vector3(speed, 0 ,0) * Time.deltaTime);
			 }
			 else {
				transform.Translate(new Vector3(-speed, 0 ,0) * Time.deltaTime);
			 }
		 }

		if (Input.GetButton("Deep")) {
			 if(Input.GetAxis("Deep") > 0) {
				 Debug.Log("pos");
				transform.Translate(new Vector3(0, 0 ,speed) * Time.deltaTime);
			 }
			 else {
				 				 Debug.Log("neg");

				transform.Translate(new Vector3(0, 0 ,-speed) * Time.deltaTime);
			 }
		 }
 
	}
}
