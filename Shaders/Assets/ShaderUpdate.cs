using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class ShaderUpdate : MonoBehaviour {
    public List<Material> materials;
    public Material normalMaterial;

    public Camera c;
    // Use this for initialization
    int current = 0;
    bool APressed = false;
    bool TriggerPressed = false;
    bool HandTriggerPressed = false;

    public AudioSource source;
    bool audioReadStart = false;
    string fileImageSavePath = "D:\\Downloads\\MangoHacks-master\\images\\A.png";
    string fileWavReadPath = "D:\\Downloads\\MangoHacks-master\\output.wav";
	void Start () {
        
	}
    
    // Update is called once per frame
    void Update () {
        

		if(OVRInput.Get(OVRInput.Button.One))
        {
            APressed = true;
            
        }
        else if(APressed)
        {
                //Debug.Log("button pressed called" + current);
                if (current + 1 >= materials.Capacity)
                {
                    current = 0;
                }
                else
                    current++;
                c.GetComponent<PostEffectScript>().mat = materials[current];
                APressed = !APressed;
        }

        if (OVRInput.Get(OVRInput.Button.PrimaryIndexTrigger))
        {
            TriggerPressed = true;
           // Debug.Log(TriggerPressed);
        }
        else if(TriggerPressed)
        {
            Debug.Log("Capturing screen");
            if (!System.IO.File.Exists(fileImageSavePath))
            {
                ScreenCapture.CaptureScreenshot(fileImageSavePath,10);
            }
            TriggerPressed = !TriggerPressed;

        }

        if(System.IO.File.Exists(fileWavReadPath) && !audioReadStart && !GameObject.Find("OVRPlayerController").gameObject.GetComponent<AudioSource>().isPlaying )
        {
            Debug.Log("file exists");
            audioReadStart = true;
            StartCoroutine(playSoundLabel());
        }

        if (OVRInput.Get(OVRInput.Button.PrimaryHandTrigger))
        {
            HandTriggerPressed = true;
            c.GetComponent<PostEffectScript>().mat = normalMaterial;
        }
        else
        {
            c.GetComponent<PostEffectScript>().mat = materials[current];
        }

    }
    IEnumerator playSoundLabel()
    {
        Debug.Log("playing sound");
        source = GetComponent<AudioSource>();
        using (var www = new WWW("File://"+fileWavReadPath))
        {
            yield return www;
            source.clip = www.GetAudioClip();
            
        }
        GameObject.Find("OVRPlayerController").gameObject.GetComponent<AudioSource>().PlayOneShot(source.clip);
        FileUtil.DeleteFileOrDirectory(fileWavReadPath);
        audioReadStart = false;

    }
}
