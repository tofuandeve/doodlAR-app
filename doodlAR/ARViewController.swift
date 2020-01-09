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
    var isPlaced = false
    var displayImage = UIImage(named: "studioGhibli")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        // Create a new scene and set to view
        let scene = SCNScene()
        sceneView.scene = scene
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        sceneView.addGestureRecognizer(gestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    @objc func tapped(withGestureRecognizer recognizer: UITapGestureRecognizer) {
        // Get 2D position of touch event on screen
        let tapPosition = recognizer.location(in: sceneView)

        // Translate those 2D points to 3D points using hitTest (existing plane)
        let hitTestResults = sceneView.hitTest(tapPosition, types: .existingPlaneUsingExtent)

        // Get hitTest results and ensure that the hitTest corresponds to a grid that has been placed on a wall
        guard let hitTest = hitTestResults.first else { return }
        // guard let anchor = hitTest.anchor as? ARPlaneAnchor else { return }
        // guard let gridIndex = grids.index(where: { $0.anchor == anchor }) else { return }
        
        placeImage(hitTest)
        
        self.isPlaced = true
    }
    
    func placeImage(_ hitResult: ARHitTestResult) {
        if !(self.isPlaced) {
            let planeGeometry = SCNPlane()
            let material = SCNMaterial()
            material.diffuse.contents = displayImage
            planeGeometry.materials = [material]

            let imageNode = SCNNode(geometry: planeGeometry)
            imageNode.transform = SCNMatrix4(hitResult.anchor!.transform)
            imageNode.eulerAngles = SCNVector3(imageNode.eulerAngles.x + (-Float.pi / 2), imageNode.eulerAngles.y, imageNode.eulerAngles.z)
            imageNode.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)

            let scene = SCNScene()
            sceneView.scene = scene
            sceneView.scene.rootNode.addChildNode(imageNode)
        }
    }
    
}

// MARK: - ARSCNViewDelegate
extension ARViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if (!self.isPlaced) {
            // cast anchor to type ARPlaneAnchor
            guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
            
            // create a plane with height and width
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x * 0.5), height: CGFloat(planeAnchor.extent.z * 0.5))
            
            // add material to plane
            plane.materials.first?.diffuse.contents = UIImage(named:"overlay_grid.png")
            
            // create a plane Node
            let planeNode = SCNNode(geometry: plane)
            
            // position plane node
            planeNode.position = SCNVector3(CGFloat(planeAnchor.center.x),0.0,CGFloat(planeAnchor.center.z))
            
            planeNode.transform = SCNMatrix4MakeRotation(Float(-.pi / 2.0), 1.0, 0.0, 0.0);
            
            node.addChildNode(planeNode)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if(!self.isPlaced) {
            guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
            guard let planeNode = node.childNodes.first else { return }
            guard let plane = planeNode.geometry as? SCNPlane else { return }

            // update plane height and width
            plane.width = CGFloat(planeAnchor.extent.x)
            plane.height = CGFloat(planeAnchor.extent.z)

            // position plane node
            planeNode.position = SCNVector3(CGFloat(planeAnchor.center.x),0.0,CGFloat(planeAnchor.center.z))
        }
    }
}