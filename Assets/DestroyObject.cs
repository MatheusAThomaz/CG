using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DestroyObject : MonoBehaviour {

	void OnCollisionEnter(Collision col) {
		if(col.gameObject.name == "candelabra") {
			Destroy(col.gameObject);
		}
	}
}
