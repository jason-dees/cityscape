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
        shipNode = scene.rootNode
        planeNode = SCNNode()
        planeNode.name = "plane"
        planeNode?.eulerAngles.x = -.pi / 2
        planeNode?.opacity = 0.25
        
        self.addChildNode(shipNode)
        self.addChildNode(planeNode)
        let constraint = SCNTransformConstraint(inWorldSpace: false, with:{
            node, transformMatrix in
            
            let width = self.nodeWidth(node: self.planeNode)
            let height = self.nodeHeight(node: self.planeNode)
            let shipWidth = self.nodeWidth(node: node)
            let shipHeight = self.nodeHeight(node: node)
            var scale = width/shipWidth
            if(width > height){
                scale = height/shipHeight
            }
            node.scale = SCNVector3(scale, scale, scale)
            node.position = self.planeNode.position
            return node.transform
            })
        shipNode.constraints = [constraint]
    }
    
    func setPosition(planeAnchor: ARPlaneAnchor) {
        
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        
        planeNode?.geometry = plane
        
        hasRendered = true
    }
    
    private func nodeWidth(node: SCNNode) -> Float{
        let boundingMax = node.boundingBox.max
        let boundingMin = node.boundingBox.min
        return boundingMax.x + abs(boundingMin.x)
    }
    
    private func nodeHeight(node : SCNNode) -> Float{
        let boundingMax = node.boundingBox.max
        let boundingMin = node.boundingBox.min
        return boundingMax.y + abs(boundingMin.y)
    }

}
