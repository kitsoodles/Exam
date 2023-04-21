# Exam
 
First, the main shader that's used in this project is a toon shader. This works by taking a ramp texture, and assigning different levels of shadow to the different colours shown on the ramp. instead of using a smooth transition between the shadow, it instead only takes certain steps and renders those instead. This way, it gives that cell shaded effect.
![image](https://user-images.githubusercontent.com/98484257/233701303-86cb1c58-22ba-4523-abe3-f16416c55b56.png)

What's added on this shader is that there's also a rim light effect as well as potential for an outline. The scene we were given is very hand drawn, and by adding these two effects this would increase the 'cartoon' appeal that the original pixel art has, but in a 3D setting. 
![image](https://user-images.githubusercontent.com/98484257/233701568-0e71c96f-6ec1-409b-8a59-3cd270d11ea1.png)

This is achieved by extruding the mesh and giving it whatever colour you have selected as the outline colour. This way, it gives the impression that the mesh is outlined when really all it is is a second iteration extruded slightly off the mesh to give the appearence of such. The rim light is similar, but instead of extruding the mesh it calculates the emission, and only lights up the edges.

![image](https://user-images.githubusercontent.com/98484257/233702181-57e1539b-c0c5-4b1b-a000-23a57b17ddc8.png)
![image](https://user-images.githubusercontent.com/98484257/233702266-ee1e3f8c-69d9-436c-b9e6-dece52bcdf3a.png)

Next, we have the water. The water has a wave effect as well as a custom texture, but not only that but it uses a toon shader as well to match the aesthetic of the rest of the scene. When the waves are low, the toon shadows are visible. It also has the potential for an outline which I turned off so that the scene wouldn't appear too cluttered. The waves are done by using a sin equation, and updating the position of the shader using the output of that equation based on time. 
![image](https://user-images.githubusercontent.com/98484257/233703045-06d6be9e-ba00-4156-a709-6e764de6ab17.png)

I do in fact have a bloom effect implimented, however for whatever reason whenever I applied it to the camera, the screen only displayed black. I am not sure what might be causing this, but I can explain how the bloom effect works regardless. 
Here, the light is calculated with a blur. Then, the program calculates where the light is brightest. If it is above a certain threshold, it displays the light bloom effect. If it is below, it doesn't render any of the above effects. This then gives the bloom effect when applied onto the camera, making the brightest areas slightly blurred and with higher emmission.
![image](https://user-images.githubusercontent.com/98484257/233704066-5829f352-18e6-4d14-8525-c2f0e0520ec4.png)
![image](https://user-images.githubusercontent.com/98484257/233704162-b9a0bfbb-8fb4-4e27-a087-b8017b407400.png)


In it's place however, I decided to add a rays effect. In this gif, you can see the spotlight on the wall is reflecting into the water, and I felt like adding rays would be a great way of displaying this effect. 
![image](https://user-images.githubusercontent.com/98484257/233704371-055f4885-30fc-46d3-afd6-bf50e6f30384.png)

![image](https://user-images.githubusercontent.com/98484257/233705279-64296922-6116-46c5-8e21-4cd381329eec.png)

Here you can see the light now has an almost blurred effect despite the toon shader, just like the effect in the gif. These were implimented as a post processing effect which, just like bloom, is rendered after the scene is rendered and applied on top of it. The density controls how strong the 'blur' effect is, the exposure controls the brightness of the scene, the decay controls how strong the smear on the light is, and the samples are how many iterations of the 'smear' are rendered to make it either more or less smooth.. 
![image](https://user-images.githubusercontent.com/98484257/233705623-8788f93a-e9f5-49dd-92dd-e11a4ceac758.png)

As for the waves changing transparancy, I did not manage to get it working but I do however know the logic behind how it would be implimented. Basically, depending on the current time or the height of the wave (depending on the effect you wished to achieve) you would manipulate the alpha to either be 0.5 (semi transparent) or 1 (fully opaque). This way the shader would cycle between these two opacities on its own, changing the water from murky to clear. 


Model source: 
https://skfb.ly/oET6v

brick outline
https://thumbs.dreamstime.com/b/white-black-brick-wall-background-seamless-repeating-pattern-vector-outline-illustration-white-black-brick-wall-background-222774214.jpg

all other textures were made by me
