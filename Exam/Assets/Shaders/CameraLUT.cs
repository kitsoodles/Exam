using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CameraLUT : MonoBehaviour
{
    //public Shader myShader = null;
    public Material m_renderMaterial;
    public Material normalLUT;
    public Material warmLUT;
    public Material coolLUT;

    public GameObject normalToggle;
    public GameObject warmToggle;
    public GameObject coolToggle;

    public bool normalToggled = true;
    public bool warmToggled = false;
    public bool coolToggled = false;

    private void Update()
    {
        if (normalToggled == true)
        {
            normalToggle.GetComponent<Toggle>().isOn = true;
        }

        if (warmToggled == true)
        {
            warmToggle.GetComponent<Toggle>().isOn = true;
        }

        if (coolToggled == true)
        {
            coolToggle.GetComponent<Toggle>().isOn = true;
        }
    }

    public void ToggleNormal()
    {
        if (normalToggled == false)
        {
            normalToggled = true;
            warmToggled = false;
            coolToggled = false;

            warmToggle.GetComponent<Toggle>().isOn = false;
            coolToggle.GetComponent<Toggle>().isOn = false;

            m_renderMaterial = normalLUT;
        }
        else
        {
            normalToggle.GetComponent<Toggle>().isOn = true;
        }
    }

    public void ToggleWarm()
    {
        if (warmToggled == false)
        {
            normalToggled = false;
            warmToggled = true;
            coolToggled = false;

            normalToggle.GetComponent<Toggle>().isOn = false;
            coolToggle.GetComponent<Toggle>().isOn = false;

            m_renderMaterial = warmLUT;
        }
        else
        {
            warmToggle.GetComponent<Toggle>().isOn = true;
        }
    }

    public void ToggleCool()
    {
        if (coolToggled == false)
        {
            normalToggled = false;
            warmToggled = false;
            coolToggled = true;

            normalToggle.GetComponent<Toggle>().isOn = false;
            warmToggle.GetComponent<Toggle>().isOn = false;

            m_renderMaterial = coolLUT;
        }
        else
        {
            coolToggle.GetComponent<Toggle>().isOn = true;
        }
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, m_renderMaterial);
    }
}
