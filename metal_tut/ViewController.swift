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
        let x = Float(event.locationInWindow.x) / Float(mtkView.drawableSize.width)
        let y = Float(event.locationInWindow.y) / Float(mtkView.drawableSize.height)
        renderer.zoom(center: [x, y], speed: Float(event.magnification))
    }
    
    override func scrollWheel(with event: NSEvent) {
        renderer.pan(pan_x: event.deltaX, pan_y: event.deltaY)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}


