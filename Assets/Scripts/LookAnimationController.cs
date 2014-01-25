using UnityEngine;
using System.Collections;

public class LookAnimationController : MonoBehaviour {

	public float hv;
	public float vv;

	Transform target;

	//depending on how character modelling dude sets up his rig we might need to blend animations for horizontal and vertical movement together
	//with additive anim blending we should be able to declare both animations at 100% weight and just set their time
	//unity didn't like that much last time i tried it, additive in unity seems to mean "interpret animation as relative to current bone positions"
	//we might need to actually grab the transform for the head pivot bone and rotate it in script
	//aka ghetto IK

	//on this test rig the bone in question is "Torso" and we can just set its rotations

	void Start() {
		target = GameObject.Find("Torso").transform; //VERY BAD DO NOT THIS
	}

	void Update () {
		target.Rotate(new Vector3(0, -Input.GetAxis("Mouse Y"), 0), Space.Self); //local left is Y+ for some reason???
	}
}
