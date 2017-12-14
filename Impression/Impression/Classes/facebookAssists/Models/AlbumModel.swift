//
//  ViewController.swift
//  Impression
//
//  Created by Mar Nesbitt on 11/7/15.
//  Copyright © 2015 Mar Nesbitt. All rights reserved.
//

import Foundation
import UIKit
class AlbumModel{
    var name = "";
    var link = "";
    var cover = "";
    var thumbImage:UIImage?
    init(name:String, link:String, cover:String){
        self.name = name;
        self.link = link;
        self.cover = cover;
    }
}

class AlbumImage{
    let smallImage:UIImage!
    let bigImage:UIImage!
    
    //let comments: [Comment]?
    //let likes: [Like]?
    //init(smallImage:UIImage, bigImage:UIImage, likes:[Like]?, comments:[Comment]?)
    init(smallImage:UIImage, bigImage:UIImage){
        self.smallImage = smallImage
        self.bigImage = bigImage
        //self.comments = comments
        //self.likes = likes
    }
}


/*class Like{
    var likeBy:String? = ""
    var likeDate:String? = ""
    var likeByUrl:String? = ""
    let likeByImage:UIImage?
    
    init(likeBy:String?, likeDate:String?, likeByUrl:String?, likeByImage:UIImage?){
        self.likeBy = likeBy
        self.likeDate = likeDate
        self.likeByUrl = likeByUrl
        self.likeByImage = likeByImage
    }
}*/

/*class Comment {
    var commentString:String? = ""
    var commentBy:String? = ""
    var commentByUrl:String? = ""
    var commentLocation:String? = ""
    var commentDate:String? = ""
    let commentByImage:UIImage?
    
    init(commentString:String?, commentBy:String?, commentLocation:String?, commentDate:String?, commentByUrl:String?, commentByImage:UIImage?){
        self.commentString = commentString
        self.commentBy = commentBy
        self.commentLocation = commentLocation
        self.commentDate = commentDate
        self.commentByUrl = commentByUrl
        self.commentByImage = commentByImage
    }
}*/