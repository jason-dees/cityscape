//
//  SceneDelegate.swift
//  City Scape
//
//  Created by Jason Dees on 4/1/18.
//  Copyright © 2018 Jason Dees. All rights reserved.
//

import Foundation
import ARKit

class SceneDelegate : NSObject, ARSCNViewDelegate {
    
    var _showNewPlacements : Bool = false
    public var showNewPlacements: Bool {
        get {
            return _showNewPlacements
        }
        set(newShowNewPlacements) {
            _showNewPlacements = newShowNewPlacements
            if(_showNewPlacements){
                self.showOtherPlanes()
            }
            else{
                self.hideOtherPlanes()
            }
        }
    }
    
    var mainNode : MainNode!
    var otherPlanes : Array<PlacementNode> = Array()
    
    override init(){
        mainNode = MainNode()
        mainNode.name = "MainNode"
    }
    
    // MARK: - ARSCNViewDelegate
    
    
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // Place content only for anchors found by plane detection.
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // Create a SceneKit plane to visualize the plane anchor using its position and extent.
        
        if(!mainNode.hasRendered){
            mainNode.setPosition(planeAnchor: planeAnchor)
            node.addChildNode(mainNode)
            return
        }
        let newNode = PlacementNode()
        newNode.setPosition(planeAnchor: planeAnchor)
        otherPlanes.append(newNode)
        newNode.isHidden = !showNewPlacements
        node.addChildNode(newNode)
    }
    
    /// - Tag: UpdateARContent
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // Update content only for plane anchors and nodes matching the setup created in `renderer(_:didAdd:for:)`.
    }
    
    func hideOtherPlanes(){
        for otherPlane in otherPlanes{
            otherPlane.isHidden = true
        }
    }
    
    
    func showOtherPlanes(){
        for otherPlane in otherPlanes.filter({ !$0.hasRendered }) {
            otherPlane.isHidden = false
        }
    }
}
