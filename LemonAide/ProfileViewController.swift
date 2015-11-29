//
//  ProfileViewController.swift
//  LemonAide
//
//  Created by Bob White on 2015-11-29.
//  Copyright © 2015 Bob White. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var vehicle1: UILabel!
    @IBOutlet weak var vehicle2: UILabel!
    @IBOutlet weak var vehicle3: UILabel!
    @IBOutlet weak var vehicle4: UILabel!
    @IBOutlet weak var vehicle5: UILabel!
    
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

        let make1 = NSUserDefaults.standardUserDefaults().objectForKey("make1")
        let make2 = NSUserDefaults.standardUserDefaults().objectForKey("make2")
        let make3 = NSUserDefaults.standardUserDefaults().objectForKey("make3")
        let make4 = NSUserDefaults.standardUserDefaults().objectForKey("make4")
        let make5 = NSUserDefaults.standardUserDefaults().objectForKey("make5")
        
        let model1 = NSUserDefaults.standardUserDefaults().objectForKey("model1")
        let model2 = NSUserDefaults.standardUserDefaults().objectForKey("model2")
        let model3 = NSUserDefaults.standardUserDefaults().objectForKey("model3")
        let model4 = NSUserDefaults.standardUserDefaults().objectForKey("model4")
        let model5 = NSUserDefaults.standardUserDefaults().objectForKey("model5")
        
        let year1 = NSUserDefaults.standardUserDefaults().objectForKey("year1")
        let year2 = NSUserDefaults.standardUserDefaults().objectForKey("year2")
        let year3 = NSUserDefaults.standardUserDefaults().objectForKey("year3")
        let year4 = NSUserDefaults.standardUserDefaults().objectForKey("year4")
        let year5 = NSUserDefaults.standardUserDefaults().objectForKey("year5")
        
        if (make1 != nil)
        {
            vehicle1.text = "\(make1!) \(model1!) \(year1!)"
        }
        
        if (make2 != nil)
        {
            vehicle2.text = "\(make2!) \(model2!) \(year2!)"
        }
        
        if (make3 != nil)
        {
            vehicle3.text = "\(make3!) \(model3!) \(year3!)"
        }
        
        if (make4 != nil)
        {
            vehicle4.text = "\(make4!) \(model4!) \(year4!)"
        }
        
        if (make5 != nil)
        {
            vehicle5.text = "\(make5!) \(model5!) \(year5!)"
        }
    }
}
