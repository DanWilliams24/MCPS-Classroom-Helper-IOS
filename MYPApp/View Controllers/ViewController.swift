//
//  ViewController.swift
//  MYPApp
//
//  Created by Daniel on 1/28/18.
//  Copyright © 2018 Daniel Williams. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    var username = ""
    var password = ""
    
    @IBOutlet weak var WelcomeLabel: UILabel!
    @IBOutlet weak var SignInView: UIView!
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        SignInView.alpha = 0;
        super.viewDidLoad()
        //usernameField.
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signInButtonPressed(_ sender: Any) {
        if let username  = usernameField.text, let password = passwordField.text {
            let email = username + "@mcpsmd.net"
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user,error) in
                if error == nil {
                    //perform segue
                    
                    self.WelcomeLabel.text = username
                    self.SignInView.fadeIn(completion: { (finished: Bool) -> Void in
                        sleep(2) //Should switch this with actual timer
                        self.performSegue(withIdentifier: "SignIn", sender: nil)
                    })
                    
                }else {
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("Unable to sign in user")
                            self.WelcomeLabel.text = "Error"
                            
                            self.SignInView.backgroundColor = UIColor.red
                            self.SignInView.fadeIn(completion: { (finished: Bool) -> Void in
                                self.SignInView.fadeOut()
                            })
                        }else{
                            //perform segue
                            self.WelcomeLabel.text = username
                            self.SignInView.fadeIn(completion: { (finished: Bool) -> Void in
                                self.performSegue(withIdentifier: "SignIn", sender: nil)
                            })
                        }
                    })
                }
                
            })
        }
        
        
    }
    
    
    
}

