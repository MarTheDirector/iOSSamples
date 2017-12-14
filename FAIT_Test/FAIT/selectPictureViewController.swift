//
//  selectPictureViewController.swift
//  FAIT
//
//  Created by Mar Nesbitt on 6/1/15.
//  Copyright (c) 2015 FAIT App. All rights reserved.
//

import UIKit
import Photos

let reuseIdentifer = "photoCell"
let albumName = "FAIT"

class selectPictureViewController: UIViewController, PHPhotoLibraryChangeObserver  {
    
    var albumFound : Bool = false
    var assetCollection: PHAssetCollection!
    var photosAsset: PHFetchResult!
    var assetThumbnailSize:CGSize!
    
    var images: PHFetchResult!
    let imageManager = PHCachingImageManager()
    var imageCacheController: ImageCacheController!
    
    @IBOutlet weak var noAlbumLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images = PHAsset.fetchAssetsWithMediaType(.Image, options: nil)
        imageCacheController = ImageCacheController(imageManager: imageManager, images: images, preheatSize: 1)
        PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
    }
    
    // MARK: UICollectionViewDataSource
    
   func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return images.count
        
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifer, forIndexPath: indexPath) as!  photoCell
        
        // Configure the cell
        cell.imageManager = imageManager
        cell.imageAsset = images[indexPath.item] as? PHAsset
        
        return cell
    }
    
    // MARK: - ScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let indexPaths = collectionView?.indexPathsForVisibleItems()
        imageCacheController.updateVisibleCells(indexPaths as! [NSIndexPath]!)
    }
    
    // MARK: - PHPhotoLibraryChangeObserver
    func photoLibraryDidChange(changeInstance: PHChange) {
        let changeDetails = changeInstance.changeDetailsForFetchResult(images)
        
        self.images = changeDetails!.fetchResultAfterChanges
        dispatch_async(dispatch_get_main_queue()) {
            // Loop through the visible cell indices
            let indexPaths = self.collectionView?.indexPathsForVisibleItems()
            for indexPath in indexPaths as! [NSIndexPath]! {
                if changeDetails!.changedIndexes!.containsIndex(indexPath.item) {
                    let cell = self.collectionView?.cellForItemAtIndexPath(indexPath) as! photoCell
                    cell.imageAsset = changeDetails!.fetchResultAfterChanges[indexPath.item] as? PHAsset
                    
                }
            }
        }
    }

    
    
    
    
}
