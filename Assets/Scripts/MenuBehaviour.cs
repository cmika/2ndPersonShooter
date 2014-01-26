using UnityEngine;
using System.Collections;

public class MenuBehaviour : MonoBehaviour {

	public bool visible;
	public GameObject creditsMenu;


	public GUIStyle plays;
	public GUIStyle credits;
	public GUIStyle quits;
	public Texture2D bg;

	void OnGUI() {

		if(!visible) return;

		GUI.DrawTexture(new Rect(0,0,Screen.width,Screen.height), bg);

		if(GUI.Button(new Rect(Screen.width - 512, 0, 512, 256), "", plays)) {
			Application.LoadLevel(1);
		}

		if(GUI.Button(new Rect(Screen.width - 512, 256, 512, 256), "", credits)) {
			creditsMenu.GetComponent<CreditsMenu>().visible = true;
			visible = false;
		}

		if(GUI.Button(new Rect(Screen.width - 512, 512, 512, 256), "", quits)) {
			Application.Quit();
		}
	}
}
