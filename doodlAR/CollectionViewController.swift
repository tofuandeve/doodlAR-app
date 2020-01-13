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
        self.navigationItem.title = "Library"
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 17)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
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
        vc.displayImage = UIImage(named: selectedImage["image"]!)!
        self.navigationController!.pushViewController(vc, animated: true)
    }
}
