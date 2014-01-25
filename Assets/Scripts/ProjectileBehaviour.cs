using UnityEngine;
using System.Collections;

public class ProjectileBehaviour : MonoBehaviour {
	
	void Start () {
		
	}

	void Update () {
	
	}

	void OnTriggerEnter(Collider other) {
		if(other.tag != "Environment")
			return;

		GameObject.Find("Player").GetComponent<PlayerWeaponController>().FinishFiring(transform.position);
		Destroy(this.gameObject);
	}
}
