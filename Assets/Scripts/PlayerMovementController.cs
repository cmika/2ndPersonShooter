using UnityEngine;
using System.Collections;

public class PlayerMovementController : MonoBehaviour {

	bool jumping;

	Vector3 v;
	public float speed = 5.0f;

	void Update () {

		v = Vector3.zero;

		if(Input.GetKey(KeyCode.W)) {
			v += Vector3.left; //test model oriented towards x+, unity forward was z+
		}

		if(Input.GetKey(KeyCode.S)) {
			v += Vector3.right * 0.65f;
		}

		v.Normalize();

		if(Input.GetKeyDown(KeyCode.Space) && !jumping) {
			jumping = true;
			GetComponent<PlayerAnimationController>().StartJumping();
			StartCoroutine("jumpdelay");
		}

		GetComponent<Rigidbody>().AddRelativeForce(v * speed);

		transform.Rotate(Vector3.up, Input.GetAxis("Mouse X"));
	}

	void OnCollisionEnter(Collision col) {
		if(col.collider.gameObject.layer == 8){ //layer for jump-resetting platforms
			jumping = false;
			GetComponent<PlayerAnimationController>().StopJumping();
		}
	}

	IEnumerator jumpdelay() {
		yield return new WaitForSeconds(0.5f);
		GetComponent<Rigidbody>().AddRelativeForce(Vector3.up * 600);
	}
}
