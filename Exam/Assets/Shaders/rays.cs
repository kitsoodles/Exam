using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public class rays : PostProcessEffectSettings
{
    public Vector2 sunScreenPos = new Vector2(0.5f, 0.5f);
    [Range(0f, 5f)]
    public float density = 1f;
    [Range(0f, 5f)]
    public float weight = 1f;
    [Range(0f, 1f)]
    public float decay = 1f;
    [Range(0f, 5f)]
    public float exposure = 1f;
    [Range(1, 200)]
    public int numSamples = 100;
}

public class CrepuscularRaysPostProcessing : PostProcessEffectRenderer<rays>
{
    public override void Render(PostProcessRenderContext context)
    {
        var sheet = context.propertySheets.Get(Shader.Find("Custom/CrepuscularRays"));
        sheet.properties.SetVector("_SunScreenPos", settings.sunScreenPos);
        sheet.properties.SetFloat("_Density", settings.density);
        sheet.properties.SetFloat("_Weight", settings.weight);
        sheet.properties.SetFloat("_Decay", settings.decay);
        sheet.properties.SetFloat("_Exposure", settings.exposure);
        sheet.properties.SetInt("_NumSamples", settings.numSamples);
        context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
    }
}
