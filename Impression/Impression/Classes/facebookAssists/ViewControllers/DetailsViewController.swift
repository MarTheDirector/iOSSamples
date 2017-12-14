//
//  ViewController.swift
//  Impression
//
//  Created by Mar Nesbitt on 11/7/15.
//  Copyright © 2015 Mar Nesbitt. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //@IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    
    @IBOutlet weak var detailsTable: UITableView!
    var source = [AnyObject]()
    //var comments: [Comment]?
    //var likes:[Like]?
    var fbHelper:FBHelper?
    var image:UIImage?
    
    
    override func viewDidLoad() {
        
        self.detailsTable.separatorStyle = UITableViewCellSeparatorStyle.None
        //self.loadingActivity.stopAnimating()
        
        source.removeAll(keepCapacity: false)
        
        /*for comment in comments!{
            source.append(comment)
        }
        
        for like in likes!{
            source.append(like)
        }*/
        
        
        detailsTable.reloadData()
        
        if let imgHas = self.image{
            let imgView = UIImageView(frame: self.detailsTable.frame)
            imgView.contentMode = UIViewContentMode.ScaleAspectFit
            imgView.image = imgHas
            imgView.alpha = 0.4
            self.detailsTable.backgroundView = imgView
            self.detailsTable.opaque = false
        }
        
        
        super.viewDidLoad()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell1", forIndexPath: indexPath) as UITableViewCell
        
        let data: AnyObject = source[indexPath.row] as AnyObject
        /*if(data is Comment){
            let commentData = data as! Comment
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
              
                self.fbHelper?.fetchFriendsPhoto(commentData.commentByUrl!, completionHandler: { (img) -> () in
                 
                    cell.imageView?.image = img
                    cell.imageView?.bounds = CGRectMake(10, 10, 30, 30)
                })
            })
            cell.textLabel?.textColor = UIColor.cyanColor()
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "Comment by: \(commentData.commentBy!) -> \(commentData.commentString!)"
            
        }
        else if(data is Like){
            let likeData = data as! Like
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
              
                self.fbHelper?.fetchFriendsPhoto(likeData.likeByUrl!, completionHandler: { (img) -> () in
                   
                    cell.imageView?.image = img
                    cell.imageView?.bounds = CGRectMake(10, 10, 30, 30)
                })
            })
            cell.textLabel?.textColor = UIColor.whiteColor()
            cell.textLabel?.text = "Like by: \(likeData.likeBy!)"
            cell.detailTextLabel?.text = ""
        }*/
        
        let myFont = UIFont(name: "Arial", size: 10)
        cell.textLabel?.font = myFont
        cell.detailTextLabel?.font = myFont
        cell.imageView?.image = UIImage(named: "emptyImage")
        
        return cell

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.source.count
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    
}