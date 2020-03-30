//
//  AppDelegate.swift
//  Microscope
//
//  Created by David Haynes on 27/04/2019.
//  Copyright © 2019 MBP Consulting Ltd. All rights reserved.
//

import Cocoa
import AVFoundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var panel: NSPanel!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var captureSession: AVCaptureSession!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let screenRect = NSScreen.main!.frame
        let width = CGFloat(1920)
        let height = CGFloat(1080)
        let xPos = (screenRect.width / 2.0) - (width / 2.0)
        let yPos = (screenRect.height / 2.0) - (height / 2.0)

        panel = NSPanel(
            contentRect: NSRect(x: xPos, y: yPos, width: width, height: height),
            styleMask: NSWindow.StyleMask.nonactivatingPanel,
            backing: NSWindow.BackingStoreType.buffered,
            defer: false
        )

        let lvl_key = CGWindowLevelKey.maximumWindow
        let lvl = CGWindowLevelForKey(lvl_key)
        panel.level = NSWindow.Level(rawValue: Int(lvl))
        panel.orderFront(nil)

        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.medium
        let webcamCaptureDevice = AVCaptureDevice.devices(for: .video)[1]
        let webcamInput = (try! AVCaptureDeviceInput(device: webcamCaptureDevice))
        captureSession.addInput(webcamInput)

        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer.frame = CGRect(x: -width, y: 0, width: width, height: height)

        let viewLayer = CALayer()
        viewLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        viewLayer.addSublayer(videoPreviewLayer)
        viewLayer.sublayerTransform = CATransform3DMakeScale(-1, 1, 1)

        let view = NSView(frame: NSRect(x: 0, y: 0, width: width, height: height))
        view.wantsLayer = true
        view.layer = viewLayer
        panel.contentView = view

        captureSession.startRunning()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        captureSession.stopRunning()
    }
}

