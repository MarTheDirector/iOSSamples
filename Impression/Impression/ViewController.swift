//
//  ViewController.swift
//  Impression
//
//  Created by Mar Nesbitt on 2/6/16.
//  Copyright © 2016 Mar Nesbitt. All rights reserved.
//

import UIKit


var successfulSignUp:Bool = false

//for FB Sample COde
var isLogin:Bool = false

class ViewController: UIViewController {
    
    //Sample FB helper
    var fbHelper:FBHelper!
    //var userData:User!
    
    let permissions = ["email", "public_profile", "user_friends", "user_photos", "user_birthday", "user_relationship_details"]
    
    var albumDict: NSDictionary = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /* if (FBSDKAccessToken.currentAccessToken() != nil)
        {
        // User is already logged in, do work such as go to next view controller.
        self.performSegueWithIdentifier("loginHome", sender: nil)
        }
        else
        {
        
        //Setting up new user
        
        }*/
        
        //FB Helper
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("executeHandle:"), name: "PostData", object: nil);
    }
    
    //FB Helper code
    override func viewDidAppear(animated: Bool) {
        
        
        super.viewDidDisappear(animated)
        
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate{
            self.fbHelper = delegate.fbHelper
        }
        
       /* if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && currentUser.authData != nil{
        
        }*/
    }
    
    //FB Helper
    func didLoginToFacebook(){
        
        self.fbHelper.login()
    }
    
    //FB Helper
    func executeHandle(notification:NSNotification){
        let userData = notification.object as! UserObject;
        
        let name = userData.fullName as String;
        let email = userData.email as String;
        //lblName.text = name;
        //lblEmail.text = email;
        //imgProfile.image = userData.image;
        //self.btnLoginLogout.titleLabel!.text = "        Logout        ";
        isLogin = true
        
        let navigation: MySwipeVC! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("navigation") as! MySwipeVC
        //self.performSegueWithIdentifier("login", sender: self)
        self.presentViewController(navigation, animated: true, completion: nil)
        //navigation.userData = userData
        //self.navigationController?.pushViewController(navigation!, animated: true)
        //fbHelper.fetchAlbum(userData);
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //for the test
    }

    @IBAction func loginClick(sender: AnyObject) {
        
        let navigation: MySwipeVC! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("navigation") as! MySwipeVC
        
        //navigation.userData = userData
        self.navigationController?.pushViewController(navigation!, animated: true)
        /*if(isLogin == false){
            //MARK: Begining of FB login in background. Only asking for read permissions because don't need to write anything to a users page at this time
            PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
                (user: PFUser?, error: NSError?) -> Void in
                if let user = user {
                    if user.isNew {
                        print("User signed up and logged in through Facebook!")
                        successfulSignUp = true
                        
                        self.fbHelper.login();
                        //self.fbLoginInitiate()
                        
                    } else {
                        print("User logged in through Facebook!")
                        successfulSignUp = true
                        
                        self.fbHelper.login();
                        //self.fbLoginInitiate()
                        
                    }
                } else {
                    print("Uh oh. The user cancelled the Facebook login.")
                }
            }
        }
            
        else{
            fbHelper.logout();
            isLogin = false
        }
        
        //FB Helper code
        /*if(isLogin == false){
        self.loadingActivity.startAnimating()
        fbHelper.login();
        }
        else{
        fbHelper.logout();
        isLogin = false
        }*/
        
        
    }
    
    
    
    
    
    //Setting up ask permissions then get info
    
    func fbLoginInitiate() {
        let loginManager = FBSDKLoginManager()
        loginManager.logInWithReadPermissions(["public_profile", "email" , "user_friends" , "user_birthday", "user_photos"], handler: {(result:FBSDKLoginManagerLoginResult!, error:NSError!) -> Void in
            if (error != nil) {
                // Process error
                self.removeFbData()
            } else if result.isCancelled {
                // User Cancellation
                self.removeFbData()
            } else {
                //Success
                if result.grantedPermissions.contains("email") && result.grantedPermissions.contains("public_profile") && result.grantedPermissions.contains("user_friends") && result.grantedPermissions.contains("user_birthday") && result.grantedPermissions.contains("user_photos")  {
                    //Do work
                    self.fetchFacebookProfile()
                    
                } else {
                    //Handle error
                }
            }
        })*/
    }
    
    func removeFbData() {
        //Remove FB Data
       /* let fbManager = FBSDKLoginManager()
        fbManager.logOut()
        FBSDKAccessToken.setCurrentAccessToken(nil)*/
    }
    
    
    
    
    /*func fetchFacebookProfile()
    {
        if FBSDKAccessToken.currentAccessToken() != nil {
            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,email,name,first_name,birthday,age_range,is_verified,picture,albums"])
            graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                
                if ((error) != nil) {
                    //Handle error
                } else if let userData = result as? [String:AnyObject] {
                    let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                    //  Mark: Birthday Info being set up here
                    
                    let birthday : NSString = (userData["birthday"] as? NSString)!
                    let currentDate = NSDate()
                    let birthdayFormatter = NSDateFormatter()
                    let calendar : NSCalendar = NSCalendar.currentCalendar()
                    birthdayFormatter.dateFormat = "MM/DD/YYYY"
                    let birthdayNSDate = birthdayFormatter.dateFromString(birthday as String)
                    
                    //MARK: Age information
                    let ageComponents = calendar.components(.Year,
                        fromDate: birthdayNSDate!,
                        toDate: currentDate,
                        options: [])
                    let userAge = ageComponents.year
                    
                    //let ageRangeMin = userData["age_range"]!["min"] as? Int
                    //let ageRangeMax = userData["age_range"]!["max"] as? Int
                    //print(ageRangeMin,ageRangeMax)
                    
                    //Handle Profile Photo URL String
                    let fbID: NSString = (result.valueForKey("id") as? NSString)!
                    
                    //MARK for large style
                    let pictureLargeURL = "https://graph.facebook.com/\(fbID)/picture?type=large&return_ssl_resources=1"
                    //url for profile picture photo
                    let URLLargeRequest = NSURL(string: pictureLargeURL)
                    var URLLargeRequestNeeded = NSURLRequest(URL: URLLargeRequest!)
                    let imageData = NSData(contentsOfURL: URLLargeRequest!)
                    let imageLarge = UIImage(data: imageData!)
                    let small = PFFile(data: imageData!)
                    let albumDict = userData["albums"]
                    
                    //print(albumDict!["data"]!![0]["name"])
                    
                    
                    
                    //MARK for medium style
                    let pictureNormalURL = "https://graph.facebook.com/\(fbID)/picture?type=normal&return_ssl_resources=1"
                    //url for profile picture photo
                    let URLNormalRequest = NSURL(string: pictureNormalURL)
                    var URLMediumRequestNeeded = NSURLRequest(URL: URLNormalRequest!)
                    let imageDataNormal = NSData(contentsOfURL: URLNormalRequest!)
                    let imageNormal = UIImage(data: imageDataNormal!)
                    let normal = PFFile(data: imageDataNormal!)
                    
                    //MARK for large photos
                    
                    
                    
                    //MARK for small style
                    let pictureSmallURL = "https://graph.facebook.com/\(fbID)/picture?type=small&return_ssl_resources=1"
                    //url for profile picture photo
                    let URLSmallRequest = NSURL(string: pictureSmallURL)
                    var URLSmallRequestNeeded = NSURLRequest(URL: URLSmallRequest!)
                    let imageDataSmall = NSData(contentsOfURL: URLSmallRequest!)
                    let imageSmall = UIImage(data: imageDataSmall!)
                    let large = PFFile(data: imageDataSmall!)
                    
                    // Name info
                    let email = userData["email"] as? String
                    let firstName  = userData["first_name"] as? String
                    let fullName = userData["name"] as? String
                    
                    
                    
                    
                    //location & more
                    //let location = userData["location"] as? String
                    let isVerifiedFacebook = userData["is_verified"] as? Bool
                    
                    //MARK: Send to parse
                    
                    
                    
                    PFUser.currentUser()!["age"] = userAge
                    PFUser.currentUser()!["birthday"] = birthdayNSDate
                    
                    PFUser.currentUser()!["fbID"] = fbID
                    PFUser.currentUser()!["email"] = email
                    PFUser.currentUser()!["firstName"] = firstName
                    PFUser.currentUser()!["fullName"] = fullName
                    
                    PFUser.currentUser()!["profilePicSmall"] = small
                    PFUser.currentUser()!["profilePicMedium"] = normal
                    PFUser.currentUser()!["profilePicLarge"] = large
                    
                    PFUser.currentUser()!["fbVerified"] = isVerifiedFacebook
                    
                    //Hamdle accessToken
                    
                    let fbUser = ["accessToken": accessToken, "user": result]
                }
            })
        }
        
        self.performSegueWithIdentifier("navigation", sender: nil)

    }*/
    
    
    /*func fetchFacebookAlbums(){
        
        if FBSDKAccessToken.currentAccessToken() != nil {
            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/photos", parameters: ["fields":"id,name,source"])
            graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                
                if ((error) != nil) {
                    //Handle error
                } else if let userData = result as? [String:AnyObject] {
                    
                    let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                    let fbUser = ["accessToken": accessToken, "user": result]
                    
                    //Handle Profile Photo URL String
                    let fbID: NSString = (result.valueForKey("id") as? NSString)!
                    
                    
                    // Handle for photo albums
                    let albumURL = "https://graph.facebook.com/\(fbID)/albums/photos?limit=20&access_token={\(accessToken)}"
                    let albumURLRequest = NSURL(string: albumURL)
                    var albumURLRequestNeeded = NSURLRequest(URL: albumURLRequest!)
                    
                    
                    //MARK: Send to parse
                    
                    
                    
                    /*PFUser.currentUser()!["age"] = userAge
                    PFUser.currentUser()!["ageRange"] = ageRange
                    PFUser.currentUser()!["birthday"] = birthdayNSDate
                    
                    PFUser.currentUser()!["fbID"] = fbID
                    PFUser.currentUser()!["email"] = email
                    PFUser.currentUser()!["firstName"] = firstName
                    PFUser.currentUser()!["fullName"] = fullName
                    
                    PFUser.currentUser()!["fbVerified"] = isVerifiedFacebook*/
                    //Hamdle accessToken
                    
                    
                }
            })
        }
        
    }*/


}

