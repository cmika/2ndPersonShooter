using UnityEngine;
using System.Collections;

public class PlayerMovementController : MonoBehaviour {
	
	Vector3 v;
	public float speed = 5.0f;

	void Update () {

		v = Vector3.zero;

		if(Input.GetKey(KeyCode.W)) {
			v += Vector3.right;
		}

		if(Input.GetKey(KeyCode.S)) {
			v += Vector3.left; //test model oriented towards x+, unity forward was z+
		}

		v.Normalize();

		if(Input.GetKeyDown(KeyCode.Space)) {
			v += Vector3.up * 50;
			//jumping obviously doesn't work like this
		}

		rigidbody.AddRelativeForce(v * speed);

		transform.Rotate(Vector3.up, Input.GetAxis("Mouse X"));
	}
}
