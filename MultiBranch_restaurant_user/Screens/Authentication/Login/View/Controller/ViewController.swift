//
//  ViewController.swift
//  MultiBranch_restaurant_user
//
//  Created by aftab khan on 01/10/2025.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    private let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
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
            let product = AddProduct(email: "aftabkhan@gmail.com", password: "123456")
            viewModel.addProduct(parameters: product)
        }
        
    }
}

