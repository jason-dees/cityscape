//
//  ViewController.swift
//  City Scape
//
//  Created by Jason Dees on 3/17/18.
//  Copyright © 2018 Jason Dees. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var sessionInfoView: UIView!
    @IBOutlet weak var sessionInfoLabel: UILabel!
    @IBOutlet weak var showHidePlanesButton: UIButton!

    var sceneDelegate : SceneDelegate!
    var sessionDelegate : SessionDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a new scene
        sceneDelegate = SceneDelegate()
        sessionDelegate = SessionDelegate(label: sessionInfoLabel, view: sessionInfoView)
        sceneView!.delegate = sceneDelegate
        sceneView!.session.delegate = sessionDelegate
        sceneView.showsStatistics = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal];
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    @IBAction func showHideButtonTouchUp(_ sender: Any) {
        sceneDelegate.showNewPlacements = !sceneDelegate.showNewPlacements
        
        let titleString = sceneDelegate.showNewPlacements ? "Hide Planes" : "Show Planes"
        showHidePlanesButton.setTitle(titleString, for: .normal)

    }
    
}
