//
//  ViewController.swift
//  social
//
//  Created by Remi Guillard on 16/10/2017.
//  Copyright © 2017 Remi Guillard. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func FbBtnTapped(_ sender: Any) {
        let fbLogin = FBSDKLoginManager()
        
        fbLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil{
                print("JESS: UNABLE TO AUTH FB")
            }else if result?.isCancelled == true{
                print("JESS: USER CANNCELED FB AUTH")
            }else{
                print("JESS: SUCESS AUTH WITH FB")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuthenticate(credential)
            }
        }

    }
    func firebaseAuthenticate(_ credential: AuthCredential){
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if error != nil{
                print("JESS: unable")
            }else{
                print("JESS: Sucess auth with firebase")
            }
        })
    }
    
}

