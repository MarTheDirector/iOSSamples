//
//  MainViewController.swift
//  Impression
//
//  Created by Mar Nesbitt on 2/6/16.
//  Copyright © 2016 Mar Nesbitt. All rights reserved.
//

import UIKit
import pop
import Alamofire


private let frameAnimationSpringBounciness:CGFloat = 9
private let frameAnimationSpringSpeed:CGFloat = 16
private let kolodaCountOfVisibleCards = 1
private let kolodaAlphaValueSemiTransparent:CGFloat = 0.1

class KolodaPhoto {
    var photoUrlString = ""
    var title = ""
    
    init () {
    }
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        self.init()
        
        title = (dictionary["title"] as? String)!
        photoUrlString = (dictionary["url"] as? String)!
    }
}


//class MainViewController: UIViewController, KolodaViewDataSource, KolodaViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
class MainViewController: UIViewController, KolodaViewDataSource, KolodaViewDelegate {
    
    @IBOutlet weak var kolodaView: CustomKolodaView!
    
    var photos = Array<KolodaPhoto>()
    //MARK: Collection View
    var imageArray = [UIImage(named: "pug"), UIImage(named: "pug2"), UIImage(named: "pug3"), UIImage(named: "pug4")]
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        kolodaView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        kolodaView.countOfVisibleCards = kolodaCountOfVisibleCards
        kolodaView.dataSource = self
        kolodaView.delegate = self
        self.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        fetchPhotos()
        
        
    }
    
    //MARK: Datahandling
    func fetchPhotos() {
        Alamofire.request(.GET, "http://jsonplaceholder.typicode.com/photos")
            .responseJSON { response -> Void in
                if let photosArray = response.result.value as? NSArray {
                    photosArray.enumerateObjectsUsingBlock({ (photo, index, stop) -> Void in
                        if index == 15 {
                            let shouldStop: ObjCBool = true
                            stop.initialize(shouldStop)
                        }
                        if let photoDictionary = photo as?  Dictionary<String, AnyObject> {
                            self.photos.append(KolodaPhoto(photoDictionary))
                        }
                    })
                    self.kolodaView.reloadData()
                }
        }
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //for the test
    }
    
    
    //MARK: KolodaViewDataSource
    func kolodaNumberOfCards(koloda: KolodaView) -> UInt {
        return UInt(self.photos.count)
    }
    
    func kolodaViewForCardAtIndex(koloda: KolodaView, index: UInt) -> UIView {
        
        let TNImageSlider = NSBundle.mainBundle().loadNibNamed("TNNib",
            owner: self, options: nil)[0] as? TNImageSliderViewController
        //MARK: Setting up info for TNImage Slider
        // Do any additional setup after loading the view, typically from a nib.
        let image1 = UIImage(named: "pug")
        let image2 = UIImage(named: "pug2")
        let image3 = UIImage(named: "pug3")
        
        
        
        // 1. Set the image array with UIImage objects
        TNImageSlider!.images = [image1!, image2!, image3!]
        TNImageSlider?.translatesAutoresizingMaskIntoConstraints = false
        //self.addSubview(TNImageSlider)
     

        return TNImageSlider!
        
    }
        
    func kolodaViewForCardOverlayAtIndex(koloda: KolodaView, index: UInt) -> OverlayView? {
        return NSBundle.mainBundle().loadNibNamed("CustomOverlayView",
            owner: self, options: nil)[0] as? OverlayView
    }
    
    //MARK: KolodaViewDelegate
    
    func kolodaDidSwipedCardAtIndex(koloda: KolodaView, index: UInt, direction: SwipeResultDirection) {
    }
    
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
        //Example: reloading
        fetchPhotos()
    }
    
    func kolodaDidSelectCardAtIndex(koloda: KolodaView, index: UInt) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://yalantis.com/")!)
    }
    
    func kolodaShouldApplyAppearAnimation(koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldTransparentizeNextCard(koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaBackgroundCardAnimation(koloda: KolodaView) -> POPPropertyAnimation? {
        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        animation.springBounciness = frameAnimationSpringBounciness
        animation.springSpeed = frameAnimationSpringSpeed
        return animation
    }
    
    
    
}