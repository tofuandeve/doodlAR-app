//
//  OpenCVCameraWrapper.m
//  doodlAR
//
//  Created by Eve Le on 1/20/20.
//  Copyright © 2020 Eve Le. All rights reserved.
//

#import "OpenCVCameraWrapper.h"
#import "EdgeDetector.hpp"
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/imgproc.hpp>

@interface OpenCVCameraWrapper () <CvVideoCameraDelegate>
@end

@implementation OpenCVCameraWrapper
{
    CvVideoCamera* _videoCamera;
}

-(instancetype)initWithImageView:(UIImageView*)imageView {
    if(self = [super init]) {
        _videoCamera = [[CvVideoCamera alloc] initWithParentView:imageView];
        
        _videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
        _videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset1280x720;
        _videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
        _videoCamera.defaultFPS = 30;
        _videoCamera.grayscaleMode = NO;
        
        _videoCamera.delegate = self;
    }
    return self;
        
}

- (void)processImage:(cv::Mat&)image
{
    detectEdge(image);
}

-(void)startCamera
{
    [_videoCamera start];
}

-(void)stopCamera
{
    [_videoCamera stop];
}

-(void)setOverlayImage:(UIImage*)selectedImage
{
}
@end
