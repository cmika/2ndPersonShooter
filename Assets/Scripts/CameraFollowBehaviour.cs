using UnityEngine;
using System.Collections;

public class CameraFollowBehaviour : MonoBehaviour {

	public Transform target;
	public Texture2D bg;

	void Update () {
		transform.LookAt(target.transform);
	}

	void OnGUI() {
		GUI.DrawTexture(new Rect(0,0,Screen.width,Screen.height), bg);
	}
}
