//
//  ViewController.swift
//  Impression
//
//  Created by Mar Nesbitt on 11/7/15.
//  Copyright © 2015 Mar Nesbitt. All rights reserved.
//

import Foundation
import UIKit

class SinglePhotoViewController:UIViewController{
    
    var album:AlbumImage?;
    var fbHelper:FBHelper?
    var detailsViewController:DetailsViewController?
    
    //@IBOutlet weak var commentLikSource: UITableView!
    @IBOutlet var imgView : UIImageView!
    var source:[AnyObject] = [AnyObject]()
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1)
        //self.commentLikSource.separatorStyle = UITableViewCellSeparatorStyle.None
        //self.commentLikSource.backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1)
        self.view.backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1)
        
        //self.source.removeAll(keepCapacity: false)
        
//        for comment in self.album!.comments!{
//            self.source.append(comment)
//        }
//        
//        for like in self.album!.likes!{
//            self.source.append(like)
//        }
        
        //self.commentLikSource.reloadData()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        super.viewDidLoad();
        
    }
    
    func loadPhoto(){
        self.imgView.image = self.album!.bigImage;
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if((album) != nil){
            self.loadPhoto();
        }
    }
    
    /*
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell1") as UITableViewCell
        
        let data:AnyObject = self.source[indexPath.row]
        
        if(data is Comment){
            let commentData = data as Comment
            cell.textLabel!.text = "Comment: \(commentData.commentString!)"
            cell.textLabel?.numberOfLines = 0
            cell.detailTextLabel!.text = "Comment by: \(commentData.commentBy!). Date: \(commentData.commentDate!)"
        }
        else if(data is Like){
            let likeData = data as Like
            cell.textLabel!.text = "Like by: \(likeData.likeBy!)"
            cell.detailTextLabel!.text = ""
            
        }
        
        let myFont = UIFont(name: "Arial", size: 12)
        cell.textLabel!.font  = myFont;
        
        return cell
    }
*/
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "detailsIdentifier"){
            self.detailsViewController = segue.destinationViewController as? DetailsViewController;
            if let controller = self.detailsViewController{
                self.detailsViewController?.fbHelper = self.fbHelper
               // self.detailsViewController?.likes = self.album?.likes
                //self.detailsViewController?.comments = self.album?.comments
                self.detailsViewController?.image = self.album?.bigImage
            }
        }
    }
    
}