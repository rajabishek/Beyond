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

    @IBOutlet weak var emailAddressTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet weak var registerButton: SpringButton!
    
    @IBOutlet weak var registrationContainer: UIStackView!
    
    let manager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessage.text = ""
    }
    
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluateWithObject(testStr)
    }
    
    func presentInvalidRegistrationAlert(message: String) {
        errorMessage.text = message
        registerButton.animation = "shake"
        registerButton.animate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerButtonWasPressed(sender: UIButton) {
        
        if let email = emailAddressTextField.text, let password = passwordTextField.text, let confirm = confirmPasswordTextField.text {
            
            if email == "" || password == "" || confirm == "" {
                presentInvalidRegistrationAlert("Please fill in all the fields")
            } else if !isValidEmail(email) {
                presentInvalidRegistrationAlert("Email address seems to be invalid")
            }
            else if password != confirm {
                presentInvalidRegistrationAlert("The passwords do not match")
            } else {
                errorMessage.text = ""
                manager.signupWithName("Raj Abishek", email: email, password: password, confirm: confirm) { error, token in
                    print(token)
                }
                print("Send the user data to the server.")
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
