using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class PostEffectScript : MonoBehaviour {
    public Material mat;
    public Camera c;
    private void Start()
    {
        Debug.Log("post effect script");
        c.depthTextureMode = DepthTextureMode.Depth;
       
    }
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        // src is the fully rendered scene that is sent directly to the monitor
        // we intercept this!!

        
        Graphics.Blit(source, destination,mat);

    }

    
}
