# DoodlAR

## Learning Goals
Major things that I want to focus on learning in this project
- Mobile development
- New language: Swift
- Computer vision: ARKit
- Computer graphics: CoreGraphics

## Problem Statement

Augmented reality drawing iOS app that makes creativity fun and accessible for everyone. The app allows users to place simple virtual images on any surface and lets users trace drawing from their phone. 

## Market Research
- [SketchAR] : SketchAR is a paid by subscription mobile app for teaching drawing using augmented reality, machine learning, and neural networks. The app puts virtual images on a paper/wall to let you trace drawings from your phone step by step. 

- [Tracer!] Lightbox tracing app: Tracer! Lightbox tracing app is an integrated tracing app for drawing and illustrating. This app is meant to be used with a physical paper for stencilling and drawing. 

- Non-app solution: Tracing paper

[SketchAR]: https://sketchar.tech/
[Tracer!]: https://play.google.com/store/apps/details?id=twitch.angelandroidapps.tracerlightbox&hl=en

- While SketchAR app is meant mainly for educational purpose and users need subscription (monthly/ yearly/ lifetime) to be able to access to most features, Tracer! app is used more as a lightbox. Users need to select a template picture, then place a tracing paper over it and begin tracing. Users cannot move the image around the screen, to centralize or focus on certain parts of big images.

- My product is empowered by AR and provides a different experience with more flexibility than Tracer! where users are able to trace photos and sketches on different surfaces and sizes.

- Compared to SketchAR, although the functionality is similar, my product will be focusing more on making drawing a fun experience as opposed to step-by-step instructional lessons AND it will be FREE.


## Target Audience

- My main target users are for everyone from professional artists to enthusiasts who love to draw.


## Technologies

- Back-end Technology
    - N/A at the moment. For future improvements, we can discuss a way to store/share user sketches, but this is not part of the MVP.
- Front-end Technology
    - Language: Swift (maybe some C++) 
    - For basic UI rendering: UIKit
    - For objects rendering in 3D surface: ARKit, SceneKit
    - For image processing algorithms : CoreGraphics
- Infrastructure
  - Apple App Store will host my application and I will use it to deploy applications to my users.

## Wireframes
<a href="https://imgur.com/Re1j31I"><img src="https://i.imgur.com/Re1j31I.jpg" title="source: imgur.com" /></a>

## MVP Feature Set
1.  Detect a surface using ARKit
    - Users can use phone camera to detect a flat surface
1.  Select a 2D simple image
    - Users can choose a 2D image from a provided list of images
1.  Place image on surface
    - Users display selected image virtually on the surface detected by phone camera
    - Enable world tracking functionality: create a correspondence between real surface and virtual images which allows users to view sketch images from different angle when camera position changes (user can only move their camera)

### Potential Additional Features
1.  Detect a white paper on a dark color surface
    - Users can use phone camera to detect a paper on flat surface
    - Users display selected image virtually on the paper detected by phone camera
    - Enable world tracking functionality: user can move both camera and paper
1.  Allows users to import images from photo library
    - Users can import images from photo library
    - Users can display their own images on a surface
1.  Create their own sketch
    - Users can choose to process imported images to create sketch using edge detection
    - Users can choose to display their own sketch on surface