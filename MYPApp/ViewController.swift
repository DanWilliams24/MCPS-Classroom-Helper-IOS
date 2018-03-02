//
//  ViewController.swift
//  MYPApp
//
//  Created by Daniel on 1/28/18.
//  Copyright © 2018 Daniel Williams. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var username = ""
    var password = ""
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInButtonPressed(_ sender: Any) {
        username = usernameField.text!
        password = passwordField.text!
        Auth.auth().signIn(withEmail: username, password: password) { (user, error) in
            // ...
           
        }
        
        
    }
    
}

