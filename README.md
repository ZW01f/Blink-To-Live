![made-with-python](https://img.shields.io/badge/Made%20with-Python3-brightgreen)

<!-- LOGO -->
<br />
<h1>
<p align="center">
  <img src="/readme_assests/logo.png" alt="Logo" width="140" height="110">
  <br>Blink To Live
</h1>
  <p align="center">
    Computer vision based mobile application for Patients with speech and verbal motor disorders .
    <br />
    </p>
</p>

<p align="center">
  <a href="#about-the-project">About The Project</a> •
  <a href="# Requirements">Requirements</a> •
  <a href="#How-to-use">How To Use</a> •
  <a href="#Demo">Demo</a> •
  <a href="#References">References</a> •
</p>  

<p align="center">

# About The Project  

Patients with speech and verbal motor disorders have difficulties to communicate withtheir living world. They gradually lose the ability to control their muscles leading to a completely paralysis stage with their eye’s pupil is the only available movement organ for initiating a communication with the others. 

<!-- ![patients_video](//readme_assests/vid1.mp4) -->

**Blink-To-Live** is a computer vision based mobile application for tracking the eight eye states defined in the [Blink-To-Speak](https://www.blinktospeak.com/blink-to-speak-book) book which is a communication language based on eyes blinks and translates it to a sequence of communicated sentences based on the pre-defined eye's blinks alphabets called Blink to Speak. 
  
The camera will be used to track the patient's eyes and the computer vision module will be used to decode the eyes movements/blinks and translated it to the corresponding communicated sentences. 

the patient can learn the eye's alphabets via our application in the fast and efficient manner.

  # Requirements 
```
  pip install fastapi
  ```
```
  pip install opencv-python
  ```
```
  pip install numpy
  ```
```
  pip install dlib
  ```
```
  pip install time
  ```
```
  pip install translate
  ```
```
  pip install pyttsx3
  ```
# How to use 
## Desktop version
1. Install Project Dependencies
2. Clone the [GitHub repo](https://github.com/ZW01f/Blink-To-Live), e.g. with `git clone https://github.com/ZW01f/Blink-To-Live.git`
3. Run **python CV-Model-final.py** 

## for application
Run the Flutter project on your real device, signup with your phone, Facebook, gmail or whatever you want, and then choose if you want to learn a language or if you want to understand the patient directly by opening the camera from the Understand the Patient screen and noticing the patient's face. The app will then show what the patient intends to say.

# Demo 
[177432185-6d5289a4-9874-4352-a8bd-5e8f86229225.webm](https://user-images.githubusercontent.com/55991929/192772981-43837977-e75a-4202-862d-d78e63fa9acc.webm)

# References
1. Sane, H. [Blink-To-Speak](https://www.blinktospeak.com/blink-to-speak-guide).
2. [Dlib C++ Library for Real-Time Face Pose Estimation](http://blog.dlib.net/2014/08/real-time-face-pose-estimation.html).
3. [Translate python library](https://pypi.org/project/translate/).
4. [Text to Speech Service by Microsoft Azure](https://azure.microsoft.com/en-in/services/cognitive-services/text-to-speech/).
5. [FastAPI](https://fastapi.tiangolo.com/).

  
