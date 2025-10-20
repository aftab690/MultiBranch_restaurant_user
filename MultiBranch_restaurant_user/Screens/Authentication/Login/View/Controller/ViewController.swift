//
//  ViewController.swift
//  MultiBranch_restaurant_user
//
//  Created by aftab khan on 01/10/2025.
//

import UIKit
import Alamofire
import MBProgressHUD
import FBSDKLoginKit

class ViewController: UIViewController, LoginButtonDelegate{
    
    
    func loginButton(_ loginButton: FBSDKLoginKit.FBLoginButton, didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?, error: (any Error)?) {
        
        
        let token = result?.token?.tokenString
        
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields" : "email, name"], tokenString: token, version: nil, httpMethod: .get)
        
        request.start(completion: { connection, result, error in
            print("\(result)")
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        
    }
    

    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    private let viewModel = LoginViewModel()
    @IBOutlet weak var btn_showPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let token = AccessToken.current, !token.isExpired {
            // User is logged in, do work such as go to next view controller.
            // You can make a Graph API request here to fetch user data
            
            let token = token.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields" : "email, name"], tokenString: token, version: nil, httpMethod: .get)
            
            request.start(completion: { connection, result, error in
                print("\(result)")
                print("\(error)")
            })
        }
        
        
        
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        loginButton.delegate = self
        view.addSubview(loginButton)
        loginButton.permissions = ["public_profile", "email"]
        observeEvent()
    }


    
    @IBAction func btn_signup(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(identifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_login(_ sender: UIButton){
        if self.txt_Email.text! == "" || self.txt_Password.text! == "" {
            showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: "Please enter all details")
        }
        else if isValidateEmail(email: self.txt_Email.text!) == false {
            showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: "Please enter valid email address")
        }else{
            let product = AddProduct(email: txt_Email.text!, password: txt_Password.text!)
            viewModel.addProduct(parameters: product)
        }
    }
    

    @IBAction func btnTap_ShowPassword(_ sender: UIButton) {
        if self.btn_showPassword.image(for: .normal) == UIImage(systemName: "eye.fill") {
            self.btn_showPassword.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            self.txt_Password.isSecureTextEntry = false
        }
        else {
            self.txt_Password.isSecureTextEntry = true
            self.btn_showPassword.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    
    
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }

            switch event {
            case .loading:
                /// Indicator show
                DispatchQueue.main.async {
                    MBProgressHUD.showAdded(to: self.view, animated: true)
                }
                print("Product loading....")
            case .stopLoading:
                // Indicator hide kardo
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for:self.view, animated: true)
                }
                print("Stop loading...")
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    // UI Main works well
                    if self.viewModel.loginResponse?.status == 1 {
                        
                    }else if self.viewModel.loginResponse?.status == 2 {
                        
                    }else {
                        showAlertMessage(titleStr: Bundle.main.displayName!, messageStr:
                        self.viewModel.loginResponse?.message ?? "")
                    }
                    
                }
            case .error(let error):
                print(error)
            case .newProductAdded(let newProduct):
                print(newProduct)
            }
        }
    }
    
}

