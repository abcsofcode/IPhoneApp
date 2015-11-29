//
//  ViewController.swift
//  LemonAide
//
//  Created by Bob White on 2015-11-28.
//  Copyright © 2015 Bob White. All rights reserved.
//

// Declare global variables & constants
var registrationTokenString: String?
var storedVehicleCount = 0
var myID = ""

let URL_USER = NSURL(string: "http://hackathon.bobwhite.ca/android/insertuser.php");
let URL_VEHICLE = NSURL(string: "http://hackathon.bobwhite.ca/android/insertcar.php");

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!   
    
    @IBAction func registerButtonAction(sender: AnyObject)
    {
        // Get user data from text fields
        let fName = firstName.text
        let eMail = email.text
        let pWord = password.text
        
        // Send user data to remote server
        let request = NSMutableURLRequest(URL:URL_USER!)
        request.HTTPMethod = "POST";
        
        let postString = "nameId=\(fName!)&emailId=\(eMail!)&passwordId=\(pWord!)&regId=\(registrationTokenString!)";
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let session = NSURLSession.sharedSession();
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!
            
            NSUserDefaults.standardUserDefaults().setObject(urlContent, forKey: "userID")
        });
        
        task.resume();
        
        // Save user data on local device
        NSUserDefaults.standardUserDefaults().setObject(fName, forKey: "fName")
        NSUserDefaults.standardUserDefaults().setObject(eMail, forKey: "eMail")
        NSUserDefaults.standardUserDefaults().setObject(pWord, forKey: "pWord")
        NSUserDefaults.standardUserDefaults().setObject(registrationTokenString, forKey: "regID")
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
        self.performSegueWithIdentifier("toProfileSegue", sender: self)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        // Check if user/device already registered
        if let _ = NSUserDefaults.standardUserDefaults().objectForKey("fName")
        {
            // If registered, go to profile view
            self.performSegueWithIdentifier("toProfileSegue", sender: self)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Set delegates to self
        self.firstName.delegate = self
        self.email.delegate = self
        self.password.delegate = self
        
        // Set colours on UI elements
        firstNameLabel.textColor = UIColor.orangeColor()
        emailLabel.textColor = UIColor.orangeColor()
        passwordLabel.textColor = UIColor.orangeColor()        
        registerButton.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        
        // TODO - push notification code
        //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateRegistrationStatus:", name: appDelegate.registrationKey, object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "showReceivedMessage:", name: appDelegate.messageKey, object: nil)
    }
    
    // Touching outside textfield dismisses keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        view.endEditing(true)
        
        super.touchesBegan(touches, withEvent: event)
    }
    
    // Return button dismisses keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        
        return false
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

