//
//  CollectionViewController.swift
//  doodlAR
//
//  Created by Eve Le on 1/7/20.
//  Copyright © 2020 Eve Le. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    var images = [[String:String]]()

    private func loadImages() -> [[String:String]] {
        let path = Bundle.main.path(forResource: "defaultImages", ofType: "plist")
        return NSArray.init(contentsOf: URL.init(fileURLWithPath: path!)) as! [[String:String]]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.images = loadImages()
        setNavigationBarStyle(withTitle: "Library")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.3421930969, green: 0.3176463246, blue: 0.8521707058, alpha: 1)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        let image = self.images[indexPath.row]
        cell.cellImageView.image = UIImage(named: image["image"]!)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = self.images[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DisplayImageView") as! DisplayImageViewController
        vc.setDisplayImage(UIImage(named: selectedImage["image"]!)!)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    private func setNavigationBarStyle(withTitle navBarTitle: String?) {
        self.navigationItem.title = navBarTitle
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 20)!, NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
}
