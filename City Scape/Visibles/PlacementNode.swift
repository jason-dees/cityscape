//
//  PlacementNode.swift
//  City Scape
//
//  Created by Jason Dees on 3/31/18.
//  Copyright © 2018 Jason Dees. All rights reserved.
//

import Foundation
import ARKit

class PlacementNode : SCNNode {
    
    var planeNode : SCNNode!
    public var hasRendered: Bool =  false
    
    override init(){
        super.init()
        setup()
        self.name = "PlaneNode"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    private func setup(){
        planeNode = SCNNode()
        planeNode.name = "plane"
        planeNode?.eulerAngles.x = -.pi / 2
        planeNode?.opacity = 0.25
        
        self.addChildNode(planeNode)
    }
    
    func setPosition(planeAnchor: ARPlaneAnchor) {
        
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        
        planeNode?.geometry = plane
        
        setPosition(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
    }
    
    private func setPosition(x: Float, y: Float, z: Float){
        planeNode?.simdPosition = float3(x, y, z)
    }
    
    override func removeFromParentNode() {
        self.removeFromParentNode()
        hasRendered = false;
    }
}
