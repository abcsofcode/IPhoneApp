//
//  AddVehicleViewController.swift
//  LemonAide
//
//  Created by Bob White on 2015-11-29.
//  Copyright © 2015 Bob White. All rights reserved.
//

import UIKit

class AddVehicleViewController: UIViewController {

    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var makeTextbox: UITextField!
    @IBOutlet weak var modelTextbox: UITextField!    
    @IBOutlet weak var yearTextbox: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
