//
//  photoCell.swift
//  FAIT
//
//  Created by Mar Nesbitt on 6/7/15.
//  Copyright (c) 2015 FAIT App. All rights reserved.
//

import UIKit
import Photos

class photoCell: UICollectionViewCell {

    
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var imageCellJot: UIImageView!
    
    func setThumbnailImage(thumbnailImage: UIImage){
        self.imageCell.image = thumbnailImage
    }
    
    var imageAsset: PHAsset? {
        didSet {
            self.imageManager?.requestImageForAsset(imageAsset!, targetSize: CGSize(width: 105, height: 105), contentMode: .AspectFill, options: nil) { image, info in
                self.imageCell.image = image
                //self.imageCellJot.image = image
            }
            //starButton.alpha = imageAsset!.favorite ? 1.0 : 0.4
        }
    }
    
    var imageManager: PHImageManager?
    
    /*@IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var starButton: UIButton!
    
    @IBAction func handleStarButtonPressed(sender: AnyObject) {
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({
            let changeRequest = PHAssetChangeRequest(forAsset: self.imageAsset!)
            changeRequest.favorite = !self.imageAsset!.favorite
            }, completionHandler: nil)
    } */

}
