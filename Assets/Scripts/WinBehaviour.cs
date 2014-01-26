using UnityEngine;
using System.Collections;

public class WinBehaviour : MonoBehaviour {

	public Texture2D bg;

	bool visible = false;

	void OnTriggerEnter(Collider other) {
		if(other.tag == "Player") {
			visible = true;
			StartCoroutine("endthegoddamngame");
		}
	}

	void OnGUI() {
		if (!visible) return;

		GUI.DrawTexture(new Rect(0,0,Screen.width,Screen.height), bg);
	}

	IEnumerator endthegoddamngame() {
		yield return new WaitForSeconds(5.0f);
		Application.Quit();
	}
}
