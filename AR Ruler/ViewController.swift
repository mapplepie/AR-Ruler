//
//  ViewController.swift
//  AR Ruler
//
//  Created by Mai Uchida on 2021/11/29.
//

        import UIKit
        import RealityKit
        import ARKit
        import SceneKit

        class ViewController: UIViewController, ARSCNViewDelegate {

    var dotNodes = [SCNNode]()
            
            @IBOutlet var sceneView: ARSCNView!
            
        override func viewDidLoad() {
            super.viewDidLoad()
            
            sceneView.delegate = self
            
           
            sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            let configuration = ARWorldTrackingConfiguration()
            
            sceneView.session.run(configuration)
        }
            
            override func viewWillDisappear(_ animated: Bool) {
                super.viewWillDisappear(animated)
                
                sceneView.session.pause()
            }

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let touchLocation =  touches.first?.location(in: sceneView){
                let hitTestResults = sceneView.hitTest(touchLocation, types: .featurePoint)
                
                if let hitResult = hitTestResults.first{
                    addDot(at: hitResult)
                }
            }
        }

        func addDot(at hitResult : ARHitTestResult){
            let dotGeometry = SCNSphere(radius: 0.005)
            let material = SCNMaterial()
            material.diffuse.contents = UIColor.red
                dotGeometry.materials = [material]
           
            let dotNode = SCNNode(geometry: dotGeometry)
            
            dotNode.position = SCNVector3(x: hitResult.worldTransform.columns.3.x, y: hitResult.worldTransform.columns.3.y, z: hitResult.worldTransform.columns.3.z)
            
            
            sceneView.scene.rootNode.addChildNode(dotNode)
            
            dotNodes.append(dotNode)
            
            if dotNodes.count >= 2{
                calculate()
            }
        }
            func calculate(){
                let start = dotNodes[0]
                let end = dotNodes[1]
                
                let a = end.position.x - start.position.x
                let b = end.position.y - start.position.y
                let c = end.position.z - start.position.z
                
                let distance = sqrt(pow(a, 2) + pow(b, 2) + pow(c, 2))
                
                
//                distance = ??? ((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
            }
 }
