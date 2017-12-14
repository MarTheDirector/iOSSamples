//
//  cameraViewController.swift
//  FAIT
//
//  Created by Mar Nesbitt on 5/26/15.
//  Copyright (c) 2015 FAIT App. All rights reserved.
//
import UIKit
import AVFoundation
import Photos

class videoViewController: UIViewController {
    
    
    var pageIndex: Int!
    var switchImage: String!
    var imageFile: String!
    
    @IBOutlet weak var backToAlbums: UIButton!
    
    @IBOutlet weak var cameraBottomBar: UIView!
    
   
    @IBOutlet weak var captureButton: UIButton!
    
    
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var captureForCamera: UIView!
    
    var selectedDevice: AVCaptureDevice? = nil;
    var observer:NSObjectProtocol? = nil;
    
    let captureSession = AVCaptureSession()
    
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    
    var stillImageOutput: AVCaptureStillImageOutput?
    let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    
    
    // If we find a device we'll store it here for later use
    var captureDevice : AVCaptureDevice?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.switchButton.setImage(UIImage(named: self.imageFile), forState: .Normal)
        self.captureButton.setImage(UIImage(named: self.imageFile), forState: .Normal)
        // Do any additional setup after loading the view, typically from a nib.
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        let devices = AVCaptureDevice.devices()
        
        // Loop through all the capture devices on this phone
        for device in devices {
            // Make sure this particular device supports video
            if (device.hasMediaType(AVMediaTypeVideo)) {
                // Finally check the position and confirm we've got the back camera
                if(device.position == AVCaptureDevicePosition.Back) {
                    captureDevice = device as? AVCaptureDevice
                    if captureDevice != nil {
                        // println("Capture device found")
                        beginSession()
                    }
                }
            }
        }
        
        //setting up options to grab the last image from camera roll and redisplay it
        var fetchOptions: PHFetchOptions = PHFetchOptions()
        
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        var fetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: fetchOptions)
        
        
        if (fetchResult.lastObject != nil) {
            var lastAsset: PHAsset = fetchResult.lastObject as! PHAsset
            PHImageManager.defaultManager().requestImageForAsset(lastAsset, targetSize: self.backToAlbums.bounds.size, contentMode: PHImageContentMode.AspectFill, options: PHImageRequestOptions(), resultHandler: { (result, info) -> Void in
                
                self.backToAlbums.setImage(result, forState: .Normal)
                self.backToAlbums.addTarget(self, action: "btnTouched:", forControlEvents:.TouchUpInside)
            })
            
            
            //setting up blur to use for background opacity
            //only apply the blur if the user hasn't disabled transparency effects
            if !UIAccessibilityIsReduceTransparencyEnabled() {
                let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
                //let blurStyle = UIBlurEffectStyle()
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                
                let vibrancyView =  UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
                vibrancyView.setTranslatesAutoresizingMaskIntoConstraints(false)
                blurEffectView.contentView.addSubview(vibrancyView)
                
                
                //let vibrancyView = UIVibrancyEffect(effect: vibrancyEffect)
                
                //vibrancyView.setTranslatesAutoresizingMaskIntoConstraints(false)
                
                //blurEffectView.contentView.addSubview(vibrancyView)
                
                //blurEffectView.frame = self.cameraBottomBar.frame //view is self.view in a UIViewController
                blurEffectView.frame = CGRectMake(0,0,self.cameraBottomBar.frame.width, self.cameraBottomBar.frame.height);
                view.addSubview(blurEffectView)
                view.insertSubview(blurEffectView, atIndex: 0)
                //if you have more UIViews on screen, use insertSubview:belowSubview: to place it underneath the lowest view
                
                //add auto layout constraints so that the blur fills the screen upon rotating device
                blurEffectView.setTranslatesAutoresizingMaskIntoConstraints(false)
                /*view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))*/
                view.addConstraint(NSLayoutConstraint(
                    item:blurEffectView, attribute:.Height,
                    relatedBy:.Equal, toItem:view,
                    attribute:.Height,multiplier:0, constant: 60))
                
                view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
                view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
                view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
            } else {
                view.backgroundColor = UIColor.blackColor()
            }
            
            
            //setting up equally spaced buttons for equally space horizontally
            
            
            
        }
        
        
    }
    
    
    
    func focusTo(value : Float) {
        if let device = captureDevice {
            if(device.lockForConfiguration(nil)) {
                device.setFocusModeLockedWithLensPosition(value, completionHandler: { (time) -> Void in
                    //
                })
                device.unlockForConfiguration()
            }
        }
    }
    
    
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        //var anyTouch = touches.anyObject() as! UITouch
        
        var anyTouch = touches.first! as! UITouch
        var touchPercent = anyTouch.locationInView(self.view).x / screenWidth
        focusTo(Float(touchPercent))
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        //var anyTouch = touches.anyObject() as! UITouch
        var anyTouch = touches.first! as! UITouch
        var touchPercent = anyTouch.locationInView(self.view).x / screenWidth
        focusTo(Float(touchPercent))
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator);
        if let layer = previewLayer {
            layer.frame = CGRectMake(0,0,size.width, size.height);
        }
    }
    
    
    
    
    func configureDevice() {
        if let device = captureDevice {
            device.lockForConfiguration(nil)
            device.focusMode = .Locked
            device.unlockForConfiguration()
        }
        
    }
    
    
    func beginSession() {
        
        configureDevice()
        
        var err : NSError? = nil
        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
        
        if err != nil {
            println("error: \(err?.localizedDescription)")
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        
        
        self.view.layer.addSublayer(previewLayer)
        previewLayer?.frame = self.view.layer.frame
        previewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        captureSession.startRunning()
    }
    
    
    
    
    
}