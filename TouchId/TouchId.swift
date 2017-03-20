//
//  TouchId.swift
//  TouchId
//
//  Created by Andrew McCalla on 4/19/16.
//

import UIKit
import LocalAuthentication

open class TouchId {
    
    open static var successfulAuthentication = false
    
    /**
     Displays Touch ID prompt for authentication, if device doesn't support it, ask for password
     
     - parameter targetVC: The view controller to pass.
     - parameter passwordAlertTitle: The title of the password prompt (i.e. app name).
     - parameter passwordAlertBody: The body of text for the password prompt.
     - parameter password: The password to compare a user's entry to for access.
     */
    
    open static func authenticateUser(_ targetVC: UIViewController, passwordAlertTitle: String, passwordAlertBody: String, password: String) {
        let context: LAContext = LAContext()
        var error: NSError?
        let policyReason = "Authentication is required"
        
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: policyReason, reply: { (success : Bool, evaluationError : NSError?) -> Void in
                if success {
                    OperationQueue.main.addOperation({ () -> Void in
                    })
                } else {
                    OperationQueue.main.addOperation({ () -> Void in
                        self.showPasswordAlert(targetVC, alertTitle: passwordAlertTitle, alertBody: passwordAlertBody, password: password)
                    })
                }
            } as! (Bool, Error?) -> Void)
        } else {
            showPasswordAlert(targetVC, alertTitle: passwordAlertTitle, alertBody: passwordAlertBody, password: password)
        }
    }
    
    /**
     Displays password prompt for authentication
     
     - parameter targetVC: The view controller to pass.
     - parameter alertTitle: The title of the password prompt (i.e. app name).
     - parameter alertBody: The body of text for the password prompt.
     - parameter password: The password to compare a user's entry to for access.
     */

    internal static func showPasswordAlert(_ targetVC: UIViewController, alertTitle: String, alertBody: String, password: String) {
        let alertController = UIAlertController(title: alertTitle , message: alertBody, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Submit", style: .default) { (action) -> Void in
            let passwordTextField = alertController.textFields![0] as UITextField
            self.verifyLogin(targetVC, alertTitle: alertTitle, alertBody: alertBody, entry: passwordTextField.text!, password: password)
        }
        doneAction.isEnabled = false
        
        alertController.addTextField { (textField) -> Void in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textField, queue: OperationQueue.main, using: { (notification) -> Void in
                doneAction.isEnabled = textField.hasText
            })
        }
        alertController.addAction(doneAction)
        targetVC.present(alertController, animated: true, completion: nil)
    }
    
    /**
     Makes a comparison between a user's entry and the password for authentication.
     
     - parameter targetVC: The view controller to pass.
     - parameter alertTitle: The title of the password prompt (i.e. app name).
     - parameter alertBody: The body of text for the password prompt.
     - parameter entry: The user's input.
     - parameter password: The password to compare a user's entry to for access.
     */
    
    internal static func verifyLogin(_ targetVC: UIViewController, alertTitle: String, alertBody: String, entry: String, password: String) {
        if entry != password {
            self.showPasswordAlert(targetVC, alertTitle: alertTitle, alertBody: "Password Incorrect", password: password)
        } else {
            successfulAuthentication = true
            targetVC.viewDidAppear(true)
        }
    }
}
