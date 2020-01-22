# DoodlAR

## Learning Goals
Major things that I want to focus on learning in this project
- Mobile development
- New language: Swift
- Computer vision: ARKit
- Computer graphics: CoreGraphics

## Problem Statement

Augmented reality drawing iOS app that makes creativity fun and accessible for everyone. The app allows users to place simple virtual images on any surface and lets users trace drawing from their phone. 

## Target Audience

- My main target users are for everyone from professional artists to enthusiasts who love to draw.

## Technologies

- Back-end Technology
    - N/A at the moment. For future improvements, we can discuss a way to store/share user sketches, but this is not part of the MVP.
- Front-end Technology
    - Languages: Swift, C++
    - For basic UI rendering: UIKit
    - For objects rendering in 3D surface: ARKit, SceneKit
    - For image processing algorithms : CoreGraphics
- Infrastructure
  - Apple App Store will host my application and I will use it to deploy applications to my users.

<p align="center">
  <img height="300" src="https://media.giphy.com/media/UtJb45Hl1rdiWHnRRb/giphy.gif">
  <img height="300" src="https://media.giphy.com/media/JR0zNQUmqeiRzcm1ag/giphy.gif">
  <img height="300" src="https://media.giphy.com/media/JQGsEtxlqmcIlAzlcM/giphy.gif">
  <img height="300" src="https://media.giphy.com/media/Kcne7KBwY5x7byw28R/giphy.gif">
  <br> 
</p>


## MVP Feature Set
1.  Detect a surface using ARKit
    - Users can use phone camera to detect a flat surface
1.  Select a 2D simple image
    - Users can choose a 2D image from a provided list of images
1.  Place image on surface
    - Users display selected image virtually on the surface detected by phone camera
    - Enable world tracking functionality: create a correspondence between real surface and virtual images which allows users to view sketch images from different angle when camera position changes (user can only move their camera)

## Enhancement feature: Paper detection
<p align="center">
  <img height="400" src="https://media.giphy.com/media/XdDyKEkeZnBmPshDp7/giphy.gif">
  <img height="400" src="https://media.giphy.com/media/XD4beHyoGZvHAwdzHS/giphy.gif">
  <br> 
</p>

## Set up
1. XCode Version 11.3 
1. Download the OpenCV 4.2.0 framework for iOS: http://opencv.org and import OpenCV in the project under folder named Frameworks