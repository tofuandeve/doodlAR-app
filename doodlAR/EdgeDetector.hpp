//
//  EdgeDetector.hpp
//  doodlAR
//
//  Created by Eve Le on 1/20/20.
//  Copyright © 2020 Eve Le. All rights reserved.
//

#ifndef EdgeDetector_hpp
#define EdgeDetector_hpp


#include <opencv2/core.hpp>
#include <opencv2/videoio.hpp>
#include <opencv2/highgui.hpp>
#include <iostream>
#include <stdio.h>

extern void detectEdge(cv::Mat& cap);

extern bool compareContourAreas(const std::vector<cv::Point>& contour1, const std::vector<cv::Point>& contour2);

#endif /* EdgeDetector_hpp */
