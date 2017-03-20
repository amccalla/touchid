TouchId
===============

TouchId allows for full touch id integration for local authentication.

<br/>

### Requirements
TouchId works on iOS 8.0 and greater. It requires Xcode 8.0 or greater, as it uses Swift 3.0.
<br/>

### Usage
Setting up the touch id prompt along with a password prompt (for handling lack of support of touch id or if the user selects 'Cancel') is done using the authenticateUser() function.  Place this function in the viewDidAppear() method of a view controller, so that the alert controller isn't displayed on a detached view:
    
    func authenticateUser(targetVC: UIViewController, passwordAlertTitle: String, passwordAlertBody: String, password: String) 

The first parameter is the view controller.  The second parameter is for the password prompt title.  The third parameter is the body text of the password prompt.  The fourth parameter is the password to compare to the user's entry for authentication.

The 'successfulAuthentication' boolean variable is used to check if authentication was passed or not, so the user can execute code accordingly:
    
    public static var successfulAuthentication

Below is an example implementation:

    override func viewDidAppear(animated: Bool) {
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
