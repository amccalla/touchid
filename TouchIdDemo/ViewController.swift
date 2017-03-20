//
//  ViewController.swift
//  TouchIdDemo
//
//  Created by Andrew McCalla on 4/19/16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //If 'successfulAuthentication' is false, reload the touch id and/or password prompt
        //
        if !TouchId.successfulAuthentication {
            TouchId.authenticateUser(self, passwordAlertTitle: "demo", passwordAlertBody: "enter password", password: "123")
        } else {
            //authentication was a success
            //execute your code
            //
        }
    }
}

