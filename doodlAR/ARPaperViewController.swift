//
//  ARPaperViewController.swift
//  doodlAR
//
//  Created by Eve Le on 1/13/20.
//  Copyright © 2020 Eve Le. All rights reserved.
//

import UIKit

class ARPaperViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    private var cvCamera: OpenCVCameraWrapper!
    private var selectedImage:UIImage!
    
    deinit {
        cvCamera.stopCamera()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvCamera = OpenCVCameraWrapper(imageView:self.imageView)
        cvCamera.startCamera()
//        cvCamera.setOverlayImage(selectedImage)
    }
    
    func setSelectedImage(_ image:UIImage) {
        self.selectedImage = image
    }
}
