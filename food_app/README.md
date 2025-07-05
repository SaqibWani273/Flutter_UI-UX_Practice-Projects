

![food_app_figma_ss](https://github.com/user-attachments/assets/f7e03b2c-f409-45c6-9935-1b9b475d342b)

# 🍔 Flutter Food App UI with Animations

This is a Flutter-based food app UI where I tried to replicate this [Dribble Design]( https://dribbble.com/shots/16648056-Food-app-UI-animation) with smooth animations and transitions, inspired by a real-world mobile experience. The project focuses heavily on animation and motion to bring the UI to life.

---

## 👣 My Approach

I followed these steps to implement the project:

1. **Went through all the static screens first**  
   I explored the design and tried to understand how each screen is laid out visually — just to get a feel of the structure.

2. **Identified which screens had animations**  
   Once I had the basic UI in place, I focused on the areas where motion was clearly intended, like the drawer, cards, and image transitions.

3. **Tried to understand the type of animations**  
   I noticed elements like sliding cards, image rotations on scroll, hero transitions between screens, and drawer scaling/offset — so I listed them out to implement them one by one.

4. **Built static UI first**  
   Before adding any animations, I made sure every widget and screen looked close to the reference design.

5. **Integrated animations gradually**  
   I used `AnimationController`, `PageRouteBuilder`, `Hero`, `Transform`, and `AnimatedBuilder` depending on what I wanted to achieve. Most animations are scroll-based or triggered on navigation.

6. **Fine-tuned animation timing & curves**  
   This was a bit trial-and-error but made a big difference in how smooth everything felt.


![fod_app_ss_gif](https://github.com/user-attachments/assets/986060e7-1c56-473e-811a-e36aae82a9eb)

##  What I Learned

- How to break down a UI from Figma and turn it into a working Flutter layout  
- Applying multiple types of animations (slide, hero, transform, fade, etc.)  
- Making screen transitions more fluid using custom route animations  
- How to sync scroll and animation values to create reactive UI  
- The importance of subtle details — like easing, delay, and element timing




