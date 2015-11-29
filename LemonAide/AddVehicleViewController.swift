//
//  AddVehicleViewController.swift
//  LemonAide
//
//  Created by Bob White on 2015-11-29.
//  Copyright © 2015 Bob White. All rights reserved.
//

import UIKit

class AddVehicleViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var makeTextbox: UITextField!
    @IBOutlet weak var modelTextbox: UITextField!
    @IBOutlet weak var yearTextbox: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func addButtonAction(sender: AnyObject)
    {
        if let userID = NSUserDefaults.standardUserDefaults().objectForKey("userID")
        {
            // Send user data to remote server
            let request = NSMutableURLRequest(URL:URL_VEHICLE!)
            request.HTTPMethod = "POST";
            
            let postString = "userId=\(userID)&makeId=\(makeTextbox.text!)&modelId=\(modelTextbox.text!)&yearId=\(yearTextbox.text!)";
            
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
            
            let session = NSURLSession.sharedSession();
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                
                let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!
                
                NSUserDefaults.standardUserDefaults().setObject(urlContent, forKey: "userID")
            });
            
            task.resume();
            
            // Save vehicle on local device
            storedVehicleCount = NSUserDefaults.standardUserDefaults().integerForKey("vehiclecount") + 1
            
            NSUserDefaults.standardUserDefaults().setObject(userID, forKey: "userID\(storedVehicleCount)")
            NSUserDefaults.standardUserDefaults().setObject(makeTextbox.text!, forKey: "make\(storedVehicleCount)")
            NSUserDefaults.standardUserDefaults().setObject(modelTextbox.text!, forKey: "model\(storedVehicleCount)")
            NSUserDefaults.standardUserDefaults().setObject(yearTextbox.text!, forKey: "year\(storedVehicleCount)")
            NSUserDefaults.standardUserDefaults().setInteger(storedVehicleCount, forKey: "vehiclecount")
            
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Set delegates to self
        self.makeTextbox.delegate = self
        self.modelTextbox.delegate = self
        self.yearTextbox.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
