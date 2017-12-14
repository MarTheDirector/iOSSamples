

import Foundation
import UIKit

class User{
    var email:String = "";
    var name:String = "";
    let image:UIImage;
    let id:String;
    
    init(email:String, name:String, image:UIImage, id:String){
        self.image = image
        self.name = name;
        self.email=email;
        self.id = id
        
    }
    
    class func this() -> User{
        return User(email: "", name: "", image: UIImage(), id: "me")
    }
}