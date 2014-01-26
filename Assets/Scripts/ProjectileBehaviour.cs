using UnityEngine;
using System.Collections;

public class ProjectileBehaviour : MonoBehaviour {
	
	void Start () {
		StartCoroutine("timeout");
	}

	void Update () {
	
	}

	void OnTriggerEnter(Collider other) {
		if(other.tag != "Environment")
			return;

		GameObject.Find("Player").GetComponent<PlayerWeaponController>().FinishFiring(transform.position);
		Destroy(this.gameObject);
	}

	IEnumerator timeout() {
		yield return new WaitForSeconds(5.0f);

		GameObject.Find("Player").GetComponent<PlayerWeaponController>().FailFiring();
		Destroy(this.gameObject);
	}
}
