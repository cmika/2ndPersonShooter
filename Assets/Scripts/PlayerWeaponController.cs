using UnityEngine;
using System.Collections;

public class PlayerWeaponController : MonoBehaviour {

	bool firing;

	public GameObject prefabCamera;
	public GameObject prefabProjectile;

	public GameObject activeCamera;
	public GameObject activeProjectile;



	public void Start() {
		//grab ref to existing camera on game start
		activeCamera = GameObject.Find("PlayerCamera");

		firing = false;
	}

	public void Update() {
		if(Input.GetKeyDown(KeyCode.Mouse0) && !firing){
			StartFiring();
		}
	}

	public void StartFiring() {

		firing = true;

		Transform o = GameObject.Find("Vertical_Head_Joint").transform;

		//instantiate projectile at head bone position
		activeProjectile = (GameObject) Instantiate(prefabProjectile, o.position, o.rotation);

		Vector3 v = o.TransformDirection(Vector3.left * 300);

		activeProjectile.GetComponent<Rigidbody>().AddForce(v);


	}

	public void FailFiring() {
		firing = false;
	}

	public void FinishFiring(Vector3 pos) {
		GameObject.Destroy(activeCamera);

		activeCamera = (GameObject) Instantiate(prefabCamera, pos, Quaternion.identity);
		activeCamera.GetComponent<CameraFollowBehaviour>().target = transform;

		StartCoroutine(waitForAnim());
	}

	IEnumerator waitForAnim() {
		yield return new WaitForSeconds(3.0f);

		firing = false;
	}
}
