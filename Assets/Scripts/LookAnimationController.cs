using UnityEngine;
using System.Collections;

public class LookAnimationController : MonoBehaviour {

	public float hv;
	public float vv;

	void Start() {
		foreach (AnimationState state in animation) {
			state.enabled = true;
			state.weight = 1.0f;
		}
	}

	void Update () {
		foreach (AnimationState state in animation) {
			state.normalizedTime = hv;
		}
	}
}
