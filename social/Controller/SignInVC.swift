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

    var dict : [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func FbBtnTapped(sender: Any) {
        /*let fbLogin = FBSDKLoginManager()
        
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
        }*/
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                        self.firebaseAuthenticate(credential)
                        fbLoginManager.logOut()
                    }
                }
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print(result!)
                    print(self.dict)
                }
            })
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

