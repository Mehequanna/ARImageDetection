//
//  ViewController.swift
//  imageDetection
//
//  Created by Stephen Emery on 2/3/19.
//  Copyright © 2019 Stephen Emery. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var siri = AVSpeechSynthesizer()
    
    let contentFor = [
        "Water Lily Pond" : "Water Lily Pond by Claude Monet. In 1883 Monet moved to Giverny where he lived until his death. There, on the grounds of his property, he created a water garden 'for the purpose of cultivating aquatic plants', over which he built an arched bridge in the Japanese style. In 1899, once the garden had matured, the painter undertook 17 views of the motif under differing light conditions. Surrounded by luxuriant foliage, the bridge is seen here from the pond itself, among an artful arrangement of reeds and willow leaves.",
        "Surprised!" : "Surprised! by Henri Rousseau. This jungle scene was painted by the French artist, Henri Rousseau, in 1891, and is signed in the bottom left corner. Rousseau is now famous for his jungle scenes, although it is thought that he never actually visited a jungle – rather, he took his inspiration from trips to the Jardin des Plantes, the botanical gardens in Paris, and from prints and illustrated books. Rousseau later described the painting as representing a tiger pursuing explorers, but he may originally have intended the 'surprise' to be the sudden tropical storm breaking in the sky above the tiger. We can see long streaks of lightening, and imagine the rumble of thunder. Stripes govern the whole design, in tones of green, yellow, orange, brown and red, and the tiger is well camouflaged amongst the lush foliage.",
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = ARReferenceImage.referenceImages(inGroupNamed: "paintings", bundle: nil)

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else {return}
        let image = imageAnchor.referenceImage
        print(image.name)
        
        guard let imageName = image.name, let content = contentFor[imageName] else {return}
        say(what: content)
    }
    
    func say(what description: String) {
        siri.stopSpeaking(at: .immediate)
        let content = AVSpeechUtterance(string: description)
        siri.speak(content)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}
