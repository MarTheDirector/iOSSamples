//
//  ViewController.swift
//  Impression
//
//  Created by Mar Nesbitt on 11/7/15.
//  Copyright © 2015 Mar Nesbitt. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class sampleViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var loadingActivity: UIActivityIndicatorView!
    var fbHelper : FBHelper!;
   // var userData:User!
    var sources:[AlbumModel] = [AlbumModel]();
    var currentAlbumModel = AlbumModel(name: "", link: "", cover:"");
    var destController:AlbumViewController?;
    
    @IBOutlet var albumTable : UITableView!
    @IBOutlet var imgProfile : UIImageView!
    
    @IBOutlet weak var loginButton: UIButton!
  
    @IBAction func fetchDataAction(sender : AnyObject) {
     //   self.fbHelper.fetchAlbum(User.this());
    }
    @IBOutlet var btnLoginLogout : UIButton!
    
    @IBOutlet weak var btnLogout: UIButton!
    
    @IBAction func facebookLogoutAction(sender : AnyObject) {
        self.fbHelper.logout();
        self.btnLoginLogout.titleLabel!.text = "Login to Facebook";
    }
    
    
    @IBAction func facebookLoginAction(sender : AnyObject) {
        
        if(self.btnLoginLogout.titleLabel!.text == "Login to Facebook"){
                fbHelper.login();
        }
        else{
            fbHelper.logout();
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.currentAlbumModel = self.sources[indexPath.row];
        if((self.destController) != nil){
            self.destController!.albumModel = self.currentAlbumModel;
            self.destController!.fbHelper = self.fbHelper;
            self.destController!.executePhoto();
        }
        
    }
    
    func selectRowAtIndexPath(indexPath: NSIndexPath, animated: Bool, scrollPosition: UITableViewScrollPosition){
        
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell1")! as UITableViewCell;
        let data = self.sources[indexPath.row];
        cell.textLabel!.text = data.name;
        cell.detailTextLabel!.text = data.link;
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        if(data.cover != ""){
            let coverPhotoURL = NSURL(string: data.cover);
            let coverPhotoData = NSData(contentsOfURL: coverPhotoURL!);
            
            
            
                self.fbHelper.fetchCoverPhoto(data.cover, completion: {(image) -> () in
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        cell.imageView!.bounds.size = CGSizeMake(30, 30)
                        cell.imageView!.image = image
                        
                    })
                })
            
            cell.imageView!.bounds.size = CGSizeMake(30, 30)
            cell.imageView!.image = UIImage(named: "emptyImage")
            
        }
        return cell;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.sources.count;
    }
    
    func executeAlbum(notification:NSNotification){
        let data = notification.userInfo!["data"] as! [AlbumModel];
        self.sources = data;
        self.loadingActivity.stopAnimating()
        self.albumTable.reloadData();
    }
    
//    func executeHandle(notification:NSNotification){
//        let userData = notification.object as User;
//     
//        let name = userData.name as String;
//        let email = userData.email as String;
//        //lblName.text = name;
//        //lblEmail.text = email;
//        imgProfile.image = userData.image;
//        self.btnLoginLogout.titleLabel!.text = "Logout";
//        
//        self.loadingActivity.startAnimating()
//        fbHelper.fetchAlbum(userData);
//        
//        
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "photoSegue"){
            let destinitionController = segue.destinationViewController as! AlbumViewController;
            destinitionController.albumModel = self.currentAlbumModel;
            self.destController = destinitionController;
        }
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "PostData", object: nil);
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "albumNotification", object: nil);
    }
    
    override func viewDidLoad() {
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("executeHandle:"), name: "PostData", object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("executeAlbum:"), name: "albumNotification", object: nil);
        self.albumTable.separatorStyle = UITableViewCellSeparatorStyle.None
        self.loadingActivity.stopAnimating()
        
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate{
            self.fbHelper = delegate.fbHelper
            
            self.loadingActivity.startAnimating()
           // self.fbHelper.fetchAlbum(userData)
            //self.imgProfile.image = self.userData.image
        }
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

