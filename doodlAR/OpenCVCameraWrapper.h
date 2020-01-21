//
//  OpenCVCameraWrapper.h
//  doodlAR
//
//  Created by Eve Le on 1/20/20.
//  Copyright © 2020 Eve Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenCVCameraWrapper : NSObject
-(instancetype)initWithImageView:(UIImageView*)imageView;

/// Start the camera.
-(void)startCamera;

/// Stop the camera.
-(void)stopCamera;

-(void)setOverlayImage:(UIImage*)selectedImage;
@end

NS_ASSUME_NONNULL_END
