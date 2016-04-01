//
//  RegisterViewController.swift
//  Beyond
//
//  Created by Raj Abishek on 20/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import UIKit
import Spring

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var errorMessageTextLabel: UILabel!
    
    @IBOutlet weak var registerButton: SpringButton!
    
    let manager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessageTextLabel.text = ""
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluateWithObject(testStr)
    }
    
    func presentInvalidRegistrationAlert(message: String) {
        errorMessageTextLabel.text = message
        registerButton.animation = "shake"
        registerButton.animate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerButtonWasPressed(sender: UIButton) {
        
        if let username = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let confirm = confirmPasswordTextField.text {
            
            if username == "" || email == "" || password == "" || confirm == "" {
                presentInvalidRegistrationAlert("Please fill in all the fields")
            } else if !isValidEmail(email) {
                presentInvalidRegistrationAlert("Email address seems to be invalid")
            }
            else if password != confirm {
                presentInvalidRegistrationAlert("The passwords do not match")
            } else {
                errorMessageTextLabel.text = ""
                manager.signupWithName(username, email: email, password: password, confirm: confirm) { error, token in
                    if error != nil {
                        self.presentInvalidRegistrationAlert(error!)
                    } else {
                        AuthManager.setToken(token!)
                        self.performSegueWithIdentifier("presentHomeScreen", sender: self)
                    }
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
