//
//  ViewController.swift
//  Microscope
//
//  Created by David Haynes on 27/04/2019.
//  Copyright © 2019 MBP Consulting Ltd. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var captureSession: AVCaptureSession!

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: Calculate this based on the monitor resolution
        let width = CGFloat(640)
        let height = CGFloat(480)
        
        //TODO: Use this to position the window initiall in the centre of the screen
        let screenRect = NSScreen.main!.frame
        let xPos = (screenRect.width / 2.0) - (width / 2.0)
        let yPos = (screenRect.height / 2.0) - (height / 2.0)

        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.medium
        let webcamCaptureDevice = AVCaptureDevice.devices(for: .video)[0]
        let webcamInput = (try! AVCaptureDeviceInput(device: webcamCaptureDevice))
        captureSession.addInput(webcamInput)

        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer.frame = CGRect(x: -width, y: 0, width: width, height: height)

        let viewLayer = CALayer()
        viewLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        viewLayer.addSublayer(videoPreviewLayer)
        viewLayer.sublayerTransform = CATransform3DMakeScale(-1, 1, 1)

        view.wantsLayer = true
        view.layer = viewLayer

        captureSession.startRunning()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func viewDidDisappear() {
        captureSession.stopRunning()
    }
}
