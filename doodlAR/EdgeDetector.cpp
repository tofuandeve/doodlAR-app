//
//  EdgeDetector.cpp
//  doodlAR
//
//  Created by Eve Le on 1/20/20.
//  Copyright © 2020 Eve Le. All rights reserved.
//

#include "EdgeDetector.hpp"
#include <opencv2/imgproc.hpp>

void detectEdge(cv::Mat& cap) {
    cv::Mat image;
    image = cap;

    cv::Mat gray;
    cv::cvtColor(image, gray, cv::COLOR_RGB2GRAY); //Convert image to gray
    cv::GaussianBlur(gray, gray, cv::Size(5, 5), 0);

    cv::Mat edges;
    std::vector<std::vector<cv::Point>> contours;
    cv::Canny(gray, edges, 75, 200);

    cv::findContours(edges, contours, cv::RETR_CCOMP, cv::CHAIN_APPROX_SIMPLE);
    std::sort(contours.begin(), contours.end(), compareContourAreas);
    
    std::vector<std::vector<cv::Point>> largestContours;
    
    if (contours.size() > 5) {
        for(int i = 0; i < 5; ++i) {
            largestContours.push_back(contours[i]);
        }
    } else {
        largestContours = contours;
    }

    int centerX;
    int centerY;
    for(int i = 0; i < largestContours.size(); ++i)
    {
        double peri = cv::arcLength(largestContours[i], true);
        std::vector<cv::Point> approx;
        cv::approxPolyDP(largestContours[i], approx, 0.02*peri, true);

        if (approx.size() == 4)
        {
            cv::Moments moments;
            moments = cv::moments(contours[i]);
            centerX = (moments.m10 / moments.m00);
            centerY = (moments.m01 / moments.m00);
            
            std::vector<std::vector<cv::Point>> input;
            input.push_back(approx);
            
            cv::Scalar color(252, 224, 5, 255);
            cv::drawContours(image, input, 0, color, 2);
            cv::circle(image, cv::Point(centerX, centerY), 5, color);
            break;
        }
    }
}

bool compareContourAreas(const std::vector<cv::Point>& contour1, const std::vector<cv::Point>& contour2) {
    double i = fabs(cv::contourArea(cv::Mat(contour1)));
    double j = fabs(cv::contourArea(cv::Mat(contour2)));
    return (i > j);
}
