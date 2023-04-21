using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;

public class noisegen : MonoBehaviour
{
    public Texture2D noise;
    public Material perlinMaterial;
    public int width = 512;
    public int height = 512;
    public float scale = 1.0f;
    private int _nameCounter = 0;

    private void SaveTexturesToJPG(Texture2D textureToSave)
    {
        byte[] bytes = textureToSave.EncodeToPNG();
        string filepath = "./Assets/JPG_" + _nameCounter + ".jpg";
        _nameCounter++;
        File.WriteAllBytes(filepath, bytes);
    }

    [ContextMenu("Generate Texture")]
    private void GenerateTexture()
    {
        noise = new Texture2D(width, height, TextureFormat.RGBA32, true);
        for (int i = 0; i < width; i++)
        {
            for (int j = 0; j < height; j++)
            {
                float xOrg = 0;
                float yOrg = 0;

                float xCoord = xOrg + i / (float) width * scale;
                float yCoord = yOrg + j / (float) height * scale;
                float sample = Mathf.PerlinNoise(xCoord, yCoord);
                noise.SetPixel(i, j, new Color(sample, sample, sample));
            }
        }

        noise.Apply();
        SaveTexturesToJPG(noise);
    }
}
