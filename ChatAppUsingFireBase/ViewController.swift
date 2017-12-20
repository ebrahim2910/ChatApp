//
//  ViewController.swift
//  ChatAppUsingFireBase
//
//  Created by Admin on 12/18/17.
//  Copyright © 2017 ITI. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

   

    func userLogin() {
    
    
        Auth.auth().signInAnonymously() {  (user , error) in
        
        let userAnonymous  = user?.isAnonymous
            if userAnonymous == true {
            
            let uid = user?.uid
                
                print("userId \(uid)")
            
            
            
            }
        
        }
    
    }
    
    
}

