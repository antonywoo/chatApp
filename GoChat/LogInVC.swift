//
//  ViewController.swift
//  GoChat
//
//  Created by Cex on 29/08/2016.
//  Copyright © 2016 newmediatechies. All rights reserved.
//

import UIKit
import GoogleSignIn

class LogInVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    @IBOutlet weak var anonBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        anonBtn.layer.borderWidth = 2.0
        anonBtn.layer.borderColor = UIColor.whiteColor().CGColor
        GIDSignIn.sharedInstance().clientID = "136872561099-5ss9doavac5kuq0p4ofnqt5ui3buq50c.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func anonLogin(sender: AnyObject) {
        print("anon")
            Helper.helper.anonLogin() //use in replace of firebase, so easier to change code if firebase shuts down (like parse)
    }
    
    @IBAction func googleLogin(sender: AnyObject) {
        print("google")
        GIDSignIn.sharedInstance().signIn()
  
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        print(user.authentication)
        Helper.helper.loginGoogle(user.authentication)
    }


}

