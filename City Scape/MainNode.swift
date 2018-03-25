//
//  GameNode.swift
//  City Scape
//
//  Created by Jason Dees on 3/25/18.
//  Copyright © 2018 Jason Dees. All rights reserved.
//

import Foundation
import ARKit

class MainNode : SCNNode {
    
    var shipNode : SCNNode!
    var planeNode : SCNNode!
    public private(set) var hasRendered: Bool =  false
    
    override init(){
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        shipNode = scene.rootNode.childNode(withName: "ship", recursively: false)
        planeNode = SCNNode()
        planeNode.name = "plane"
        planeNode?.eulerAngles.x = -.pi / 2
        planeNode?.opacity = 0.25
        
        self.addChildNode(shipNode)
        self.addChildNode(planeNode)
    }
    
    func setPosition(planeAnchor: ARPlaneAnchor) {
        
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        
        planeNode?.geometry = plane
        
        setPosition(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
        
        
        hasRendered = true
    }
    
    private func setPosition(x: Float, y: Float, z: Float){
        planeNode?.simdPosition = float3(x, y, z)
        shipNode?.simdPosition = float3(x, y, z)
    
    }

}
