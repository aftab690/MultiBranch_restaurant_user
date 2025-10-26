//
//  LoginViewModel.swift
//  MultiBranch_restaurant_user
//
//  Created by aftab khan on 07/10/2025.
//

import Foundation
import FBSDKLoginKit
import FBSDKCoreKit

final class LoginViewModel{
    var loginResponse: LoginResponse?
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
//    weak var delegate: LoginFlowDelegate?
    
    private let loginManager = LoginManager()
    var onUserLoggedIn: ((SignupRequest) -> Void)?
    var onError: ((String) -> Void)?
    var onLogout: (() -> Void)?
    
    
    
    
    
    func loginWithFacebook(from vc: UIViewController) {
        // ... Facebook SDK logic ...
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: vc) { (result, error) -> Void in
            
        if let error = error {
            self.onError?(error.localizedDescription)
            return
            }

        guard let result = result, !result.isCancelled else {
            self.onError?("Login cancelled by user")
            return
        }
        if result.grantedPermissions.contains("email"){
            self.getFBUserData()
        }
        }
    }
    
    
    
    func getFBUserData(){
            if(AccessToken.current) != nil{
                let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields" : "email, name"], tokenString: AccessToken.current?.tokenString, version: nil, httpMethod: .get)
                request.start(completion: { connection, result, error in
                    print("\(result)")
                    if let error = error {
                       self.onError?(error.localizedDescription)
                       return
                    }
    
                    let responseData = result as! NSDictionary
                    let facebookId = responseData["id"] as! String
                    let name = responseData["name"] as! String
                    var email = ""
                    if responseData["email"] != nil {
                        email = responseData["email"] as! String
                    }
                    
                    // On success:
                    let user = SignupRequest(name: name, email: email, mobile: "", token: "xyzDeviceToken123",google_id: "", facebook_id: facebookId, login_type: "facebook")
                    self.UserSignup(parameters: user)
//                    self.onUserLoggedIn?(user)
//                    print(user)
                })
                

            }

      }
    
    func UserSignup(parameters: SignupRequest){
            APIManager.shared.request(
                modelType: SignupResponse.self, // response type
                type: ProductEndPoint.userSignup(userSignup: parameters)) { result in
                    switch result {
                    case .success(let product):
                        print(product)
    //                    self.eventHandler?(.newProductAdded(product: product))
                    case .failure(let error):
                        self.eventHandler?(.error(error))
                    }
                }
        }
    
    
    func logout() {
           loginManager.logOut()
           onLogout?()
       }
    
    
    func addProduct(parameters: AddProduct){
        self.eventHandler?(.loading)
        APIManager.shared.request(
            modelType: LoginResponse.self, // response type
            type: ProductEndPoint.addProduct(product: parameters)) { result in
                self.eventHandler?(.stopLoading)
                switch result {
                case .success(let loginResponse):
                    self.loginResponse = loginResponse
                    print(self.loginResponse)
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
    
}

extension LoginViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        case newProductAdded(product: AddProduct)
    }

}
