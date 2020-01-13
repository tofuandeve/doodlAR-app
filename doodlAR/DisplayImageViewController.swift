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
    private var displayImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayImageView.image = displayImage
        setTranslucentNavigationBar()
    }
    
    @IBAction func onDrawButtonTapped(_ sender: RoundButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ARViewController") as! ARViewController
        vc.setDisplayImage(self.displayImage)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func setDisplayImage(_ image: UIImage) {
        self.displayImage = image
    }
    
    // TODO: THIS SHOULD BE PUT IN A HELPER FILE
    private func setTranslucentNavigationBar() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
    }
}
