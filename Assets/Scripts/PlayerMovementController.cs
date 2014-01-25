using UnityEngine;
using System.Collections;

public class PlayerMovementController : MonoBehaviour {
	
	Vector3 v;
	public float speed = 5.0f;

	void Update () {

		v = Vector3.zero;

		if(Input.GetKey(KeyCode.W)) {
			v += Vector3.forward;
		}

		if(Input.GetKey(KeyCode.S)) {
			v += Vector3.back;
		}

		if(Input.GetKeyDown(KeyCode.Space)) {
			//jump yo
		}

		v.Normalize();

		rigidbody.AddRelativeForce(v * speed);

		transform.Rotate(Vector3.up, Input.GetAxis("Mouse X"));
	}
}
