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
import FBSDKCoreKit

class ViewController: UIViewController{
    
    

    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    private let viewModel = LoginViewModel()
    @IBOutlet weak var btn_showPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeEvent()
        setupBindings()
    }
    
    
    private func setupBindings() {
        viewModel.onUserLoggedIn = { [weak self] user in

            DispatchQueue.main.async {
                
            }

        }

        viewModel.onError = { [weak self] message in
            DispatchQueue.main.async {
                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: message)
            }
        }
    }

    @IBAction func btnTap_Facebook(_ sender: Any) {
        viewModel.loginWithFacebook(from: self)
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

