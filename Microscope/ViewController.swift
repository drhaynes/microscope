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
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        let lastVideoCaptureDevice = AVCaptureDevice.devices(for: .video).first!
        let videoCaptureInput = (try! AVCaptureDeviceInput(device: lastVideoCaptureDevice))
        captureSession.addInput(videoCaptureInput)
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.wantsLayer = true
        view.layer = videoPreviewLayer
        view.layer?.backgroundColor = .black
        captureSession.startRunning()
    }

    override func viewDidDisappear() {
        captureSession.stopRunning()
    }
}
