//
//  LoginViewController.swift
//  Beyond
//
//  Created by Raj Abishek on 20/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import UIKit
import Spring

class LoginViewController: UIViewController {

    @IBOutlet weak var errorMessageTextLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: SpringButton!
    
    let manager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessageTextLabel.text = ""
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentInvalidLoginAlert(message: String) {
        errorMessageTextLabel.text = message
        loginButton.animation = "shake"
        loginButton.animate()
    }
    
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluateWithObject(testStr)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true);
    }

    @IBAction func loginButtonWasPressed(sender: AnyObject) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            if email == "" || password == "" {
                presentInvalidLoginAlert("Please fill in all the fields")
            } else if !isValidEmail(email) {
                presentInvalidLoginAlert("Email address seems to be invalid")
            } else {
                errorMessageTextLabel.text = ""
                manager.loginWithEmail(email, password: password) { error, token in
                    if error != nil {
                        self.presentInvalidLoginAlert(error!)
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
