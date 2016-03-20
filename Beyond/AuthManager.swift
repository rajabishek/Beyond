//
//  AuthManager.swift
//  Beyond
//
//  Created by Raj Abishek on 20/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import Foundation
import Alamofire

class AuthManager {
    
    let baseUrl = "http://begin.dev/api/v1"
    
    func loginWithEmail(email: String, password: String) {
        
        Alamofire.request(.POST, "\(baseUrl)/login", parameters: ["email": email, "password": password])
            .responseData { response in
                print(response.result)
        }
    }
    
    func signupWithName(name: String, email: String, password: String, confirm: String, callback: (errorMessage: String?, token: String?) -> Void) {
        
        Alamofire.request(.POST, "\(baseUrl)/register", parameters: ["name": name, "email": email, "password": password, "password_confirmation": confirm])
            .responseData { response in
                print(response.result)
                //callback(nil, "This is the token")
        }
    }
}
