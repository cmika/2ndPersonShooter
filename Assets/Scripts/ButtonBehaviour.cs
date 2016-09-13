using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class ButtonBehaviour : MonoBehaviour {

	public List<DoorBehaviour> targets;
	public Material onmat;

	void OnTriggerEnter() {

		//play a sound and open all targets
		foreach (DoorBehaviour door in targets) {
			door.Open();
		}

		GetComponent<Renderer>().material = onmat;
	}
}
