//
//  AccountVC.swift
//  My Calculator
//
//  Created by Diparth Patel on 6/15/17.
//  Copyright © 2017 Diparth Patel. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn



class AccountVC: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var imgBG: UIView!
    @IBOutlet weak var profimage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var loginButton: GIDSignInButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    var isUserLoggedIn = false
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.layer.cornerRadius = 25
        imgBG.layer.cornerRadius = imgBG.frame.size.width/2
        profimage.layer.cornerRadius = profimage.frame.size.width/2
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        
        if userDefaults.value(forKey: "isUserLoggedIn") != nil {
            isUserLoggedIn = userDefaults.bool(forKey: "isUserLoggedIn")
            GIDSignIn.sharedInstance().signInSilently()
            rotateLoginView()
        }else {
            rotateLoginView()
        }
        
        
        // Do any additional setup after loading the view.
    }

    
    
    
    
    
    
    func rotateLoginView() {
        if !isUserLoggedIn {
            self.userView.isHidden = true
            self.userView.isUserInteractionEnabled = false
            
            self.loginView.isHidden = false
        }else {
            self.userView.isHidden = false
            self.userView.isUserInteractionEnabled = true
            
            self.loginView.isHidden = true
        }
    }
    
    
    //MARK: Authentication methods

    
    
    @IBAction func loginPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            let alertView = UIAlertController.init(title: "Oops!", message: "Login did not go through. Try Again.", preferredStyle: .alert)
            alertView.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
            self.present(alertView, animated: true, completion: nil)
        }else {
            if user != nil {
                let fullname = "\((user.profile.givenName!).capitalized) \((user.profile.familyName!).capitalized)"
                print("User has been loggen in: \(fullname)")
                
                userName.text = fullname
                profimage.image = UIImage.init(data: try! Data.init(contentsOf: user.profile.imageURL(withDimension: 200)))
                
                isUserLoggedIn = true
                userDefaults.set(true, forKey: "isUserLoggedIn")
                userDefaults.synchronize()
                rotateLoginView()
            }
        }
    }
    
    
    
    
    @IBAction func logoutPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        isUserLoggedIn = false
        userDefaults.set(false, forKey: "isUserLoggedIn")
        userDefaults.synchronize()
        rotateLoginView()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
