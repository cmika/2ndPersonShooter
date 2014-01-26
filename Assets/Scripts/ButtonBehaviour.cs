using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class ButtonBehaviour : MonoBehaviour {

	public List<DoorBehaviour> targets;

	void OnTriggerEnter() {

		//play a sound and open all targets
		foreach (DoorBehaviour door in targets) {
			door.Open();
		}
	}
}
