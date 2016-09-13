using UnityEngine;
using System.Collections;

public class PlayerAnimationController : MonoBehaviour {

	public enum walkingstate { idle, starting, cycle, stopping };
	public enum jumpingstate { off, jumping, landing };

	public walkingstate walking;
	public jumpingstate jumping;

	void Start() {
		walking = walkingstate.idle;
		jumping = jumpingstate.off;
	}

	//anim specs:
	//idle
	//startmoving
	//moving
	//stopmoving
	//jump			100 frame animation, pause at 50 to hold in air


	public void StartMoving() {
		GetComponent<Animation>().Play("StartMoving");
		walking = walkingstate.starting;
	}

	public void StartCycling() {
		GetComponent<Animation>().Stop();
		//animation.Play("Moving"); //TEMPORARILY BROKEN
		walking = walkingstate.cycle;
	}

	public void StopMoving() {
		GetComponent<Animation>().Stop();
		//animation.Play("StopMoving"); //TEMPORARILY BROKEN
		walking = walkingstate.stopping;
	}

	public void ExitMoving() {
		GetComponent<Animation>().Stop ();
		walking = walkingstate.idle;
	}

	public void StartJumping() {
		GetComponent<Animation>().Stop();
		walking = walkingstate.idle;
		GetComponent<Animation>()["Jump"].speed = 3;
		GetComponent<Animation>().Play("Jump");
		jumping = jumpingstate.jumping;
	}

	public void StopJumping() {
		jumping = jumpingstate.landing;
	}

	public void StopMovingp() {
		if(!Input.GetKey(KeyCode.W)){
			StopMoving();
		}
	}

	void Update() {

		switch(walking)
		{
		case walkingstate.idle:
			if(Input.GetKeyDown(KeyCode.W)){
				StartMoving();
			}
			break;
		case walkingstate.starting:
			StopMovingp();
			if(GetComponent<Animation>()["StartMoving"].normalizedTime > 0.95f){ //close enough
				StartCycling();
			}
			break;
		case walkingstate.cycle:
			StopMovingp();
			break;
		case walkingstate.stopping:
			if(Input.GetKeyDown(KeyCode.W)){
				StartMoving();
			} else if (GetComponent<Animation>()["StopMoving"].normalizedTime > 0.95){
				ExitMoving();
			}
			break;
		}


		if(jumping == jumpingstate.jumping) {
			if(GetComponent<Animation>()["Jump"].normalizedTime >= 0.5f) {
				GetComponent<Animation>()["Jump"].normalizedTime = 0.5f;
			}
		}

	}

}
