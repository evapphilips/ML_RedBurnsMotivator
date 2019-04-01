//
//  ViewController.swift
//  redBurnsMotivator
//
//  Created by Eva Philips on 3/30/19.
//  Copyright © 2019 evaphilips. All rights reserved.
//


import UIKit
import SceneKit
import ARKit

// define a motivation array
let motivate: [String] = ["understand questions before you go looking for answers", "provoke the unexpected - expect it", "that poetry drives you, not hardware", "that you are willing to risk, make mistakes, and learn from failure", "think of technology as a verb, not a noun. It provides the tools. Creative people provide imagination"]

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
//        // Show statistics such as fps and timing information
//        sceneView.showsStatistics = true
//
//        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
//        // Set the scene to the view
//        sceneView.scene = scene
        
//        // set text and extrusion thickeness
//        let text = SCNText(string: "Hello World", extrusionDepth: 0.2)
//        text.flatness = 0.005
//
//        // set text color
//        let material = SCNMaterial()
//        material.diffuse.contents = UIColor.gray
//        text.materials = [material]
//
//        // position tet in space
//        let node = SCNNode()
//        node.position = SCNVector3(0, 0.02, -0.1)
//        node.scale = SCNVector3(0.01, 0.01, 0.01)
//        node.geometry = text
//
//        // add text to the scene
//        sceneView.scene.rootNode.addChildNode(node)
//        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    // get position on touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let result = sceneView.hitTest(touch.location(in: sceneView), types: [ARHitTestResult.ResultType.featurePoint])
        guard let hitResult = result.last else {return}
        let hitTransform = SCNMatrix4.init(hitResult.worldTransform)
        let hitVector = SCNVector3Make(hitTransform.m41, hitTransform.m42, hitTransform.m43)
        addText(position: hitVector)
    }
    
    // add text to the sceen
    func addText(position: SCNVector3){
        // pick a random motivational quote
        let index = Int.random(in: 0 ..< motivate.count)
        //print(index)
        
        
        // set text and extrusion thickeness
        //let text = SCNText(string: "Hello World", extrusionDepth: 0.2)
        let text = SCNText(string: motivate[index], extrusionDepth: 0.2)
        text.flatness = 0.005
        
        // set text color
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.gray
        text.materials = [material]
        
        // position tet in space
        let node = SCNNode()
        node.position = SCNVector3(position.x, position.y, position.z)
        node.scale = SCNVector3(0.01, 0.01, 0.01)
        node.geometry = text
        
        // add text to the scene
        sceneView.scene.rootNode.addChildNode(node)
        sceneView.autoenablesDefaultLighting = true
        
    }
}
