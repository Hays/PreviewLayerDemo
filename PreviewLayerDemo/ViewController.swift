//
//  ViewController.swift
//  PreviewLayerDemo
//
//  Created by 黄文希 on 2018/7/12.
//  Copyright © 2018 Hays. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {
    
    @IBOutlet weak var markView: NSView!
    @IBOutlet weak var previewView: NSView!
    var previewLayer:AVCaptureVideoPreviewLayer?
    let session = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        markView.layer?.backgroundColor = NSColor.red.cgColor
        
        // config capture session
        if let videoDevice = AVCaptureDevice.default(for: AVMediaType.video) {
            session.beginConfiguration()
            let videoInput = try? AVCaptureDeviceInput.init(device: videoDevice)
            if videoDevice.supportsSessionPreset(session.sessionPreset) {
                session.sessionPreset = AVCaptureSession.Preset.high
            }
            session.addInput(videoInput!)
            session.commitConfiguration()
        }

        // config preview layer
        let previewViewLayer = previewView.layer
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.connection?.automaticallyAdjustsVideoMirroring = false
        previewLayer?.connection?.isVideoMirrored = true
        previewLayer?.frame = (previewViewLayer?.bounds)!
        previewLayer?.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
        previewViewLayer?.addSublayer(previewLayer!)
        
        // start capture
        session.startRunning()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

