//
//  TNImageSliderViewController.swift
//
//  Created by Frederik Jacques on 20/06/15.
//  Copyright (c) 2015 Frederik Jacques. All rights reserved.
//

import UIKit

public struct TNImageSliderViewOptions {
    
    public var scrollDirection:UICollectionViewScrollDirection
    public var backgroundColor:UIColor
    public var pageControlHidden:Bool
    public var pageControlCurrentIndicatorTintColor:UIColor
    public var pageControlTintColor:UIColor
    public var autoSlideIntervalInSeconds:NSTimeInterval
    public var shouldStartFromBeginning:Bool
    
    public init(){
        
        self.scrollDirection = UICollectionViewScrollDirection.Vertical
        self.backgroundColor = UIColor.blackColor()
        self.pageControlHidden = false
        self.pageControlCurrentIndicatorTintColor = UIColor(red: 97/255, green: 140/255, blue: 170/255, alpha: 1)
        self.pageControlTintColor = UIColor.whiteColor()
        self.autoSlideIntervalInSeconds = 0
        self.shouldStartFromBeginning = false
        
    }
    
    public init( scrollDirection:UICollectionViewScrollDirection, backgroundColor:UIColor, pageControlHidden:Bool, pageControlCurrentIndicatorTintColor:UIColor, pageControlTintColor:UIColor){
        
        self.scrollDirection = scrollDirection
        self.backgroundColor = backgroundColor
        self.pageControlHidden = pageControlHidden
        self.pageControlCurrentIndicatorTintColor = pageControlCurrentIndicatorTintColor
        self.pageControlTintColor = pageControlTintColor
        self.autoSlideIntervalInSeconds = 0
        self.shouldStartFromBeginning = false
        
    }
}

public class TNImageSliderViewController: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - IBOutlets
    
    // MARK: - Properties
    var collectionView:UICollectionView!
    var collectionViewLayout:UICollectionViewFlowLayout {
    
        get {
            
            return collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            
        }
        
    }
    
    var pageControl:UIPageControl!
    
    public var options:TNImageSliderViewOptions! {
    
        didSet {
            
            if let collectionView = collectionView, let pageControl = pageControl {
            
                collectionViewLayout.scrollDirection = options.scrollDirection
                
                collectionView.collectionViewLayout = collectionViewLayout
                collectionView.backgroundColor = options.backgroundColor
                pageControl.hidden = options.pageControlHidden
                pageControl.currentPageIndicatorTintColor = options.pageControlCurrentIndicatorTintColor
                pageControl.pageIndicatorTintColor = options.pageControlTintColor
                setupAutoSliderIfNeeded()
                
            }
            
        }
        
    }
    
    public var images:[UIImage]! {
        
        didSet {
            
            collectionView.reloadData()
            
            pageControl.numberOfPages = images.count
        }
        
    }
    
    var currentPage:Int {
        
        get {
            
            switch( collectionViewLayout.scrollDirection ) {
                
                case .Horizontal:
                    return Int((collectionView.contentOffset.x / collectionView.contentSize.width) * CGFloat(images.count))
                
                case .Vertical:
                    return Int((collectionView.contentOffset.y / collectionView.contentSize.height) * CGFloat(images.count))
                
            }
            
        }
        
    }
    
    // MARK: - Initializers methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    func loadViewFromNib() {
        options = TNImageSliderViewOptions()
        
        setupCollectionView()
        setupPageControl()

    }
    
    
    /* init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }

    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }*/
    
    // MARK: - Lifecycle methods
    /*public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
    }*/
    
    
    
    public  func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        // Calculate current page to update the content offset to the correct position when the orientation changes
        // I take a copy of the currentPage variable, as it will be incorrectly calculated once we are in the animateAlongsideTransition block
        // Because the contentSize will already be changed to reflect the new orientation
        let theCurrentPage = Int(currentPage)
        
        coordinator.animateAlongsideTransition({ (context) -> Void in
            
            let contentOffSet:CGPoint
            
            switch( self.collectionViewLayout.scrollDirection ) {
                
            case .Horizontal:
                
                contentOffSet = CGPoint(x: Int(self.collectionView.bounds.size.width) * theCurrentPage, y: 0)
                
            case .Vertical:
                
                contentOffSet = CGPoint(x: 0, y: Int(self.collectionView.bounds.size.height) * self.currentPage)
                
            }
            
            self.collectionView.contentOffset = contentOffSet
            
            }, completion: { (context) -> Void in
                
        })
        
        self.collectionView.collectionViewLayout.invalidateLayout()
        
    }
    
    // MARK: - Private methods
    private func setupCollectionView(){
    
        let layout = UICollectionViewFlowLayout()

        layout.scrollDirection = options.scrollDirection
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout:layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.pagingEnabled = true
        
        let bundle = NSBundle(forClass: TNImageSliderViewController.classForCoder())
        let nib = UINib(nibName: "TNImageSliderCollectionViewCell", bundle: bundle)
        
        collectionView.registerNib(nib, forCellWithReuseIdentifier: "TNImageCell")
        collectionView.backgroundColor = options.backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        self.addSubview(collectionView)
    
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[collectionView]|", options: [], metrics: nil, views: ["collectionView":collectionView])
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[collectionView]|", options: [], metrics: nil, views: ["collectionView":collectionView])
        
        self.addConstraints(horizontalConstraints)
        self.addConstraints(verticalConstraints)
        
    }
    
    private func setupPageControl() {
        
        pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = options.pageControlCurrentIndicatorTintColor
        pageControl.pageIndicatorTintColor = options.pageControlTintColor
         pageControl.transform = CGAffineTransformMakeRotation(CGFloat(Float(M_PI_2)))
        pageControl.hidden = options.pageControlHidden
        self.addSubview(pageControl)
        
        let centerXConstraint = NSLayoutConstraint(item: pageControl,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: pageControl,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: -5)
        let topConstraint = NSLayoutConstraint(item: pageControl,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 5)
        let trailingConstraint = NSLayoutConstraint(item: pageControl,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: 5)
        
        self.addConstraints([topConstraint, trailingConstraint])
        
    }
    
    private func setupAutoSliderIfNeeded() {
        
        if options.autoSlideIntervalInSeconds > 0 {
            NSTimer.scheduledTimerWithTimeInterval(options.autoSlideIntervalInSeconds, target: self, selector: "timerDidFire:", userInfo: nil, repeats: true)
        }
        
    }
    
    func timerDidFire(timer: NSTimer) {
        
        let theNextPage = currentPage + 1
        var contentOffSet = CGPointZero
        
        if theNextPage < images.count {
            switch( self.collectionViewLayout.scrollDirection ) {
                
            case .Horizontal:
                
                contentOffSet = CGPoint(x: Int(self.collectionView.bounds.size.width) * theNextPage, y: 0)
                
            case .Vertical:
                
                contentOffSet = CGPoint(x: 0, y: Int(self.collectionView.bounds.size.height) * theNextPage)
                
            }
        }
        
        if options.shouldStartFromBeginning || contentOffSet != CGPointZero {
            collectionView.setContentOffset(contentOffSet, animated: true)
        } else {
            timer.invalidate()
        }
    }
    
    // MARK: - Public methods
    
    // MARK: - Getter & setter methods
    
    // MARK: - IBActions
    
    // MARK: - Target-Action methods
    
    // MARK: - Notification handler methods
    
    // MARK: - Datasource methods
    // MARK: UICollectionViewDataSource methods
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    
        return 1
        
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if let images = images {
        
            return images.count
            
        }
        
        return 0
        
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TNImageCell", forIndexPath: indexPath) as! TNImageSliderCollectionViewCell
        cell.imageView.image = images[indexPath.row]
        
        return cell
        
    }
    
    public func collectionView( collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return collectionView.bounds.size
        
    }
    
    // MARK: - Delegate methods
    // MARK: UICollectionViewDelegate methods
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        // If the scroll animation ended, update the page control to reflect the current page we are on
        pageControl.currentPage = currentPage
        
    }
    
    public func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        // Called when manually setting contentOffset
        scrollViewDidEndDecelerating(scrollView)
        
    }
}
