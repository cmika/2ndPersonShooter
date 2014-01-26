using UnityEngine;
using System.Collections;

public class PlayerMovementController : MonoBehaviour {

	bool jumping;
	float jumptimer;

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

		if(Input.GetKeyDown(KeyCode.Space) && !jumping) {
			jumping = true;
			jumptimer = 0f;

			v += Vector3.up * 200;
		}

		rigidbody.AddRelativeForce(v * speed);

		transform.Rotate(Vector3.up, Input.GetAxis("Mouse X"));

		if(jumping && jumptimer > 2f)
		{

			Debug.Log(Physics.RaycastAll(this.transform.position, -Vector3.up, 1.6f).Length);
			Debug.DrawLine(this.transform.position, Vector3.down * 1.6f);
		} else if(jumping) jumptimer += Time.deltaTime;

		//Debug.Log(jumping + "|" + jumptimer);
	}
}
