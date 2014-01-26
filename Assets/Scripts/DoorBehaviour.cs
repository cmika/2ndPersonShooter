using UnityEngine;
using System.Collections;

public class DoorBehaviour : MonoBehaviour {

	public void Open() {
		//open animation? possibly just destroy
		Destroy(this.gameObject);
	}
}
