

import Foundation
import UIKit

class LoginViewController: UIViewController{
    
    var isLogin:Bool = false

    @IBOutlet weak var btnLoginLogout: UIButton!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    var fbHelper:FBHelper!
    @IBAction func loginToFacebook(sender: AnyObject) {
        
        if(self.isLogin == false){
            self.loadingActivity.startAnimating()
            fbHelper.login();
        }
        else{
            fbHelper.logout();
            self.isLogin = false
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        self.loadingActivity.stopAnimating()
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate{
            self.fbHelper = delegate.fbHelper
        }
        super.viewDidDisappear(animated)
    }
    
    override func viewDidLoad() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("executeHandle:"), name: "PostData", object: nil);
        super.viewDidLoad()
    }
    
    func didLoginToFacebook(){
        
        self.fbHelper.login()
    }
    
    func executeHandle(notification:NSNotification){
        let userData = notification.object as! User;
        
        let name = userData.name as String;
        let email = userData.email as String;
        //lblName.text = name;
        //lblEmail.text = email;
        //imgProfile.image = userData.image;
        self.btnLoginLogout.titleLabel!.text = "        Logout        ";
        self.isLogin = true
        
        self.loadingActivity.stopAnimating()
        
        let homeViewController: ViewController! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("homeViewController") as! ViewController
        
        homeViewController.userData = userData
        self.navigationController?.pushViewController(homeViewController, animated: true)
        //fbHelper.fetchAlbum(userData);
        
    }
    
    
}