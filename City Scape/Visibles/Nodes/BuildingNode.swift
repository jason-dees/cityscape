//
//  BuildingNode.swift
//  City Scape
//
//  Created by Jason Dees on 5/28/18.
//  Copyright © 2018 Jason Dees. All rights reserved.
//

import Foundation
import ARKit

class BuildingNode : SCNNode {
    var building : BuildingBox!
    
    override init(){
        super.init()
        building = BuildingBox.init(width: 1.0, height: 2.0, length: 1.0, chamferRadius: 0.0)
        building.diffuseColor = UIColor.blue
        building.metalnessColor = UIColor.cyan
        
        self.geometry = building
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func size(width: NSFloat, height: NSFloat, length: NSFloat){
        
    }
}
