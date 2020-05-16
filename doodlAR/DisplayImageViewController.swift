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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.3421930969, green: 0.3176463246, blue: 0.8521707058, alpha: 1)
    }
    
    @IBAction func onDrawButtonTapped(_ sender: RoundButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ARViewController") as! ARViewController
        vc.setDisplayImage(self.displayImage)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func onDrawOnPaperButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ARPaperViewController") as! ARPaperViewController
//        vc.setDisplayImage(self.displayImage)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func setDisplayImage(_ image: UIImage) {
        self.displayImage = image
    }
}
