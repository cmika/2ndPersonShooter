using UnityEngine;
using System.Collections;

public class LookAnimationController : MonoBehaviour {

	public float hv;
	public float vv;

	Transform target;

	void Start() {
		target = GameObject.Find("Vertical_Head_Joint").transform; //this is terrible
	}

	void Update () {
		target.Rotate(new Vector3(0, 0, -Input.GetAxis("Mouse Y")), Space.Self);
	}
}
