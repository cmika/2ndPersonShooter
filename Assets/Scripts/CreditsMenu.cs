using UnityEngine;
using System.Collections;

public class CreditsMenu : MonoBehaviour {

	public bool visible;
	public GameObject mainMenu;

	public Texture2D bg;
	public GUIStyle backs;

	void OnGUI() {
		if(!visible) return;

		GUI.DrawTexture(new Rect(0,0,Screen.width,Screen.height), bg);

		if(GUI.Button(new Rect(Screen.width - 512, Screen.height - 256, 512, 256), "", backs)) {
			mainMenu.GetComponent<MenuBehaviour>().visible = true;
			visible = false;
		}
	}
}
