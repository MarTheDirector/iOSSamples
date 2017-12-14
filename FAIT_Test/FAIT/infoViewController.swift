//
//  infoViewController.swift
//  FAIT
//
//  Created by Mar Nesbitt on 5/16/15.
//  Copyright (c) 2015 FAIT App. All rights reserved.
//

import Foundation
import UIKit
import Parse

let validator = Validator()

class infoViewController: UIViewController, ValidationDelegate, UITextFieldDelegate {


    @IBOutlet weak var sendInfoButton: UIButton!
  
    @IBOutlet weak var emailInput: UITextField!
    
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var confirmPasswordInput: UITextField!
    @IBOutlet weak var termsLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentContainerView: UIView!
   
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var usernameImage: UIImageView!
    @IBOutlet weak var passwordImage: UIImageView!
    @IBOutlet weak var confirmPassswordImage: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
   
    
    
    
    
    let emailRed = UIImage(named: "emailRed.png")
    let passwordRed = UIImage(named: "pass1Red.png")
    let usernameRed = UIImage(named: "atRed.png")
    let confirmpasswordRed = UIImage(named: "pass2Red.png")
    
    let emailGray = UIImage(named: "email.png")
    let passwordGray = UIImage(named: "pass1.png")
    let usernameGray = UIImage(named: "at.png")
    let confirmpasswordGray = UIImage(named: "pass2.png")
    
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var confirmPasswordErrorLabel: UILabel!
    @IBOutlet weak var usernameErrorLabel: UILabel!
  
    
    
    @IBOutlet weak var emailConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailUnderlineConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailUnderline: UIView!
    
    
    @IBOutlet weak var usernameConstraint: NSLayoutConstraint!
    @IBOutlet weak var usernameUnderlineConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var usernameLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var usernameUnderline: UIView!
    
    
    
    @IBOutlet weak var passwordConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordUnderlineConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var passwordLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordUnderline: UIView!
    
    
    
    
    @IBOutlet weak var confirmPasswordConstraint: NSLayoutConstraint!
    @IBOutlet weak var confirmPasswordUnderlineConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var confirmLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var confirmPasswordUnderline: UIView!
    
    
    
 
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var fbButtonVerticalConstraint: NSLayoutConstraint!
   

   
    var firstTime =  true
    var faded = true
    
    var URLPath = "https://faitap.co"
    //var passedEmail = String()
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0,150,150)) as UIActivityIndicatorView
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTermsInfo()
        setupInput()
        keyboardGoAway()
        switchHide()
        
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.actInd)
       
        
        validator.styleTransformers(success:{ (validationRule) -> Void in
         //Start of success changes if inputs go through validator rule and changes need to happen
            
            
            // clear and hide error label
            validationRule.errorLabel?.hidden = true
            validationRule.errorLabel?.text = ""
            
            //change underline & icon color back to gray
            validationRule.line?.backgroundColor = UIColor(red: (123/255.0), green: (129/255.0), blue: (133/255.0), alpha: 1.0)
            validationRule.image!.image = validationRule.validIcon
            
                if(validationRule.textField == self.confirmPasswordInput){
                    //start of animation back to original position if it's confirm password input box i.e. changing fbButton position
                    self.view.layoutIfNeeded()
                    UIView.animateWithDuration(0.5, animations: {
                       
                        self.view.layoutIfNeeded()
                        
                        })

                   
                } //end of position animation for confirm password

            
                else {
                    //start of animation back up for the remaining input box views
                    
                    self.view.layoutIfNeeded()
                    UIView.animateWithDuration(0.5, animations: {
                        validationRule.viewConstraint?.constant = 0
                        self.view.layoutIfNeeded()
                        
                    })//end of animation back up input boxes
                
                //remaining animations back to position i.e. underline position & error labels
                self.view.layoutIfNeeded()
                UIView.animateWithDuration(0.5, animations: {
                   
                    validationRule.lineConstraint?.constant = 0
                    validationRule.errorConstraint?.constant = 0
                    
                    self.view.layoutIfNeeded()
                })//end of animations back up
                    
                }
                //end of success changes 
            
            }, error:{ (validationError) -> Void in
                
                //start of changes if error
               
                //changes underline color to red
                validationError.line?.backgroundColor = UIColor(red: (215/255.0), green: (118/255.0), blue: (118/255.0), alpha: 1.0)
                
                    //if confirm input error here starts animation to move fb button down
                    if (validationError.textField == self.confirmPasswordInput){
                        self.view.layoutIfNeeded()
                        UIView.animateWithDuration(0.5, animations: {
                            validationError.viewConstraint?.constant = 34
                            self.view.layoutIfNeeded()
                        })
                    }
                    //end of animation for confirm button
                    
                    //animation to move the rest of views down
                    else{
                    self.view.layoutIfNeeded()
                    UIView.animateWithDuration(0.5, animations: {
                        validationError.viewConstraint?.constant = 5
                        self.view.layoutIfNeeded()
                        })
                    }
                
                    //end of animation down for the rest of views
                
                //animation constants for the rest of vertical constraints, line moves down and error labels
                self.view.layoutIfNeeded()
                UIView.animateWithDuration(0.5, animations: {
                    validationError.lineConstraint?.constant = 10
                    validationError.errorConstraint?.constant = -20
                    self.view.layoutIfNeeded()
                })
                // end of animation down
                
                //giving error labels text based on rules classes and images
                validationError.errorLabel?.text = validationError.errorMessage
                validationError.image.image = validationError.errorIcon
                
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.07
                animation.repeatCount = 4
                animation.autoreverses = true
                animation.fromValue = NSValue(CGPoint: CGPointMake(validationError.image.center.x - 10, validationError.image.center.y))
                animation.toValue = NSValue(CGPoint: CGPointMake(validationError.image.center.x + 10, validationError.image.center.y))
                validationError.image.layer.addAnimation(animation, forKey: "position")
                
              
        })

        //registering validation fields with the items that need to be changed later on
        validator.registerField(emailInput, errorLabel: emailErrorLabel, rules: [RequiredRule(), EmailRule()], image: emailImage, viewConstraint: usernameConstraint,lineConstraint: emailUnderlineConstraint, errorConstraint: emailLabelConstraint, line: emailUnderline, validIcon: emailGray! )
        validator.registerField(usernameInput, errorLabel: usernameErrorLabel,   rules: [RequiredRule(), MaxLengthRule(length: 20)], image:  usernameImage, viewConstraint: passwordConstraint, lineConstraint: usernameUnderlineConstraint, errorConstraint: usernameLabelConstraint, line: usernameUnderline, validIcon: usernameGray!)
        validator.registerField(passwordInput, errorLabel: passwordErrorLabel,  rules: [RequiredRule(), PasswordRule()], image: passwordImage, viewConstraint: confirmPasswordConstraint, lineConstraint: passwordUnderlineConstraint, errorConstraint: passwordLabelConstraint, line: passwordUnderline, validIcon: passwordGray!)
        validator.registerField(confirmPasswordInput, errorLabel: confirmPasswordErrorLabel,  rules: [RequiredRule(), ConfirmationRule(confirmField: passwordInput)],image: confirmPassswordImage, viewConstraint: fbButtonVerticalConstraint, lineConstraint: confirmPasswordConstraint, errorConstraint: confirmLabelConstraint, line: confirmPasswordUnderline, validIcon: confirmpasswordGray!)
       
        //prevents input fields from clearing once clicked on
        emailInput.clearsOnBeginEditing = false
        usernameInput.clearsOnBeginEditing = false
        passwordInput.clearsOnBeginEditing = false
        confirmPasswordInput.clearsOnBeginEditing = false
        
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupTermsInfo(){
        //here we are setting up a variable that contains the NSString for our terms and agreements
        let terms = "By continuing you agree to FAIT's Terms & Conditions and privacy policy" as NSString
        
        
        //Here we are assigning a NSMutableAtrributedString for previously set up terms, this allows us to change the color of different characters in the string based on where character is located attributedInfo is the base string
        var attributedInfo = NSMutableAttributedString(string: terms as String)
        
        //intial attribute that's common white lettering that's reuseable for base string
        let whiteAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        //attributes that we want to change for each page
        let underlineBlueAttributes = [NSForegroundColorAttributeName: UIColor(red: (107.0/255.0), green: (185.0/255.0), blue: (198.0/255.0), alpha: 1.0),  NSUnderlineStyleAttributeName: 1]
        
        //where we are assigning the above changes to different parts of our base mutable string
        attributedInfo.addAttributes(whiteAttributes, range: terms.rangeOfString("By continuing you agree to FAIT's"))
        attributedInfo.addAttributes(underlineBlueAttributes, range: terms.rangeOfString("Terms & Conditions"))
        attributedInfo.addAttributes(whiteAttributes, range: terms.rangeOfString("and"))
        attributedInfo.addAttributes(underlineBlueAttributes, range: terms.rangeOfString("privacy policy"))
        
        //finally changing our termslabel text to equal our base mutable string
        self.termsLabel.attributedText = attributedInfo

    }
    
    
    func setupInput(){
        
        // This function is used to set up the display input settings for information page
        
        
        
        //we are assigning the passedemail address from previous page to auto populate emailinput in this page
        //emailInput.text = passedEmail
        
        
                // here we are simply assigning what the placeholder text will read and in which color for each input box
        usernameInput.attributedPlaceholder = NSAttributedString(string:"Username", attributes:[NSForegroundColorAttributeName:  UIColor(red: (123/255.0), green: (129/255.0), blue: (133/255.0), alpha: 1.0)])
        
        emailInput.attributedPlaceholder = NSAttributedString(string:"Email", attributes:[NSForegroundColorAttributeName:  UIColor(red: (123/255.0), green: (129/255.0), blue: (133/255.0), alpha: 1.0)])
        
        passwordInput.attributedPlaceholder = NSAttributedString(string:"Password", attributes:[NSForegroundColorAttributeName:  UIColor(red: (123/255.0), green: (129/255.0), blue: (133/255.0), alpha: 1.0)])
        
        confirmPasswordInput.attributedPlaceholder = NSAttributedString(string:"Confirm Password", attributes:[NSForegroundColorAttributeName:  UIColor(red: (123/255.0), green: (129/255.0), blue: (133/255.0), alpha: 1.0)])
        

    }
    
    func keyboardGoAway(){
        //in this function we are setting up different methods that can be used to take away our keyboard
        
        //we are setting up a variable that will call an action based on a swip
        var swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //declare which direction we are expecting and how that corresponds to the uiswipegesturerecognizerdirection
        swipe.direction = UISwipeGestureRecognizerDirection.Down
        
        //adding our swip to the current view that we're working on
        self.view.addGestureRecognizer(swipe)
        
        //assigning another recognizer that will see if tapped
        let tapRec = UITapGestureRecognizer()
        //for this tap call action tappedview
        tapRec.addTarget(self, action: "tappedView")
        //add recognizer to our main gestures recognizer on this page
        contentContainerView.addGestureRecognizer(tapRec)
        //enable userinteractions
        contentContainerView.userInteractionEnabled = true
       
    }
    
    func tappedView(){
        //just saying that we're done with editing so dismiss keyboard
        isEmpty()
        self.view.endEditing(true)
    }
    
    
    //built in method
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        //we call end editing which states that we are done editing with any object that was marked as firstresponder
        if let touch = touches.first as? UITouch {
            let location = touch.locationInView(self.view)
            self.view.endEditing(true)
        }
    }
    
    func loadHyperLinkg(){
    
        let requestURL = NSURL(string: URLPath)
        let request =  NSURLRequest(URL:requestURL!)
    
    }
    
    func switchHide(){
        if(firstTime == true){
         sendButton.hidden = true
           // sendButton.alpha = 0.3
        }
    }
 
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        //this function is used to see which current input field we are on and change the "first reponder" aka which field we are currently tapped on based on  our current field.
        switch textField {
        case self.emailInput:
            
            self.usernameInput.becomeFirstResponder()
            break
        case self.usernameInput:
            
            self.passwordInput.becomeFirstResponder()
            break
        case self.passwordInput:
            
            
            self.confirmPasswordInput.becomeFirstResponder()
            break
        case self.confirmPasswordInput:
            
             isEmpty()
            self.resignFirstResponder()
            break
           
             
        default:
            
           break
        }
        
        
        textField.resignFirstResponder()
        
        
        
        return true
    }
    
    
    
    func dismissKeyboard(){
        
        self.view.endEditing(true)
        isEmpty()
        
    }
    
    @IBAction func sendingUserInput(sender: AnyObject) {
        //checkIfEmpty()
        //if (faded == false) {
        validator.validate(self)
        //}
    }
    
    
    
    func isEmpty(){
        
        var username = usernameInput.text
        var email = emailInput.text
        var password = passwordInput.text
        var confirmPassword = confirmPasswordInput.text
        
        let user = [username,email, password,confirmPassword]
        let count = user.count
        
        var fields = 0
        
        for items in user  {
            
            if(!items.isEmpty){
                fields++
                if(fields == count){
                sendButton.hidden = false
                //sendButton.alpha = 0.3
                faded = true
                }
            }
            else {
                sendButton.hidden = true
                 //sendButton.alpha = 1
                faded = false
            }
            
            
            
        }
        
    }
    
    
    
       
    
    func validateEmail(email: String)  {
        
     //do something with email
        
    }
    
    // MARK: ValidationDelegate Methods
    
    func validationSuccessful() {
        /*println("Validation Success!")
        var alert = UIAlertController(title: "Success", message: "You are validated!", preferredStyle: UIAlertControllerStyle.Alert)
        var defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(defaultAction)
        self.presentViewController(alert, animated: true, completion: nil)*/
        
        sendToParse()
        
    }
    func validationFailed(errors:[UITextField:ValidationError]) {
        //println("Validation FAILED!")
    }

    

    
    func textFieldDidBeginEditing(textField: UITextField) {
        
      
       
        
        switch textField {
        case usernameInput:
            scrollView.setContentOffset(CGPointMake(0, 30), animated: true)
        case self.emailInput:
            scrollView.setContentOffset(CGPointMake(0, 30), animated: true)
        case self.passwordInput:
            scrollView.setContentOffset(CGPointMake(0, 30), animated: true)
        case self.confirmPasswordInput:
            scrollView.setContentOffset(CGPointMake(0, 50), animated: true)
        default:
          scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
        }

        
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
        
    }
    
    
    //MARK: Actions
    func sendToParse(){
        
        var username = usernameInput.text
        var password = passwordInput.text
        var email = emailInput.text
        
        self.actInd.startAnimating()
    
        var newUser = PFUser()
        
        newUser.username = username
        newUser.password = password
        newUser.email = email
        
        newUser.signUpInBackgroundWithBlock { (succeed, error) -> Void in
            self.actInd.startAnimating()
            
            if ((error) != nil){
                
                var errorCode = error!.code
                switch errorCode {
                case 100:
                    println("ConnectionFailed")
                    break
                case 202:
                    self.usernameImage.image = self.usernameRed
                    self.usernameUnderline.backgroundColor  = UIColor(red: (215/255.0), green: (118/255.0), blue: (118/255.0), alpha: 1.0)
                    self.usernameErrorLabel.hidden = false
                   
                    //animation constants for the rest of vertical constraints, line moves down and error labels
                    self.view.layoutIfNeeded()
                    UIView.animateWithDuration(0.5, animations: {
                        self.usernameConstraint.constant = 5
                        self.usernameUnderlineConstraint.constant = 10
                        self.usernameLabelConstraint.constant = -10
                        self.view.layoutIfNeeded()
                    })
                    // end of animation down
                    
                    //giving error labels text based on rules classes and images
                    self.usernameErrorLabel?.text = "Sorry,  \(username) is taken."
                   
                    
                    let animation = CABasicAnimation(keyPath: "position")
                    animation.duration = 0.07
                    animation.repeatCount = 4
                    animation.autoreverses = true
                    animation.fromValue = NSValue(CGPoint: CGPointMake(self.usernameImage.center.x - 10, self.usernameImage.center.y))
                    animation.toValue = NSValue(CGPoint: CGPointMake(self.usernameImage.center.x + 10, self.usernameImage.center.y))
                   self.usernameImage.layer.addAnimation(animation, forKey: "position")
                    

                    //println(username + "is taken")
                    break
                case 203:
                    self.emailImage.image = self.emailRed
                    self.emailUnderline.backgroundColor  = UIColor(red: (215/255.0), green: (118/255.0), blue: (118/255.0), alpha: 1.0)
                    self.emailErrorLabel.hidden = false
                    
                    //animation constants for the rest of vertical constraints, line moves down and error labels
                    self.view.layoutIfNeeded()
                    UIView.animateWithDuration(0.5, animations: {
                        self.emailConstraint.constant = 5
                        self.emailUnderlineConstraint.constant = 10
                        self.emailLabelConstraint.constant = -10
                        self.view.layoutIfNeeded()
                    })
                    // end of animation down
                    
                    //giving error labels text based on rules classes and images
                    self.emailErrorLabel?.text = "Email already used. Please try another"
                    
                    
                    let animation = CABasicAnimation(keyPath: "position")
                    animation.duration = 0.07
                    animation.repeatCount = 4
                    animation.autoreverses = true
                    animation.fromValue = NSValue(CGPoint: CGPointMake(self.emailImage.center.x - 10, self.emailImage.center.y))
                    animation.toValue = NSValue(CGPoint: CGPointMake(self.emailImage.center.x + 10, self.emailImage.center.y))
                    self.emailImage.layer.addAnimation(animation, forKey: "position")
                    

                    //println(password + " is taken")
                    break
                default:
                    break
                }

                /*println(error!.localizedDescription)
                var alert = UIAlertView(title: "Error", message: "\(error!.localizedDescription) In", delegate: self, cancelButtonTitle: "OK")
                alert.show()*/
            }
            else {
            
                var alert = UIAlertView(title: "Succcess", message: "you are part of FAIT", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
             //send to instructions page
                }
                
                
            }
        }
    
   
}