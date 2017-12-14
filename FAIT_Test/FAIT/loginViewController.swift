//
//  loginViewController.swift
//  FAIT
//
//  Created by Mar Nesbitt on 5/12/15.
//  Copyright (c) 2015 FAIT App. All rights reserved.
//
import Foundation
import UIKit
import Parse

class loginViewController: UIViewController, UITextFieldDelegate {
   
    
    
    // This constraint ties an element at zero points from the bottom layout guide
    
    @IBOutlet weak var emailUsernameTextField: UITextField!
   
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var faitLogo: UIImageView!
    @IBOutlet weak var fbVerticalSpace: NSLayoutConstraint!

    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var contentContainerVerticalSpace: NSLayoutConstraint!
    
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPassword: UIButton!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailUnderline: grayLine!
    @IBOutlet weak var emailUnderlineConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordUnderline: grayLine!
    @IBOutlet weak var passwordUnderlineConstraint: NSLayoutConstraint!
    
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0,150,150)) as UIActivityIndicatorView
    var timesThroughAnimation = 0
    var ct = true
    var firstAnimation = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.actInd.center = self.view.center
            self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.actInd)
        loginButton.hidden = true
        emailUsernameTextField.delegate = self
        passwordTextField.delegate = self
        var screenWidth: CGFloat=0.0
        var screenHeight: CGFloat=0.0
        var screenSize: CGRect = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        var loginX = loginButton.frame.origin.x
        var loginY = loginButton.frame.origin.y
       
        setupInput()
        keyboardGoAway()
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Check to see status of  textfield input then animate login button slide in slide out
    var timer: NSTimer? = nil
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("getHints:"), userInfo: textField, repeats: false)
       
        
        
        return true
    }
    
    func getHints(timer: NSTimer) {
        
        //println("Hints for textField: \(timer.userInfo!)")
        statusOfField()
        
    }
    

    func statusOfField(){
    
        
        
        if(isEmpty(emailUsernameTextField) && isEmpty(passwordTextField)){
            if(ct ==  true){
            
            self.loginButton.slideInFromLeft()
            self.loginButton.hidden = false
             ct = false
            }
        }
        
        else {
           
           self.view.layoutIfNeeded()
            UIView.animateWithDuration(0.5, animations: {
                self.loginButton.hidden = true
                self.view.layoutIfNeeded()
                
                })
            
            ct = true
        }
        
     
       
    }
            
    //MARK: Check If Empty
    
    func isEmpty(field: UITextField) -> Bool{
        
        var textField = field.text
        
        if (!textField.isEmpty) {
        return true
        }
        else {
        return false
        }
        
    }

    
  
    
    
    
    func setupInput(){
        // Do any additional setup after loading the view, typically from a nib.
        emailUsernameTextField.attributedPlaceholder = NSAttributedString(string:"Email/Username", attributes:[NSForegroundColorAttributeName: UIColor(red: (123/255.0), green: (129/255.0), blue: (133/255.0), alpha: 1.0)])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string:"Password", attributes:[NSForegroundColorAttributeName:  UIColor(red: (123/255.0), green: (129/255.0), blue: (133/255.0), alpha: 1.0)])
    }
    
    
    
    //NARJ: Getting rid of keeyboards
    func keyboardGoAway(){
        
        var swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "dismissKeyboard")
        
        swipe.direction = UISwipeGestureRecognizerDirection.Down
        
        self.view.addGestureRecognizer(swipe)
        
        emailUsernameTextField.delegate = self
        passwordTextField.delegate = self
        
        let tapRec = UITapGestureRecognizer()
        tapRec.addTarget(self, action: "tappedView")
        contentContainerView.addGestureRecognizer(tapRec)
        contentContainerView.userInteractionEnabled = true
    }

    
    func tappedView(){
        self.view.endEditing(true)
        self.view.endEditing(true)
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.5, animations: {
            self.contentContainerVerticalSpace.constant = 100
            self.xButton.alpha = 1.0
            self.faitLogo.transform  = CGAffineTransformMakeScale(1.0, 1.0)
            self.fbVerticalSpace.constant = 50
            self.view.layoutIfNeeded()
            self.firstAnimation = true
        })
        

    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().statusBarHidden = false
        
    }
    
   
    
    
    func dismissKeyboard(){
        self.view.endEditing(true)
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.5, animations: {
            self.contentContainerVerticalSpace.constant = 100
            self.xButton.alpha = 1.0
            self.faitLogo.transform  = CGAffineTransformMakeScale(1.0, 1.0)
             self.fbVerticalSpace.constant = 50
            self.view.layoutIfNeeded()
             self.firstAnimation = true
        })
        
        

    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == self.emailUsernameTextField {
           
             self.passwordTextField.becomeFirstResponder()
        }
        
        switch textField {
        case self.emailUsernameTextField:
            self.passwordTextField.becomeFirstResponder()
            break
        case self.passwordTextField:
            self.resignFirstResponder()
            self.view.endEditing(true)
            self.view.layoutIfNeeded()
            UIView.animateWithDuration(0.5, animations: {
                self.contentContainerVerticalSpace.constant = 100
                self.xButton.alpha = 1.0
                self.faitLogo.transform  = CGAffineTransformMakeScale(1.0, 1.0)
                self.fbVerticalSpace.constant = 50
                self.view.layoutIfNeeded()
                self.firstAnimation = true
            })

            break
            
        default:
            break
        }

        
        
        

        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
      
        
        if(firstAnimation == true ){
            self.view.layoutIfNeeded()
            UIView.animateWithDuration(0.5, animations: {
                self.contentContainerVerticalSpace.constant = 2
                self.faitLogo.transform  = CGAffineTransformMakeScale(0.5, 0.5)
                self.fbVerticalSpace.constant = 16
                self.xButton.alpha = 0.0
                self.view.layoutIfNeeded()
                
                }, completion: {
                    (value: Bool) in
                    self.firstAnimation = false
            })
            
           
        }
            
        
        
        
        if (textField == emailUsernameTextField){
          
        scrollView.setContentOffset(CGPointMake(0, 25), animated: true)
            
        }
        else{
            
        scrollView.setContentOffset(CGPointMake(0, 25), animated: true)
           
        
        }
       
        //println(timesThroughAnimation)
        
    }
    
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        
        
            scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
    }

    /*override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
    
        
    
    }*/

    
 

    //MARK: Actions

    @IBAction func loginAction(sender: AnyObject) {

        var username = self.emailUsernameTextField.text
        var password = self.passwordTextField.text
        var didSucceed = false
       
        
        
            self.actInd.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username, password: password, block: {(user, error)  ->
            Void in
            
                self.actInd.stopAnimating()
                
                if((user) != nil){
                    
                    /*var alert = UIAlertView(title: "Succcess", message: "logged In", delegate: self, cancelButtonTitle: "OK")
                    alert.show()*/
                    self.performSegueWithIdentifier("login", sender: self)
                }
                else{
                    
                    
                    /* var alert = UIAlertView(title: "Error", message: "\(error!.localizedDescription)", delegate: self, cancelButtonTitle: "OK")
                    
                    alert.show()*/
                    
                    var errorCode = error!.code
                    
                    
                    
                    var userField = self.emailUsernameTextField
                    
                    var userLine = self.emailUnderline
                    
                    var passwordField = self.passwordTextField
                    
                    var passwordLine = self.passwordUnderline
                    
                    
                    
                    
                    
                    
                    
                    let animation = CABasicAnimation(keyPath: "position")
                    
                    animation.duration = 0.07
                    
                    animation.repeatCount = 4
                    
                    animation.autoreverses = true
                    
                    
                    
                    let part = [userField,userLine, passwordField,passwordLine]
                    
                    
                    
                    
                    
                    for items in part  {
                        
                        
                        
                        animation.fromValue = NSValue(CGPoint: CGPointMake(items.center.x - 10, items.center.y))
                        
                        animation.toValue = NSValue(CGPoint: CGPointMake(items.center.x + 10, items.center.y))
                        
                        items.layer.addAnimation(animation, forKey: "position")
                    }

                    
                }
                
                
            })
        
    }
  
    @IBAction func forgotPasswordAction(sender: AnyObject) {
        var username = self.emailUsernameTextField.text
        
        PFUser.requestPasswordResetForEmailInBackground(username, block: { (succeeded: Bool, error: NSError?) -> Void in
            if error == nil {
                if succeeded { // SUCCESSFULLY SENT TO EMAIL
                    println("Reset email sent to your inbox");
                }
                else { // SOME PROBLEM OCCURED
                }
            }
            else { //ERROR OCCURED, DISPLAY ERROR MESSAGE
                println(error!.description);
            }
        });
    }
   
}