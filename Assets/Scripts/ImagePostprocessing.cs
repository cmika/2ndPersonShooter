using UnityEngine;
using System.Collections;

public class ImagePostprocessing : MonoBehaviour {

	public Material mat;

	void OnRenderImage(RenderTexture source, RenderTexture destination) {

		Graphics.Blit (source, destination, mat);
	}

}
