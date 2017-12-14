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
import AssetsLibrary



class cameraViewController: UIViewController {
    
   
    
    // MARK: - Constants
    
    let cameraManager = CameraManager.sharedInstance


    //variable that's keeping track of flash state look
 
    let flashOn = UIImage(named:"flashOn.png")
    let flashOff = UIImage(named:"flashOff.png")
    
    //variable that's keeping track of camera position look
    
    let cameraFront = UIImage(named:"frontcamera.png")
    let cameraBack = UIImage(named:"backcamera.png")
   
    //variables that set up camera switch buttons
    
    let cameraButton = UIImage(named: "switchtopic.png")
    let videoButton = UIImage(named: "videoswitch.png")
    
    //variable that's keeping track of capture button look
    
    let takePicture = UIImage(named: "takeAVideo.png")
    let takeVideo = UIImage(named: "takeAPicture.png")
    
    //setting up config must haves for camera
    var selectedDevice: AVCaptureDevice? = nil;
    var observer:NSObjectProtocol? = nil;
    //let captureSession = AVCaptureSession()
    var captureSession: AVCaptureSession?
    var previewLayer : AVCaptureVideoPreviewLayer!
    var stillImageOutput: AVCaptureStillImageOutput?
    var captureDevice : AVCaptureDevice?
    
    @IBOutlet weak var askForPermissionsLabel: UILabel!
   
    @IBOutlet weak var flashSwitch: UIButton!
   
    @IBAction func flashSwitch(sender: UIButton) {
        switch (self.cameraManager.changeFlashMode()) {
        case .Off:
            flashSwitch.setImage(flashOff,forState:UIControlState.Normal)
        case .On:
            flashSwitch.setImage(flashOn,forState:UIControlState.Normal)
        case .Auto:
            sender.setTitle("Flash Auto", forState: UIControlState.Normal)
        }
        
    }
    
  

    
    
    @IBAction func switchButton(sender: UIButton) {
        self.cameraManager.cameraOutputMode = self.cameraManager.cameraOutputMode == CameraOutputMode.VideoWithMic ? CameraOutputMode.StillImage : CameraOutputMode.VideoWithMic
        switch (self.cameraManager.cameraOutputMode) {
        case .StillImage:
            self.switchButton.selected = false
            self.switchButton.setImage(cameraButton,forState:UIControlState.Normal)
            self.captureButton.setImage(takePicture, forState: UIControlState.Normal)
            
        case .VideoWithMic, .VideoOnly:
            self.switchButton.setImage(videoButton,forState:UIControlState.Normal)
            self.captureButton.setImage(takeVideo, forState: UIControlState.Normal)
            
        }

        
    }
    
       
    
    @IBOutlet weak var switchCameraPosition: UIButton!
  
    @IBAction func switchCameraView(sender: UIButton) {
        
        self.cameraManager.cameraDevice = self.cameraManager.cameraDevice == CameraDevice.Front ? CameraDevice.Back : CameraDevice.Front
        switch (self.cameraManager.cameraDevice) {
        case .Front:
            switchCameraPosition.setImage(cameraFront,forState:UIControlState.Normal)
        case .Back:
            switchCameraPosition.setImage(cameraBack,forState:UIControlState.Normal)
        }

    }
    
 
   
    @IBOutlet weak var backToAlbums: UIButton!
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var captureForCamera: UIView!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var cameraBottomBar: UIView!
   
    @IBAction func recordVideoTap(sender: UIButton) {
        switch (self.cameraManager.cameraOutputMode) {
        case .StillImage:
            self.cameraManager.capturePictureWithCompletition({ (image, error) -> Void in
                let vc: ImageViewController? = self.storyboard?.instantiateViewControllerWithIdentifier("ImageVC") as? ImageViewController
                if let validVC: ImageViewController = vc {
                    if let capturedImage = image {
                        validVC.image = capturedImage
                        self.navigationController?.pushViewController(validVC, animated: true)
                    }
                }
            })
        case .VideoWithMic, .VideoOnly:
            sender.selected = !sender.selected
            sender.setTitle(" ", forState: UIControlState.Selected)
            sender.backgroundColor = sender.selected ? UIColor.redColor() : UIColor.greenColor()
            if sender.selected {
                self.cameraManager.startRecordingVideo()
            } else {
                self.cameraManager.stopRecordingVideo({ (videoURL, error) -> Void in
                    println(videoURL)
                    if let errorOccured = error {
                        UIAlertView(title: "Error occured", message: errorOccured.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show()
                    }
                })
            }
        }

    }

    @IBOutlet weak var cameraView: UIView!
    @IBAction func askedForCameraPersmissions(sender: UIButton) {
        self.cameraManager.askUserForCameraPermissions({ permissionGranted in
            self.askedForPermissionsButton.hidden = true
            self.askForPermissionsLabel.hidden = true
            self.askedForPermissionsButton.alpha = 0
            self.askForPermissionsLabel.alpha = 0
            if permissionGranted {
                self.addCameraToView()
            }
        })

    }
    @IBOutlet weak var askedForPermissionsButton: UIButton!
    let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    
   
  
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          /*  self.cameraManager.cameraDevice == CameraDevice.Front
            */
            self.cameraManager.cameraOutputMode == CameraOutputMode.StillImage
            //switchCameraPosition.setImage(cameraBack,forState:UIControlState.Normal)
            //flashSwitch.setImage(flashOff,forState:UIControlState.Normal)
          
        self.cameraManager.showAccessPermissionPopupAutomatically = false
        
        self.askedForPermissionsButton.hidden = true
        self.askForPermissionsLabel.hidden = true
        
        let currentCameraState = self.cameraManager.currentCameraStatus()
        
        if currentCameraState == .NotDetermined {
            self.askedForPermissionsButton.hidden = false
            self.askForPermissionsLabel.hidden = false
        } else if (currentCameraState == .Ready) {
            self.addCameraToView()
        }
        if !self.cameraManager.hasFlash {
            self.flashSwitch.enabled = false
            flashSwitch.setImage(flashOff,forState:UIControlState.Normal)
            
        }

        
            getLastImage()

        
        }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //self.navigationController?.navigationBar.hidden = true
        self.cameraManager.resumeCaptureSession()
    }
 
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.cameraManager.stopCaptureSession()
    }
    
    // MARK: - ViewController
    
    private func addCameraToView()
    {
        self.cameraManager.addPreviewLayerToView(self.cameraView,newCameraOutputMode: CameraOutputMode.VideoWithMic)
        CameraManager.sharedInstance.showErrorBlock = { (erTitle: String, erMessage: String) -> Void in
            UIAlertView(title: erTitle, message: erMessage, delegate: nil, cancelButtonTitle: "OK").show()
        }
    }

    func getLastImage(){
        
        //setting up options to grab the last image from camera roll and redisplay it
        var fetchOptions: PHFetchOptions = PHFetchOptions()
        
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        var fetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: fetchOptions)
        
        
        if (fetchResult.lastObject != nil)
            
        {
            var lastAsset: PHAsset = fetchResult.lastObject as! PHAsset
            PHImageManager.defaultManager().requestImageForAsset(lastAsset, targetSize: self.backToAlbums.bounds.size, contentMode: PHImageContentMode.AspectFill, options: PHImageRequestOptions(), resultHandler: { (result, info) -> Void in
                
                self.backToAlbums.setImage(result, forState: .Normal)
                //self.backToAlbums.addTarget(self, action: "btnTouched:", forControlEvents:.TouchUpInside)
            })
        }

    }
    
}
    
    