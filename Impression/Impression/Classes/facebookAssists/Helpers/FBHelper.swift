//
//  ViewController.swift
//  Impression
//
//  Created by Mar Nesbitt on 11/7/15.
//  Copyright © 2015 Mar Nesbitt. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import FBSDKCoreKit
import FBSDKShareKit
//import FBAudienceNetwork


class FBHelper{
    var accessToken: FBSDKAccessToken?
    let baseUrl = "https://graph.facebook.com/"
    init(){
        accessToken = FBSDKAccessToken.currentAccessToken()
    }
    
    func fetchFriendsPhoto(link:String, completionHandler: (img:UIImage)->()){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
            
            
            let userImageURL = "\(self.baseUrl)\(link)/picture?type=album&access_token=\(self.accessToken!.tokenString)";
            
            let url = NSURL(string: userImageURL);
            
            let imageData = NSData(contentsOfURL: url!);
            
            if let imageDataHas = imageData{
                let image = UIImage(data: imageData!);
                
                completionHandler(img: image!)
            }
            
        })
    }
    
    func fetchPhoto(link:String, addItemToTable: (album:AlbumImage)->()){
        
            let fbRequest = FBSDKGraphRequest(graphPath: link, parameters: nil, HTTPMethod: "GET")
        fbRequest.startWithCompletionHandler { (connection:FBSDKGraphRequestConnection!, data:AnyObject!, error:NSError!) -> Void in
            if let gotError = error{
                print("Error: %@", gotError)
            }
            else{
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
                    
                    //println(data)
                    var pictures:[AlbumImage] = [AlbumImage]();
                    let graphData = data.valueForKey("data") as! Array<AnyObject>;
                    var albums:[AlbumModel] =  [AlbumModel]();
                    
                    for obj:AnyObject in graphData{
                        //println(obj.description);
                        //println(obj)
                        
                        let pictureId = obj.valueForKey("id") as! String;
                        
                        let smallImageUrl = "\(self.baseUrl)\(pictureId)/picture?type=thumbnail&access_token=\(self.accessToken!.tokenString)";
                        let url = NSURL(string: smallImageUrl);
                        let picData = NSData(contentsOfURL: url!);
                        
                        var img:UIImage? = nil
                        if let picDataHas = picData{
                            img = UIImage(data: picData!);
                        }
                        
                        
                        let bigImageUrl = "\(self.baseUrl)\(pictureId)/picture?type=normal&access_token=\(self.accessToken!.tokenString)";
                        let sourceURL = NSURL(string: bigImageUrl)
                        let sourceData = NSData(contentsOfURL: sourceURL!)
                        
                        var sourceImg:UIImage? = nil
                        if let hasSouceData = sourceData{
                            sourceImg = UIImage(data: hasSouceData)
                        }
                        
                        
                       /* let commentLink = "\(self.baseUrl)\(pictureId)/comments?access_token=\(self.accessToken!.tokenString)"
                        let likeLink = "\(self.baseUrl)\(pictureId)/likes?access_token=\(self.accessToken!.tokenString)"
                        
                        
                        var commentsByUser = self.executeComment(commentLink)
                        var likesByUser = self.executeLike(likeLink)*/
                        
                        
                        
                        //println("Comment: \(commentLink)")
                        //println("Like: \(likeLink)")
                        
                        
                        
                        //pictures.append(AlbumImage(smallImage: img!, bigImage: sourceImg!));
                        //addItemToTable(album: AlbumImage(smallImage: img!, bigImage: sourceImg!, likes: likesByUser, comments: commentsByUser))
                        addItemToTable(album: AlbumImage(smallImage: img!, bigImage: sourceImg!))

                        //NSThread.sleepForTimeInterval(2)
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName("photoNotification", object: nil, userInfo: nil);
                })
                
                
            }
        }
        
        
    }
    
    /*func executeLike(likeLink:String) -> [Like]{
        let request = NSMutableURLRequest(URL: NSURL(string: likeLink)!)
        request.HTTPMethod = "GET"
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if let httpResponse = response as? NSHTTPURLResponse {
                print("Status code: (\(httpResponse.statusCode))")
                
                // do stuff.
            }
        })
        
        task.resume()
        
        var connection : NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        connection.start()
        //let session = NSURLSession.sharedSession()
        var likes = [Like]()
        
        var responseObject:NSURLResponse?
        var err:NSErrorPointer = NSErrorPointer()
        
        var responseData: NSURLConnection?
        
        //MARK: Trying to get data back start
        do {
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &responseObject)
            print(responseObject)
            
            do{
                let likeResponse = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                
                if let likeDict:NSDictionary = likeResponse as? NSDictionary{
                    let data = likeDict.objectForKey("data") as! NSArray
                    //println(data)
                    for likeObj in data{
                        likes.append(Like(likeBy: likeObj.valueForKey("name") as? String, likeDate: "", likeByUrl: likeObj.valueForKey("id") as? String, likeByImage: nil))
                    }
                    
                }
                
            } catch {
                
                // handle error
                print(error)
                
            }
            
            // Parse the data
        } catch {
            // handle error
            print(error)
       
        }
        
        return likes
    }*/
    
    /*class func sendSynchronousRequest(request: NSURLRequest,
        returningResponse response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>) throws -> NSData
    
    func executeComment(commentLink:String) -> [Comment]{
        let request = NSMutableURLRequest(URL: NSURL(string: commentLink)!)
        request.HTTPMethod = "GET"
        let session = NSURLSession.sharedSession()
        var comments = [Comment]()
        
        var responseObject:NSURLResponse?
        var err:NSErrorPointer = NSErrorPointer()
        
        let params = ["commentString":"commentString", "commentBy":"commentBy", "commentLocation":"commentLocation","commentDate":"commentDate","commentByUrl":"commentByUrl","commentByImage":"commentByImage"] as Dictionary<String, String>
        
        
        do {
            let responseData = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &responseObject)
            print(responseData)
            
            do{
                var likeResponse = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                
                if let likeDict:NSDictionary = likeResponse as? NSDictionary{
                    let data = likeDict.objectForKey("data") as! NSArray
                    //println(data)
                    for commentObj in data{
                        comments.append(Comment(commentString: commentObj.valueForKey("message") as? String, commentBy: commentObj.valueForKey("from")?.valueForKey("name") as? String, commentLocation: "", commentDate: "", commentByUrl: commentObj.valueForKey("from")?.valueForKey("id") as? String, commentByImage: nil))
                    }
                }

            } catch {
                // handle error
                print(error)
            }
            // Parse the data
        } catch {
            // handle error
            print(error)
        }
        
        return comments
    }*/
    
    
    
    func fetchCoverPhoto(coverLink: String, completion:(image:UIImage)->()){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
            
            
            //http://graph.facebook.com/v2.4/10150192451235958/picture?type=thumbnail
            let userImageURL = "\(self.baseUrl)\(coverLink)?type=album&access_token=\(self.accessToken!.tokenString)";
            
            let url = NSURL(string: userImageURL);
            
            let imageData = NSData(contentsOfURL: url!);
            
            if let imageDataHas = imageData{
                let image = UIImage(data: imageData!);
                
                completion(image: image!)
            }
            
        })
    }
    
    func fetchNewPhoto(link:String, completionHandler:()->()){
        
        let fbRequest = FBSDKGraphRequest(graphPath: link, parameters: nil, HTTPMethod: "GET")
        
        fbRequest.startWithCompletionHandler { (connection:FBSDKGraphRequestConnection!, data:AnyObject!, error:NSError!) -> Void in
            if let gotError = error{
                print("Error: %@", gotError)
            }
            else{
                print(data)
            }
        }
    }
    
    
    
    
    func fetchAlbum(user:UserObject){
        
        let userImageURL = "\(self.baseUrl)\(user.id)/albums?access_token=\(self.accessToken!.tokenString)";
        
        let graphPath = "/\(user.id)/albums";
        let request =  FBSDKGraphRequest(graphPath: graphPath, parameters: nil, HTTPMethod: "GET")
        request.startWithCompletionHandler { (connection:FBSDKGraphRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
            if let gotError = error{
                print(gotError.description);
            }
            else{
              
                let graphData = result.valueForKey("data") as! Array<AnyObject>;
                var albums:[AlbumModel] =  [AlbumModel]();
                for obj:AnyObject in graphData{
                    let desc = obj.description;
                    //println(desc);
                    let name = obj.valueForKey("name") as! String;
                    //println(name);
                    let id = obj.valueForKey("id") as! String;
                    var cover = "";
                    
                    cover = "\(id)/picture";
                    
                    
                    //println(coverLink);
                    let link = "\(id)/photos";
                    
                    let model = AlbumModel(name: name, link: link, cover:cover);
                    albums.append(model);
                    
                }
                NSNotificationCenter.defaultCenter().postNotificationName("albumNotification", object: nil, userInfo: ["data":albums]);
            }
        }
    }
    
    func logout(){
        FBSDKLoginManager().logOut()
    }
    
    func readPermission() -> [String]{
        return ["email", "user_photos", "user_friends", "public_profile", "user_birthday", "user_relationship_details"]
        
    }
    
    func login(){
        
        let loginManager = FBSDKLoginManager()
        loginManager.logInWithReadPermissions(["email", "public_profile", "user_friends", "user_photos", "user_birthday", "user_relationship_details"], handler: { (result:FBSDKLoginManagerLoginResult!, error:NSError!) -> Void in
            
            if let gotError = error{
                //got error
            }
            else if(result.isCancelled){
                print("login canceled")
            }
            else{
                
                //print(result.grantedPermissions)
                if(result.grantedPermissions.contains("email") && result.grantedPermissions.contains("public_profile") && result.grantedPermissions.contains("user_friends") && result.grantedPermissions.contains("user_birthday") && result.grantedPermissions.contains("user_photos")){
                    
                    let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,email,name,first_name,birthday,age_range,is_verified,picture,albums,gender,interested_in"], HTTPMethod: "GET")
                    request.startWithCompletionHandler({ (connection:FBSDKGraphRequestConnection!, data:AnyObject!, error:NSError!) -> Void in
                        
                        if let gotError = error{
                            //got error
                        }
                        else {
                            
                            
                         
                            let email : String = data.valueForKey("email") as! String;
                            let firstName:String = data.valueForKey("first_name") as! String;
                            let fullName:String = data.valueForKey("name") as! String;
                            let userFBID:String = data.valueForKey("id") as! String;
                            let birthday : String = data.valueForKey("birthday") as! String;
                            let gender : String = data.valueForKey("gender") as! String;
                            let lookingFor : Array<String>= data.valueForKey("interested_in") as! Array<String>;
                            let fbVerified: Bool = (data.valueForKey("is_verified") as? Bool)!
                            //  Mark: Birthday Info being set up here
                            let currentDate = NSDate()
                            let birthdayFormatter = NSDateFormatter()
                            let calendar : NSCalendar = NSCalendar.currentCalendar()
                            birthdayFormatter.dateFormat = "MM/DD/YYYY"
                            let birthdayNSDate = birthdayFormatter.dateFromString(birthday as String)

                            
                            
                            let userImageURLSmall = "https://graph.facebook.com/\(userFBID)/picture?type=small";
                            
                            let urlSmall = NSURL(string: userImageURLSmall);
                            
                            let imageDataSmall = NSData(contentsOfURL: urlSmall!);
                            
                            let imageSmall = UIImage(data: imageDataSmall!);
                            
                            // let small = PFFile(data: imageDataSmall!)
                            
                            //Normall
                            
                            let userImageURLNormal = "https://graph.facebook.com/\(userFBID)/picture?type=normal";
                            
                            let urlNormal = NSURL(string: userImageURLNormal);
                            
                            let imageDataNormal = NSData(contentsOfURL: urlNormal!);
                            
                            let imageNormal = UIImage(data: imageDataNormal!);
                            
                            //let normal = PFFile(data: imageDataNormal!)
                            
                            //Large
                            
                            let userImageURLLarge = "https://graph.facebook.com/\(userFBID)/picture?type=large";
                            
                            let urlLarge = NSURL(string: userImageURLLarge);
                            
                            let imageDataLarge = NSData(contentsOfURL: urlLarge!);
                            
                            let imageLarge = UIImage(data: imageDataLarge!);
                            
                            //let large = PFFile(data: imageDataLarge!)
                            
                            
                            
                            //MARK: Age information
                            let ageComponents = calendar.components(.Year,
                                fromDate: birthdayNSDate!,
                                toDate: currentDate,
                                options: [])
                            let userAge = ageComponents.year 
                            
                          /* let profilePicture = PFObject(className: "profilePicture")
                            
                            profilePicture["size"] = "small"
                            profilePicture["imageFile"] = small
                        
                            
                            
                            
                            PFUser.currentUser()!["age"] = userAge
                            PFUser.currentUser()!["birthday"] = birthdayNSDate
                            
                            PFUser.currentUser()!["fbID"] = userFBID
                            PFUser.currentUser()!["email"] = email
                            PFUser.currentUser()!["firstName"] = firstName
                            PFUser.currentUser()!["fullName"] = fullName
                            
                            PFUser.currentUser()!["profilePicSmall"] = small
                            PFUser.currentUser()!["profilePicMedium"] = normal
                            PFUser.currentUser()!["profilePicLarge"] = large
                            
                            PFUser.currentUser()!["fbVerified"] = fbVerified*/

                            
                            //print("userFBID: \(userFBID) \n Email \(email) \n firstName:\(firstName)\n fullName:\(fullName) \n image: \(imageSmall)\n imageNormal: \(imageNormal)\n imageLarge: \(imageLarge)\n birthday: \(birthday)\n age: \(userAge)\n gender: \(gender)\n interested in: \(lookingFor)");
                            
                           var userModel = UserObject(email: email, firstName: firstName,fullName: fullName, smallImage: imageSmall!, normalImage: imageNormal!, largeImage: imageLarge! ,id: userFBID, age: userAge, fbVerified:  fbVerified, gender: gender, lookingFor: lookingFor);
                            
                            
                            self.accessToken = FBSDKAccessToken.currentAccessToken();
                            
                            NSNotificationCenter.defaultCenter().postNotificationName("PostData", object: userModel, userInfo: nil);
                        }
                    })
                    
                    //self.accessToken = FBSDKAccessToken.currentAccessToken();
                }
                
            }
        })
    }
    
}