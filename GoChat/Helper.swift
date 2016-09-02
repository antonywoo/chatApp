//
//  Helper.swift
//  GoChat
//
//  Created by Cex on 29/08/2016.
//  Copyright © 2016 newmediatechies. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import GoogleSignIn

class Helper {
    static let helper = Helper() // instance of the helper class
    
    func anonLogin() {
        print("anon")
        self.switchToNavigationViewController()
        
        FIRAuth.auth()?.signInAnonymouslyWithCompletion({ (anonymousUser:FIRUser?, error: NSError?) in
            if error == nil {
                print("userId: \(anonymousUser!.uid)")
                
                
            } else {
                print(error!.localizedDescription)
                return
            }
        })
    }
    
    func loginGoogle(authentication: GIDAuthentication) {
        let credential = FIRGoogleAuthProvider.credentialWithIDToken(authentication.idToken, accessToken: authentication.accessToken)
        
        FIRAuth.auth()?.signInWithCredential(credential, completion: { (user: FIRUser?, error: NSError?) in
            if error != nil {
                print(error!.localizedDescription)
                return
            } else {
                print(user?.email)
                print(user?.displayName)
                self.switchToNavigationViewController()
            }
        })
    }
    
    private func switchToNavigationViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let naviVC = storyboard.instantiateViewControllerWithIdentifier("NavigationVC") as! UINavigationController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = naviVC
    }
    
}