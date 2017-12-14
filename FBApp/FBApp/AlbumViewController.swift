

import Foundation
import UIKit


class AlbumViewController:UITableViewController{
    
    var albumModel:AlbumModel = AlbumModel(name: "", link: "", cover:"");
    var fbHelper:FBHelper?
    var sources:[AlbumImage] = [AlbumImage]();
    var singlePhotoViewController:SinglePhotoViewController?;
    
    @IBOutlet var loadingActivity: UIActivityIndicatorView!
    func photoExecuted(notification:NSNotification){
        
        self.loadingActivity.stopAnimating()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let img = self.sources[indexPath.row] as AlbumImage;
        return img.smallImage.size.height;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell1")! as UITableViewCell;
        
        //cell.imageView!.bounds = CGRectMake(0, 0, 200, 200)
        cell.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        cell.imageView!.image = self.sources[indexPath.row].smallImage;
        let album = self.sources[indexPath.row]
        
        let commentCount: Int = album.comments!.count
        let likeCount: Int = album.likes!.count
        
        cell.textLabel!.text = "Comments: \(commentCount), likes: \(likeCount)"
        
        let myFont = UIFont(name: "Arial", size: 10)
        cell.textLabel!.font  = myFont;
        cell.textLabel?.textColor = UIColor.whiteColor()
        return cell;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sources.count;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let album = self.sources[indexPath.row];
        if((self.singlePhotoViewController) != nil){
            self.singlePhotoViewController!.album = album;
            self.singlePhotoViewController!.fbHelper = self.fbHelper;
            //self.singlePhotoViewController!.loadPhoto();
        }
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    
    
    func executePhoto(){
        //self.fbHelper!.fetchPhoto(self.albumModel.link);
        
        self.fbHelper!.fetchPhoto(self.albumModel.link, addItemToTable: { (album) -> () in
         
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                var count = self.sources.count - 1
                count = count < 0 ? 0: count
                self.sources.insert(album, atIndex: count)
                let indexPath = NSIndexPath(forRow: count, inSection: 0)
                self.tableView.beginUpdates()
                self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                self.tableView.endUpdates()
                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.None, animated: true)
            })
        })
        
        
    }
    
    func coverPhotoExecuted(notification:NSNotification){
        let photos = notification.userInfo!["photos"] as! [UIImage];
        let backgroundImage = UIImageView(image: photos[0]);
        
        self.tableView.backgroundView!.addSubview(backgroundImage);
    }
    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("photoExecuted:"), name: "photoNotification", object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("coverPhotoExecuted:"), name: "coverPhotoNotification", object: nil);
        
        self.navigationItem.title = self.albumModel.name;
        
        self.loadingActivity.startAnimating()
        self.tableView.backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1)
        
        super.viewDidLoad();
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "coverPhotoNotification", object: nil);
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "photoNotification", object: nil);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "ShowEachSegue"){
            self.singlePhotoViewController = segue.destinationViewController as? SinglePhotoViewController;
        }
    }
    
}