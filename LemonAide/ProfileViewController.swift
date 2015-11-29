//
//  ProfileViewController.swift
//  LemonAide
//
//  Created by Bob White on 2015-11-29.
//  Copyright © 2015 Bob White. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func registerButtonAction(sender: AnyObject)
    {
        self.performSegueWithIdentifier("addVehicleSegue", sender: self)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        registerButton.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
    
        // Read data (from local)
        if let fName = NSUserDefaults.standardUserDefaults().objectForKey("fName")
        {
            welcomeLabel.text = "Hello, \(fName)"
        }

        
        
        
        
        
    }
    
}
