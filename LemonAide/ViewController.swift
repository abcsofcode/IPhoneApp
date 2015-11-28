//
//  ViewController.swift
//  LemonAide
//
//  Created by Bob White on 2015-11-28.
//  Copyright © 2015 Bob White. All rights reserved.
//

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
        let fName = firstName.text
        let eMail = email.text
        let pWord = password.text
        
        
        
        let url = NSURL(string: "http://hackathon.bobwhite.ca/android/insertuser.php");
        let request = NSMutableURLRequest(URL:url!)
        request.HTTPMethod = "POST";
        
        let postString = "nameId=\(fName!)&emailId=\(eMail!)&passwordId=\(pWord!)";
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = NSURLSession.sharedSession();
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!
            print("Data: \(urlContent)");
        });
        
        task.resume();
        
        
        
        
        
        // URL to send registration information
        //let APP_SERVER_URL = "http://hackathon.bobwhite.ca/android/insertuser.php";
        
        
        //let APP_SERVER_URL = "http://hackathon.bobwhite.ca/GCM/gcm.php?shareRegId=true";
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.firstName.delegate = self
        self.email.delegate = self
        self.password.delegate = self
        
        firstNameLabel.textColor = UIColor.orangeColor()
        emailLabel.textColor = UIColor.orangeColor()
        passwordLabel.textColor = UIColor.orangeColor()        
        registerButton.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateRegistrationStatus:", name: appDelegate.registrationKey, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showReceivedMessage:", name: appDelegate.messageKey, object: nil)
    
        print("viewDidLoad")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
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

