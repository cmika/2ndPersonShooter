using UnityEngine;
using System.Collections;

public class MouseLockBehaviour : MonoBehaviour {

	// Use this for initialization
	void Start () {
		Screen.lockCursor = true;
	}
	
	// Update is called once per frame
	void Update () {
		if(Input.GetKeyDown(KeyCode.Escape) && Screen.lockCursor) {
			Screen.lockCursor = false;
		}

		if(Input.GetMouseButtonDown(0) && !Screen.lockCursor) {
			Screen.lockCursor = true;
		}
	}
}
