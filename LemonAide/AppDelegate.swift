//
//  AppDelegate.swift
//  LemonAide
//
//  Created by Bob White on 2015-11-28.
//  Copyright © 2015 Bob White. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, GGLInstanceIDDelegate, GCMReceiverDelegate {

    var window: UIWindow?
    
    var connectedToGCM = false
    var subscribedToTopic = false
    var gcmSenderID: String?
    var registrationToken: String?
    var registrationOptions = [String: AnyObject]()
    
    let registrationKey = "onRegistrationCompleted"
    let messageKey = "onMessageReceived"
    let subscriptionTopic = "/topics/global"
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        let settings: UIUserNotificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        
        let gcmConfig = GCMConfig.defaultConfig()
        gcmConfig.receiverDelegate = self
        GCMService.sharedInstance().startWithConfig(gcmConfig)
           
        return true
    }
   
    
    
    func onTokenRefresh()
    {
        // A rotation of the registration tokens is happening, so the app needs to request a new token.
        print("The GCM registration token needs to be changed.")
        
        GGLInstanceID.sharedInstance().tokenWithAuthorizedEntity(gcmSenderID, scope: kGGLInstanceIDScopeGCM, options: registrationOptions, handler: registrationHandler)
    }
    
    
    func application( application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData )
    {
            // Create a config and set a delegate that implements the GGLInstaceIDDelegate protocol.
            let instanceIDConfig = GGLInstanceIDConfig.defaultConfig()
            instanceIDConfig.delegate = self
        
            // Start the GGLInstanceID shared instance with that config and request a registration
            // token to enable reception of notifications
            GGLInstanceID.sharedInstance().startWithConfig(instanceIDConfig)
            registrationOptions = [kGGLInstanceIDRegisterAPNSOption:deviceToken, kGGLInstanceIDAPNSServerTypeSandboxOption:true]
            GGLInstanceID.sharedInstance().tokenWithAuthorizedEntity(gcmSenderID, scope: kGGLInstanceIDScopeGCM, options: registrationOptions, handler: registrationHandler)
    }
    
    func registrationHandler(registrationToken: String!, error: NSError!)
    {
        if (registrationToken != nil)
        {
            self.registrationToken = registrationToken
            print("Registration Token: \(registrationToken)")
            
            self.subscribeToTopic()
            
            let userInfo = ["registrationToken": registrationToken]
            NSNotificationCenter.defaultCenter().postNotificationName(
                self.registrationKey, object: nil, userInfo: userInfo)
        }
        else
        {
            print("Registration to GCM failed with error: \(error.localizedDescription)")
        }
    }
    
    func updateRegistrationStatus(notification: NSNotification)
    {
        if let info = notification.userInfo as? Dictionary<String,String>
        {
            if let error = info["error"]
            {
                print("Error registering!")
                
                showAlert("Error registering with GCM", message: error)
            }
            else if let _ = info["registrationToken"]
            {
                print("Registered!")
                
                let message = "Check the xcode debug console for the registration token that you " +
                " can use with the demo server to send notifications to your device"
                showAlert("Registration Successful!", message: message)
            }
        }
        else
        {
            print("Software failure. Guru meditation.")
        }
    }
    
    func subscribeToTopic()
    {
        // If the app has a registration token and is connected to GCM, proceed to subscribe to the topic
        if(registrationToken != nil && connectedToGCM)
        {
            GCMPubSub.sharedInstance().subscribeWithToken(self.registrationToken, topic: subscriptionTopic, options: nil, handler: {(NSError error) -> Void in
                if (error != nil)
                {
                    // Treat the "already subscribed" error more gently
                    if error.code == 3001
                    {
                        print("Already subscribed to \(self.subscriptionTopic)")
                    }
                    else
                    {
                        print("Subscription failed: \(error.localizedDescription)");
                    }
                }
                else
                {
                    self.subscribedToTopic = true;
                    
                    print("Subscribed to \(self.subscriptionTopic)");
                }
            })
        }
    }
    
    func showReceivedMessage(notification: NSNotification)
    {
        if let info = notification.userInfo as? Dictionary<String,AnyObject>
        {
            if let aps = info["aps"] as? Dictionary<String, String>
            {
                showAlert("Message received", message: aps["alert"]!)
            }
        }
        else
        {
            print("Software failure. Guru meditation.")
        }
    }
    
    func showAlert(title:String, message:String) {
        
            let alert = UIAlertController(title: title,
                message: message, preferredStyle: .Alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .Destructive, handler: nil)
        
            alert.addAction(dismissAction)
        
            //self.presentViewController(alert, animated: true, completion: nil)
       
    }
    
        
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

