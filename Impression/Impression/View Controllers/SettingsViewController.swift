//
//  SettingsViewController.swift
//  Impression
//
//  Created by Mar Nesbitt on 2/6/16.
//  Copyright © 2016 Mar Nesbitt. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // MARK: Outlets
 

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: FullWidthCellsFlowLayout!
    
    
    // MARK: Properties
    
    var settings: [SettingCell] {
        var settingDetail = SettingDataSource.settingsLines()
        return settingDetail[0].cell
    }
   
    
  
    
    //MARK: Lifestyle
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
        
        //For image gallery
        // Do any additional setup after loading the view, typically from a nib.
        collectionView?.registerNib(UINib(nibName: "SettingsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        collectionView.reloadData()
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //for the test
    }
    
    
    //Mark: Collection View Delegate for collection view
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return settings.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //Mark for without reusable cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! SettingsCollectionCell
        
        let set = settings[indexPath.row]
        cell.titleLabel.text = set.title
        cell.subtitleLabel.text = set.description
        /*cell.textLabel?.text = set.title
        cell.detailTextLabel?.text = set.description
        cell.imageView?.image = set.image*/
        return cell
    }
    
    /*func collectionView( collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
       
        return collectionView.bounds.size
    }*/
    
    
    
    

    /* //For image gallery
    //Mark: Collection View Delegate for image gallery
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    return settings.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    //Mark for without reusable cell

    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! RDCell

    cell.imageView?.image = self.imageArray[indexPath.row]


    currentPage = indexPath.row
    return cell
    }

    func collectionView( collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

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

    }*/


}
