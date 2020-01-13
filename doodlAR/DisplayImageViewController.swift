//
//  DisplayImageViewController.swift
//  doodlAR
//
//  Created by Eve Le on 1/12/20.
//  Copyright © 2020 Eve Le. All rights reserved.
//

import UIKit

class DisplayImageViewController: UIViewController {

    @IBOutlet weak var displayImageView: UIImageView!
    var displayImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayImageView.image = displayImage
    }
    
    @IBAction func onDrawButtonTapped(_ sender: RoundButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ARViewController") as! ARViewController
        vc.displayImage = self.displayImage
        self.navigationController!.pushViewController(vc, animated: true)
    }
}
