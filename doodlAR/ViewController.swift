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

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        // sceneView.showsStatistics = true
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // enable horizontal plan detection
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}

// MARK: - ARSCNViewDelegate
extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
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
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
            guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
            guard let planeNode = node.childNodes.first else { return }
            guard let plane = planeNode.geometry as? SCNPlane else { return }

            // update plane height and width
            plane.width = CGFloat(planeAnchor.extent.x * 0.5)
            plane.height = CGFloat(planeAnchor.extent.z * 0.5)

            // position plane node
            planeNode.position = SCNVector3(CGFloat(planeAnchor.center.x),0.0,CGFloat(planeAnchor.center.z))
    }
}
