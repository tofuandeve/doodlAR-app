//
//  ViewController.swift
//  doodlAR
//
//  Created by Eve Le on 1/6/20.
//  Copyright © 2020 Eve Le. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    private var isPlaced = false
    private var displayImage = UIImage(named: "studioGhibli")
    
    @IBOutlet weak var displayText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        toggleShowFeaturePoints()
        setSceneViewToNewScene()
        
        displayText.text = "Tap to place image"
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        sceneView.addGestureRecognizer(gestureRecognizer)
        setTranslucentNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableWorldTracking()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    @objc func tapped(withGestureRecognizer recognizer: UITapGestureRecognizer) {
        let tapPosition = recognizer.location(in: sceneView)

        let hitTestResults = sceneView.hitTest(tapPosition, types: .existingPlaneUsingExtent)
        guard let hitTest = hitTestResults.first else { return }
        placeImage(hitTest)
        
        self.isPlaced = true
        toggleShowFeaturePoints()
        displayText.text = ""
    }
    
    func setDisplayImage(_ image: UIImage) {
        self.displayImage = image
    }
    
    private func placeImage(_ hitResult: ARHitTestResult) {
        if !(self.isPlaced) {
            let planeGeometry = SCNPlane(width: CGFloat(0.1), height: CGFloat(0.1))
            let material = SCNMaterial()
            material.diffuse.contents = displayImage?.alpha(0.7)
            planeGeometry.materials = [material]

            let imageNode = SCNNode(geometry: planeGeometry)
            imageNode.transform = SCNMatrix4(hitResult.anchor!.transform)
            imageNode.eulerAngles = SCNVector3(imageNode.eulerAngles.x + (-Float.pi / 2), imageNode.eulerAngles.y, imageNode.eulerAngles.z)
            imageNode.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)

            setSceneViewToNewScene()
            sceneView.scene.rootNode.addChildNode(imageNode)
        }
    }
    
    private func enableWorldTracking() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    private func toggleShowFeaturePoints() {
        sceneView.debugOptions = self.isPlaced ? [] : [ARSCNDebugOptions.showFeaturePoints]
    }
    
    private func setSceneViewToNewScene() {
        let scene = SCNScene()
        sceneView.scene = scene
    }
    
    // TODO: THIS SHOULD BE PUT IN A HELPER FILE
    private func setTranslucentNavigationBar() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
    }
}

// MARK: - ARSCNViewDelegate
extension ARViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if (!self.isPlaced) {
            guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
            
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x * 0.5), height: CGFloat(planeAnchor.extent.z * 0.5))
            plane.materials.first?.diffuse.contents = UIImage(named:"overlay_grid.png")
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.position = SCNVector3(CGFloat(planeAnchor.center.x),0.0,CGFloat(planeAnchor.center.z))
            planeNode.transform = SCNMatrix4MakeRotation(Float(-.pi / 2.0), 1.0, 0.0, 0.0);
            node.addChildNode(planeNode)     
        }
    }
    
//    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
//        if(!self.isPlaced) {
//            guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
//            guard let planeNode = node.childNodes.first else { return }
//            guard let plane = planeNode.geometry as? SCNPlane else { return }
//
//            // update plane height and width
//            plane.width = CGFloat(planeAnchor.extent.x)
//            plane.height = CGFloat(planeAnchor.extent.z)
//            // position plane node
//            planeNode.position = SCNVector3(CGFloat(planeAnchor.center.x),0.0,CGFloat(planeAnchor.center.z))
//        }
//    }
}
