//
//  ViewController.swift
//  metal_tut
//
//  Created by Joseph Utecht on 8/20/18.
//  Copyright © 2018 Joseph Utecht. All rights reserved.
//

import Cocoa
import Metal
import MetalKit

class ViewController: NSViewController {
    var mtkView: MTKView!
    var renderer: Renderer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let mtkViewTemp = self.view as? MTKView else {
            print("View attached incorrectly")
            return
        }
        mtkView = mtkViewTemp
        
        guard let defaultDevice = MTLCreateSystemDefaultDevice() else {
            print("Metal not supported or something")
            return
        }
        print("GPU is \(defaultDevice)")
        mtkView.device = defaultDevice
        
        guard let tempRenderer = Renderer(mtkView: mtkView) else {
            print("renderer failed to init")
            return
        }
        renderer = tempRenderer
        mtkView.delegate = renderer
    }
    
    override func magnify(with event: NSEvent) {
        let x = Float(event.locationInWindow.x * 2) / Float(mtkView.drawableSize.width)
        let y = Float(event.locationInWindow.y * 2) / Float(mtkView.drawableSize.height)
        renderer.zoom(center: [x, 1 - y], speed: Float(event.magnification))
    }
    
    override func scrollWheel(with event: NSEvent) {
        renderer.pan(pan_x: event.deltaX, pan_y: event.deltaY)
    }
    
    @IBAction func toggle_rotation(_ sender: NSMenuItem) {
        renderer.should_rotate = !renderer.should_rotate
        sender.isEnabled = renderer.should_rotate
    }
    
}


