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
	}

	public void Update() {
		if(Input.GetKeyDown(KeyCode.Mouse0)){
			StartFiring();
		}
	}

	public void StartFiring() {

		Transform o = GameObject.Find("Torso").transform;

		//instantiate projectile at head bone position
		activeProjectile = (GameObject) Instantiate(prefabProjectile, o.position, o.rotation);

		Vector3 v = o.TransformDirection(Vector3.left * 200);

		activeProjectile.rigidbody.AddForce(v);
	}

	public void FinishFiring(Vector3 pos) {
		GameObject.Destroy(activeCamera);

		activeCamera = (GameObject) Instantiate(prefabCamera, pos, Quaternion.identity);
		activeCamera.GetComponent<CameraFollowBehaviour>().target = transform;
	}
}
