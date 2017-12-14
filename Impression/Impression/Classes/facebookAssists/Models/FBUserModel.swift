//
//  ViewController.swift
//  Impression
//
//  Created by Mar Nesbitt on 11/7/15.
//  Copyright © 2015 Mar Nesbitt. All rights reserved.
//

import Foundation
import UIKit


class UserObject{
    var email:String = "";
    var firstName:String = "";
    var fullName:String = "";
    var fbVerified:Bool = false;
    var age:Int;
    var birthday:String = "";
    var gender:String = "";
    var lookingFor:Array<String> = [""];
    let smallImage:UIImage;
    let normalImage:UIImage;
    let largeImage: UIImage;
    let id:String;
    //private let pfUser: PFUser
    
    init(email:String, firstName:String, fullName:String,smallImage:UIImage,normalImage:UIImage,largeImage:UIImage, id:String,age:Int,fbVerified:Bool,gender:String, lookingFor:Array<String>){
        self.smallImage = smallImage;
        self.normalImage = normalImage;
        self.largeImage = largeImage;
        self.firstName = firstName;
        self.fullName = fullName;
        self.email=email;
        self.id = id
        self.age = age
        self.fbVerified = fbVerified
        self.gender = gender
        self.lookingFor = lookingFor
        //self.pfUser = pfUser
    }
    
    class func this() -> UserObject{
        return UserObject(email: "", firstName: "",fullName: "", smallImage: UIImage(), normalImage: UIImage(), largeImage: UIImage(), id: "me", age:0, fbVerified: false, gender: "", lookingFor: [""])
    }
}