//
//  ViewController.swift
//  LemonAide
//
//  Created by Bob White on 2015-11-28.
//  Copyright © 2015 Bob White. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        
        
        let url = NSURL(string: "http://www.myserver.com/test.php");
        let request = NSMutableURLRequest(URL:url!)
        request.HTTPMethod = "POST";
        
        let postString = "firstName=TestName1&lastName=TestName2";
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = NSURLSession.sharedSession();
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!
            print("Data: \(urlContent)");
        });
        
        task.resume();
        
        
        
        
        
        // URL to send registration information
        let APP_SERVER_URL = "http://hackathon.bobwhite.ca/android/insertuser.php";
        
        
        //let APP_SERVER_URL = "http://hackathon.bobwhite.ca/GCM/gcm.php?shareRegId=true";
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        firstNameLabel.textColor = UIColor.orangeColor()
        emailLabel.textColor = UIColor.orangeColor()
        passwordLabel.textColor = UIColor.orangeColor()
        
        
        registerButton.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

