//
//  ShareViewController.swift
//  PuzzleGame
//
//  Created by Consultant on 12/8/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit
//import FacebookShare
//import FacebookCore
import FacebookLogin
import FBSDKShareKit

class ShareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBLoginButton(permissions: [.publicProfile, .email])
        loginButton.center = view.center
        loginButton.delegate = self
        // view.addSubview(shareBtn)
        view.addSubview(loginButton)
    }
    

    @IBAction func shareButtonAction(_ sender: Any) {
       // postToPage("Best Puzzle Game App!!")
        
        //FBSDKShareLinkContent
        //let content = fbc
    }
}


extension ShareViewController: LoginButtonDelegate{
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let err = error {
            print("Error while signin : \(err)")
            return
        }
        guard let result = result else {
            print("There was no result returned")
            return
        }
        
        if result.token != nil && result.isCancelled == false {
            //user signed in successfully
           // postToPage("Best game App!!")
            performSegue(withIdentifier: "toMessages", sender: nil)
        }
        else{
            print("User cancelled or no token received")
            return
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("User did sign out")
    }
    
}






