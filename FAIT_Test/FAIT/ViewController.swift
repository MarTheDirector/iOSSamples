//
//  ViewController.swift
//  FAIT
//
//  Created by Mar Nesbitt & Zac Gordon on 4/29/15.
//  Copyright (c) 2015 FAIT App. All rights reserved.
//

import UIKit

import MediaPlayer
import Parse
//import ParseUI


class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pageDescription: UILabel!
    
    @IBAction func dismissView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func unwindSecondView(segue: UIStoryboardSegue) {
        
    }
    
    
    let defersCurrentPageDisplay = true
    
    var moviePlayer : MPMoviePlayerController?
    
    var count = 0
    
    var pageViewController: UIPageViewController!
    var pageTitles: NSArray!
    var pageImages: NSArray!
    var pageText: NSArray!
    var pageDotColor: NSArray!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //var statusBar: () = UIApplication.sharedApplication().statusBarHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        
        //playVideo()
        
       
        var pageController = UIPageControl.appearance()
        
        //setting string ranges to a variable to sort through
        let hiya = "Hiya" as NSString
        let spark = "Spark" as NSString
        let talent = "Talent" as NSString
        let charm = "Charm" as NSString
        let chance = "Chance" as NSString
        
        //setting string to a mutable attributed string that we can manipulate
        var attributedHiya = NSMutableAttributedString(string: hiya as String)
        var attributedSpark = NSMutableAttributedString(string: spark as String)
        var attributedTalent = NSMutableAttributedString(string: talent as String)
        var attributedCharm = NSMutableAttributedString(string: charm as String)
        var attributedChance = NSMutableAttributedString(string: chance as String)
        
        // stetting attributes that we want to change
        
        //intial attribute that's common for both strings
        let firstAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        //attributes that we want to change for each page
        let hiyaAttributes = [NSForegroundColorAttributeName: UIColor(red: (107.0/255.0), green: (185.0/255.0), blue: (198.0/255.0), alpha: 1.0)]
        let sparkAttributes = [NSForegroundColorAttributeName: UIColor(red: (159/255.0), green: (125/255.0), blue: (144/255.0), alpha: 1.0)]
        let talentAttributes = [NSForegroundColorAttributeName: UIColor(red: (226/255.0), green: (145/255.0), blue: (164/255.0), alpha: 1.0)]
        let charmAttributes = [NSForegroundColorAttributeName: UIColor(red: (215/255.0), green: (118/255.0), blue: (118/255.0), alpha: 1.0)]
        let chanceAttributes = [NSForegroundColorAttributeName:   UIColor(red: (239/255.0), green: (223/255.0), blue: (125/255.0), alpha: 1.0)]
        
        
        // here we are adding our changes to
        
        //hiya
        attributedHiya.addAttributes(firstAttributes, range: hiya.rangeOfString("Hiy"))
        attributedHiya.addAttributes(hiyaAttributes, range: hiya.rangeOfString("a"))
        
        
        //spark
        attributedSpark.addAttributes(firstAttributes, range: spark.rangeOfString("Sp"))
        attributedSpark.addAttributes(sparkAttributes, range: spark.rangeOfString("a"))
        attributedSpark.addAttributes(firstAttributes, range: spark.rangeOfString("rk"))
        
        //talent
        attributedTalent.addAttributes(firstAttributes, range: talent.rangeOfString("T"))
        attributedTalent.addAttributes(talentAttributes, range: talent.rangeOfString("a"))
        attributedTalent.addAttributes(firstAttributes, range: talent.rangeOfString("lent"))
        
        //charm
        attributedCharm.addAttributes(firstAttributes, range: charm.rangeOfString("Ch"))
        attributedCharm.addAttributes(charmAttributes, range: charm.rangeOfString("a"))
        attributedCharm.addAttributes(firstAttributes, range: charm.rangeOfString("rm"))
        
        //charnce
        attributedChance.addAttributes(firstAttributes, range: chance.rangeOfString("Ch"))
        attributedChance.addAttributes(chanceAttributes, range: chance.rangeOfString("a"))
        attributedChance.addAttributes(firstAttributes, range: chance.rangeOfString("nce"))
        
        //setting up dotcolor values on title page
        let hiyaDot = UIColor(red: (107.0/255.0), green: (185.0/255.0), blue: (198.0/255.0), alpha: 0.7)
        let sparkDot = UIColor(red: (159/255.0), green: (125/255.0), blue: (144/255.0), alpha: 1.0)
        let talentDot =  UIColor(red: (226/255.0), green: (145/255.0), blue: (164/255.0), alpha: 1.0)
        let charmDot = UIColor(red: (215/255.0), green: (118/255.0), blue: (118/255.0), alpha: 1.0)
        let chanceDot =   UIColor(red: (239/255.0), green: (223/255.0), blue: (125/255.0), alpha: 1.0)
        
        
        //setting array for titles on title page
        self.pageTitles = NSArray(objects:  attributedHiya ,attributedSpark,attributedTalent,attributedCharm,attributedChance )
        
        //setting array for images on title page
        self.pageImages = NSArray(objects:"faitblue","faitpurple","faitpink","faitred","faityellow")
        
        //setting array for descriptions on title page
        self.pageText = NSArray(objects: "Smile, you're beautiful and important, never forget that.","Life is an adventure. Sign up and see what you have in common with the people around you.","What's your passion? Share your talents with the world.","Chat amongst friends new and old.","Now's your chance to join us and create your own FAIT.")
        
        //setting array for dot indicator color on title page
        self.pageDotColor = NSArray(objects: hiyaDot, sparkDot, talentDot, charmDot, chanceDot)
      
        
            
        
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("pageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        var startVc = self.viewControllerAtIndex(0) as sparkViewController
        var viewControllers = NSArray(object: startVc)
        
        self.pageViewController.setViewControllers(viewControllers as [AnyObject], direction: .Forward, animated: true, completion: nil)
        
        
        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.size.height - 80 )
        
        
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
      
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        /*if(PFUser.currentUser() == nil){
            println("not logged in")
        }
        else{
        
            println("logged in")
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*func blurEffectStuff(){
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
    
    
    
    }*/
    
    

    
    
    func viewControllerAtIndex(index: Int) -> sparkViewController{
        
        if((self.pageTitles.count == 0) || (index >= self.pageTitles.count))
        {
            return sparkViewController()
        
        }
        
        var vc: sparkViewController = self.storyboard?.instantiateViewControllerWithIdentifier("sparkViewController") as! sparkViewController
        
        vc.imageFile = self.pageImages[index] as! String
        vc.titleText = self.pageTitles[index] as! NSAttributedString
        vc.pageText = self.pageText[index] as! String
    
        vc.dotColor = self.pageDotColor[index] as! UIColor
        vc.pageIndex = index
        
     
     
        return vc
        
        
    }
 
    //MARK: page view controller data source
    
    //Start of before page view controller
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var vc = viewController as! sparkViewController
        var index = vc.pageIndex as Int
        
        if(index == 0 || index == NSNotFound){
            
            return nil
        
        }
        
        
        index--
                return self.viewControllerAtIndex(index)
        
   
   
    }
    
    //start of end page view controller
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        
        var vc = viewController as! sparkViewController
        var index = vc.pageIndex as Int
        
        
        if(index == NSNotFound){
            
            return nil
        
        }
        
        index++
        
        if (index == self.pageTitles.count){
            
            return nil
            
        }
        
        return self.viewControllerAtIndex(index)
        
    }
    
    
    //start of presentation count for page view controller
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return self.pageTitles.count
    }
    
    //start of presentation index for page view controller
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
  /*  private func playVideo() {
        if let
            path = NSBundle.mainBundle().pathForResource("faitBGVideo", ofType:"mp4"),
            url = NSURL(fileURLWithPath: path),
            moviePlayer = MPMoviePlayerController(contentURL: url) {
                self.moviePlayer = moviePlayer
                moviePlayer.view.frame = self.view.bounds
                moviePlayer.prepareToPlay()
                moviePlayer.scalingMode = .AspectFill
                self.view.addSubview(moviePlayer.view)
              moviePlayer.repeatMode = MPMovieRepeatMode.One
                moviePlayer.controlStyle = .None
                
                var backgroundView = UIView()
                backgroundView.frame = self.view.frame
                backgroundView.backgroundColor = UIColor.blackColor()
                backgroundView.alpha = 0.6
                self.view.addSubview(backgroundView)
        } else {
            debugPrintln("Ops, something wrong when playing video.m4v")
        }
    }*/
    
    
    
    @IBAction func customAction(sender: AnyObject){
        self.performSegueWithIdentifier("signup", sender: self)
    }
    
    
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
  
    
    }

