using UnityEngine;
using System.Collections;

public class CameraFollowBehaviour : MonoBehaviour {

	public Transform target;

	void Update () {
		transform.LookAt(target.transform);
	}
}
